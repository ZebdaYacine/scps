import 'package:app/core/entities/son_data.dart';
import 'package:app/core/entities/user_data.dart';
import 'package:app/core/entities/visit_data.dart';
import 'package:app/core/utils/snack_bar.dart';
import 'package:app/core/widgets/auth_field.dart';
import 'package:app/core/widgets/auth_gradient_button.dart';
import 'package:app/core/widgets/loading_bar.dart';
import 'package:app/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:app/feature/profile/presentation/cubit/token_cubit.dart';
import 'package:app/feature/profile/presentation/cubit/used_cubit.dart';
import 'package:app/feature/profile/presentation/widgets/choix.dart';
import 'package:app/feature/profile/presentation/widgets/list_ayant_doit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Pharmacy extends StatefulWidget {
  const Pharmacy({
    super.key,
  });

  @override
  State<Pharmacy> createState() => _PharmacyState();
}

class _PharmacyState extends State<Pharmacy> {
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
                showSnackBar(context, "no data available");
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
              const Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                children: [
                  Text(nameuserController.text),
                  Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: AuthField(
                          nameFiedl: "Mat",
                          controller: matController,
                          isPwdField: false,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: const Icon(
                            Icons.search,
                            size: 30,
                          ),
                          onPressed: () {
                            final token = context.read<TokenCubit>().getToken();
                            BlocProvider.of<ProfileBloc>(context).add(
                              GetInformationCardEvent(
                                token: token,
                                idsecurity: matController.text,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const Row(children: [
                    Expanded(
                      child: Choise(),
                    ),
                  ]),
                  BlocBuilder<UsedCubit, bool>(
                    builder: (context, state) {
                      if (state) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: AuthField(
                                    nameFiedl: "Nom",
                                    controller: nameuserController,
                                    isPwdField: false,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: AuthField(
                                    nameFiedl: "Nbr",
                                    controller: nbruserController,
                                    isPwdField: false,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ListAyantDroit(
                                    sons: [
                                      SonData(
                                        insurdNbr: "ndsfklds",
                                        name: "yassine",
                                        status: "dfd",
                                        nbr: 1,
                                        visits: [
                                          VisitData(nbr: 1, trimester: 1),
                                        ],
                                      ),
                                      SonData(
                                        insurdNbr: "d",
                                        name: "d",
                                        status: "dfdd",
                                        nbr: 1,
                                        visits: [
                                          VisitData(nbr: 1, trimester: 1),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: AuthField(
                                    nameFiedl: "Status",
                                    controller: statusController,
                                    isPwdField: false,
                                  ),
                                ),
                                Expanded(
                                  child: AuthField(
                                    nameFiedl: "Nom",
                                    controller: nameayantController,
                                    isPwdField: false,
                                  ),
                                ),
                                Expanded(
                                  child: AuthField(
                                    nameFiedl: "Nbr",
                                    controller: nbrayantController,
                                    isPwdField: false,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  AuthGradientButton(
                    buttonText: 'Validier',
                    onClick: () {
                      setState(() {});
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
