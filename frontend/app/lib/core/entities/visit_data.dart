class VisitData {
  final int nbr;
  final int trimester;

  VisitData({
    required this.nbr,
    required this.trimester,
  });

  factory VisitData.fromJson(Map<String, dynamic> map) {
    return VisitData(
      nbr: map['nbr'] ?? 0, // Default to 0 if 'nbr' is null
      trimester: map['trimester'] ??
          '', // Default to empty string if 'trimester' is null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nbr': nbr,
      'trimester': trimester,
    };
  }

  VisitData copyWith({
    int? nbr,
    int? trimester,
  }) {
    return VisitData(
      nbr: nbr ?? this.nbr,
      trimester: trimester ?? this.trimester,
    );
  }
}
