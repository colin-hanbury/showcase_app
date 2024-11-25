class Visitor {
  final String? name;
  final String? nationality;

  factory Visitor.fromJson(Map<String, dynamic> json) {
    return Visitor(
      name: json['name'],
      nationality: json['nationality'],
    );
  }

  Visitor({
    this.name,
    this.nationality,
  });
}
