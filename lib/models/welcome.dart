class Welcome {
  final String? title;
  final String? message;

  factory Welcome.fromJson(Map<String, dynamic> json) {
    return Welcome(
      title: json['title'],
      message: json['message'],
    );
  }

  Welcome({
    this.title,
    this.message,
  });
}
