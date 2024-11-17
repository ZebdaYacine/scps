<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-ChiFFa - README</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f9;
            color: #333;
        }
        h1, h2, h4 {
            color: #0056b3;
        }
        pre {
            background-color: #f1f1f1;
            padding: 10px;
            border-radius: 5px;
            overflow-x: auto;
        }
        p {
            margin: 10px 0;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        .section {
            margin-bottom: 20px;
        }
        .code-block {
            background: #f0f0f0;
            padding: 10px;
            border-radius: 5px;
            white-space: pre-wrap;
        }
        img {
            max-width: 100%;
            height: auto;
            display: block;
            margin: 10px auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>E-ChiFFa</h1>
        <p>This guide provides instructions for running the E-ChiFFa application locally, including both backend and frontend components.</p>

        <div class="section">
            <h2>Backend Setup</h2>
            <p>To set up and run the backend locally, use the following commands:</p>
            <pre class="code-block">
$ cd backend
$ docker build -t app .
$ docker-compose up -d
$ docker run app
            </pre>
            <p><strong>Base URL of the API:</strong></p>
            <p>https://scps.onrender.com/{name-of-the-service}</p>
        </div>

        <div class="section">
            <h2>Frontend Setup</h2>
            <p>Follow these steps to set up and run the Flutter frontend locally:</p>
            <pre class="code-block">
# Download and install Flutter & SDK
$ cd frontend/app
$ flutter pub get
$ flutter run
            </pre>
        </div>

        <div class="section">
            <h4>Website Preview:</h4>
            <p align="center">
                <img src="web.png" width="700" alt="Web Application Preview">
            </p>
        </div>

        <div class="section">
            <h4>Mobile Application Preview:</h4>
            <p align="center">
                <img src="mobile.jpg" width="350" alt="Mobile Application Preview">
            </p>
        </div>
    </div>
</body>
</html>
