package database

import (
	"context"
	"log"
	"scps-backend/pkg"

	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"go.mongodb.org/mongo-driver/mongo/readpref"
)

var db_opt = pkg.GET_DB_SERVER_SEETING()

type Database interface {
	Collection(string) Collection
	Client() Client
}

type Collection interface {
	InsertOne(context.Context, interface{}) (interface{}, error)
	DeleteOne(context.Context, interface{}) (*mongo.DeleteResult, error)
	FindOne(context.Context, interface{}) SingleResult
	Find(context.Context, interface{}) (*mongo.Cursor, error)
	UpdateOne(context.Context, interface{}, interface{}, ...*options.UpdateOptions) (*mongo.UpdateResult, error)
}

type Client interface {
	Database(string) Database
	Connect(context.Context) error
	Disconnect(context.Context) error
	Ping(context.Context) error
}
type SingleResult interface {
	Decode(interface{}) error
}
type mongoSingleResult struct {
	sr *mongo.SingleResult
}
type mongoClient struct {
	cl *mongo.Client
}
type mongoDatabase struct {
	db *mongo.Database
}
type mongoCollection struct {
	coll *mongo.Collection
}

func (sr *mongoSingleResult) Decode(v interface{}) error {
	return sr.sr.Decode(v)
}

func NewClient(connection string) (Client, error) {
	serverAPI := options.ServerAPI(options.ServerAPIVersion1)
	c, err := mongo.NewClient(options.Client().ApplyURI(connection).SetServerAPIOptions(serverAPI))
	if err != nil {
		return nil, err
	}
	return &mongoClient{cl: c}, nil
}

func (mc *mongoClient) Ping(ctx context.Context) error {
	return mc.cl.Ping(ctx, readpref.Primary())
}

func (mc *mongoClient) Database(dbName string) Database {
	db := mc.cl.Database(dbName)
	return &mongoDatabase{db: db}
}

func (mc *mongoClient) Connect(ctx context.Context) error {
	return mc.cl.Connect(ctx)
}

func (mc *mongoClient) Disconnect(ctx context.Context) error {
	return mc.cl.Disconnect(ctx)
}

func (md *mongoDatabase) Collection(colName string) Collection {
	collection := md.db.Collection(colName)
	return &mongoCollection{coll: collection}
}

func (md *mongoDatabase) Client() Client {
	client := md.db.Client()
	return &mongoClient{cl: client}
}

func (mc *mongoCollection) InsertOne(ctx context.Context, document interface{}) (interface{}, error) {
	id, err := mc.coll.InsertOne(ctx, document)
	objectID := id.InsertedID.(primitive.ObjectID)
	return objectID.Hex(), err
}

func (mc *mongoCollection) FindOne(ctx context.Context, filter interface{}) SingleResult {
	singleResult := mc.coll.FindOne(ctx, filter)
	return &mongoSingleResult{sr: singleResult}
}

// Find implements Collection.
func (mc *mongoCollection) Find(ctx context.Context, filter interface{}) (*mongo.Cursor, error) {
	singleResult, err := mc.coll.Find(ctx, filter)
	if err != nil {
		log.Fatal(err)
		return nil, err
	}
	return singleResult, err
}

func (mc *mongoCollection) UpdateOne(ctx context.Context, filter interface{}, update interface{}, opts ...*options.UpdateOptions) (*mongo.UpdateResult, error) {
	return mc.coll.UpdateOne(ctx, filter, update, opts[:]...)
}

// DeleteOne implements Collection.
func (mc *mongoCollection) DeleteOne(ctx context.Context, filter interface{}) (*mongo.DeleteResult, error) {
	return mc.coll.DeleteOne(ctx, filter)
}

func ConnectionDb() Database {
	client, err := NewClient(db_opt.SERVER_ADDRESS_DB)
	if err != nil {
		log.Fatal(err)
	}
	ctx := context.TODO()
	err = client.Connect(ctx)
	if err != nil {
		log.Print("Connection error")
		log.Fatal(err)
	}
	err = client.Ping(ctx)
	if err != nil {
		log.Print("Ping error")
		log.Fatal(err)
	}
	log.Print("_________________________CONNECT TO DATABASE_________________________")
	return client.Database(db_opt.DB_NAME)
}
