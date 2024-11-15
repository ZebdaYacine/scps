// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_const_constructors, library_private_types_in_public_api
import 'package:app/core/entities/user_data.dart';
import 'package:app/core/utils/snack_bar.dart';
import 'package:app/feature/profile/presentation/bloc/demand/demand_bloc_bloc.dart';
import 'package:app/core/state/auth/cubit/token_cubit.dart';
import 'package:app/feature/profile/presentation/pages/web/profile_page.dart';
import 'package:app/feature/profile/presentation/widgets/action_btn.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProveCard extends StatefulWidget {
  final UserData user;
  const ProveCard({
    super.key,
    required this.user,
  });

  @override
  State<ProveCard> createState() => _ProveCardState();
}

class _ProveCardState extends State<ProveCard> {
  String? imageUrl;

  final nameuserController = TextEditingController();
  @override
  void dispose() {
    nameuserController.dispose();
    super.dispose();
  }

  Future<void> _loadImage() async {
    try {
      logger.d(widget.user.link);
      String imagePath = widget.user.link;
      final ref = FirebaseStorage.instance.ref().child(imagePath);
      String downloadUrl = await ref.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
      });
    } catch (e) {
      print('Error fetching image: $e');
    }
  }

  // UserData _updateDemand(UserData data, bool request, String status) {
  //   data.request = request;
  //   data.status = status;
  //   return data;
  // }

  @override
  void initState() {
    super.initState();
    _loadImage();
    logger.d(context.read<TokenCubit>().getToken());
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<DemandBloc, DemandState>(
          listener: (context, state) {
            if (state is UpdateDemendsSuccess) {
              Navigator.of(context).pop();
              // context.read<StateRequestCubit>().setSateReq(state.status);
            } else if (state is UpdateDemendsFailure) {
              showSnackBar(context, state.error);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pièce justificative",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.cancel_outlined),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: imageUrl == null
                        ? const CircularProgressIndicator()
                        : SingleChildScrollView(
                            child: Image.network(
                              imageUrl!,
                              fit: BoxFit.fill,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ActionBtn(
                      callback: () async {
                        UserData userData = UserData(
                          insurdNbr: widget.user.insurdNbr,
                          name: widget.user.name,
                          email: widget.user.email,
                          phone: widget.user.phone,
                          request: true,
                          status: "accepted",
                          link: widget.user.link,
                          visits: widget.user.visits,
                        );
                        String? token =
                            await context.read<TokenCubit>().getToken();
                        context.read<DemandBloc>().add(
                              UpdateDemandsEvent(token: token!, user: userData),
                            );
                        // context.read<DemandBloc>().add(
                        //       GetAllPendingDemandsEvent(
                        //         token: token,
                        //       ),
                        //     );
                      },
                      color: const Color.fromARGB(255, 36, 141, 40),
                      icon: Icons.file_download_done,
                      title: "Accepter",
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ActionBtn(
                      callback: () async {
                        UserData userData = UserData(
                          insurdNbr: widget.user.insurdNbr,
                          name: widget.user.name,
                          email: widget.user.email,
                          phone: widget.user.phone,
                          request: true,
                          status: "rejected",
                          link: widget.user.link,
                          visits: widget.user.visits,
                        );
                        String? token =
                            await context.read<TokenCubit>().getToken();
                        context.read<DemandBloc>().add(
                              UpdateDemandsEvent(token: token!, user: userData),
                            );
                        
                      },
                      color: const Color.fromARGB(255, 228, 55, 43),
                      icon: Icons.cancel,
                      title: "Rejeter",
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
