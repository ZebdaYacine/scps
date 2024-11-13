import 'package:app/core/entities/user_data.dart';
import 'package:app/core/utils/snack_bar.dart';
import 'package:app/core/widgets/loading_bar.dart';
import 'package:app/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:app/feature/profile/presentation/widgets/alert_card.dart';
import 'package:app/feature/profile/presentation/widgets/prove.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemandList extends StatefulWidget {
  final List<UserData> demands;

  const DemandList({
    super.key,
    required this.demands,
  });

  @override
  State<DemandList> createState() => _DemandListState();
}

class _DemandListState extends State<DemandList> {
  final matController = TextEditingController();
  final nameuserController = TextEditingController();
  final nbruserController = TextEditingController();
  final nameayantController = TextEditingController();
  final nbrayantController = TextEditingController();
  final statusController = TextEditingController();
  UserData? userData;

  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> test = {};

  @override
  void dispose() {
    matController.dispose();
    nameuserController.dispose();
    nbruserController.dispose();
    nameayantController.dispose();
    nbrayantController.dispose();
    statusController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    logger.d(widget.demands.length);
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey; // Default color for unknown statuses
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSuccess) {
              userData = state.userData;
              if (userData == null) {
                showSnackBar(context, "No data available");
              } else {
                nameuserController.text = userData!.name;
                nbruserController.text = userData!.phone;
              }
            } else if (state is ProfileFailure) {
              showSnackBar(context, state.error);
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Loader();
            }
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "La list of les demandes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black87,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert_outlined, // Three-dot icon
                          size: 28.0,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.demands.length,
                    itemBuilder: (context, index) {
                      final demand = widget.demands[index];
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          title: Text(
                            demand.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            'Phone: ${demand.phone}',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black54,
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueAccent.shade100,
                            child: const Icon(
                              Icons.file_copy,
                              color: Colors.white,
                            ),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(demand.status),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              demand.status,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return ProveCard(
                                  Link: demand.link,
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
