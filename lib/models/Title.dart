class NewTitle {
  String? title;
  String? subtitile;
  String? id;
  int? version;

  NewTitle({this.title, this.subtitile, this.id, this.version});

  factory NewTitle.fromJson(Map<String, dynamic> json) {
    return NewTitle(
      title: json['title'],
      subtitile: json['subtitile'],
      id: json['_id'],
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitile': subtitile,
      '_id': id,
      '__v': version,
    };
  }
}
