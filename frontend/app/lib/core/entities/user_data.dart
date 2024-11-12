import 'package:app/core/entities/son_data.dart';
import 'package:app/core/entities/visit_data.dart';

class UserData {
  final String insurdNbr;
  final String name;
  final String email;
  final String phone;
  final bool request;
  final String status;

  // final List<SonData> sons;
  final List<VisitData> visits;

  UserData(
      {required this.insurdNbr,
      required this.name,
      required this.email,
      required this.phone,
      required this.request,
      required this.status,
      // required this.sons,
      required this.visits});

  factory UserData.fromJson(Map<String, dynamic> map) {
    return UserData(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      insurdNbr: map['insurdNbr'] ?? '',
      phone: map['phone'] ?? '',
      request: map['request'] ?? false,
      status: map['status'] ?? "",
      // sons: (map['son'] as List?)
      //         ?.map((son) => SonData.fromJson(son as Map<String, dynamic>))
      //         .toList() ??
      //     [],
      visits: (map['visit'] as List?)
              ?.map(
                  (visit) => VisitData.fromJson(visit as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'insurdNbr': insurdNbr,
      'phone': phone,
      "request": request,
      "status": status,
      // 'son': sons.map((son) => son.toJson()).toList(),
      'visit': visits.map((visits) => visits.toJson()).toList(),
    };
  }

  UserData copyWith({
    String? insurdNbr,
    String? name,
    String? email,
    String? phone,
    bool? request,
    String? status,
    List<VisitData>? visits,
  }) {
    return UserData(
      insurdNbr: insurdNbr ?? this.insurdNbr,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      request: request ?? this.request,
      // sons: sons ?? this.sons,
      visits: visits ?? this.visits,
    );
  }
}
