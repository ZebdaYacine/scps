import 'package:app/core/entities/visit_data.dart';

class SonData {
  final String insurdNbr;
  final String name;
  final String status;
  final int nbr;
  final List<VisitData> visits;

  SonData({
    required this.insurdNbr,
    required this.name,
    required this.status,
    required this.nbr,
    required this.visits,
  });

  factory SonData.fromJson(Map<String, dynamic> map) {
    return SonData(
      status: map['status'] ?? '',
      name: map['name'] ?? '',
      insurdNbr: map['insurdNbr'] ?? '',
      nbr: map['nbr'] ?? '',
      visits: (map['visit'] as List?)
              ?.map(
                  (visit) => VisitData.fromJson(visit as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'name': name,
      'insurdNbr': insurdNbr,
      'nbr': nbr,
      'visit': visits.map((visits) => visits.toJson()).toList(),
    };
  }

  SonData copyWith({
    String? insurdNbr,
    String? name,
    String? email,
    String? phone,
    required SonData son,
  }) {
    return SonData(
      insurdNbr: insurdNbr ?? this.insurdNbr,
      name: name ?? this.name,
      status: status,
      nbr: nbr,
      visits: son.visits,
    );
  }
}
