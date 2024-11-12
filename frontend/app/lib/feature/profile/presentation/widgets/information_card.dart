// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_const_constructors, library_private_types_in_public_api
import 'package:app/core/entities/user_data.dart';
import 'package:app/core/entities/visit_data.dart';
import 'package:app/core/extension/extension.dart';
import 'package:app/feature/profile/presentation/widgets/insured.dart';
import 'package:flutter/material.dart';

class InformationCard extends StatelessWidget {
  final String title;
  final UserData informations;
  const InformationCard({
    super.key,
    required this.title,
    required this.informations,
  });

  int getCurrentTrimester() {
    DateTime now = DateTime.now();
    int month = now.month;
    if (month >= 1 && month <= 3) {
      return 1;
    } else if (month >= 4 && month <= 6) {
      return 2;
    } else if (month >= 7 && month <= 9) {
      return 3;
    } else {
      return 4;
    }
  }

  bool getStatus(List<VisitData> list) {
    List<VisitData> filteredVisits =
        list.where((visit) => visit.trimester == getCurrentTrimester).toList();
    return filteredVisits.isEmpty || filteredVisits[0].nbr < 3;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: context.isMobile
              ? context.responsiveWidth(100)
              : context.responsiveWidth(60),
          height: context.isMobile
              ? context.responsiveWidth(100)
              : context.responsiveWidth(30),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
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
                  ),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            informations.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: "N'assurance : ",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 18, 18, 18),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextSpan(
                                      text: informations.insurdNbr,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 18, 18, 18),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                getStatus(informations.visits)
                                    ? "Active"
                                    : "Desactive",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: getStatus(informations.visits)
                                        ? const Color.fromARGB(255, 9, 123, 13)
                                        : Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(height: 2),
                  // if (informations.sons.isEmpty)
                  //   Text(
                  //     "No son here",
                  //     style: TextStyle(
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.blueGrey,
                  //     ),
                  //     textAlign: TextAlign.center,
                  //   ),
                  // Insured(
                  //   insuredData: informations.sons,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
