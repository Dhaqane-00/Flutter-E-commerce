class Category {
  String? name;
  String? description;
  String? photo;
  String? createdBy;
  String? id;
  DateTime? createdAt;
  int? v;

  Category({
    this.name,
    this.description,
    this.photo,
    this.createdBy,
    this.id,
    this.createdAt,
    this.v,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] as String?,
      description: json['description'] as String?,
      photo: json['photo'] as String?,
      createdBy: json['createdBy'] as String?,
      id: json['_id'] as String?,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      v: json['__v'] as int?,
    );
  }

  get icon => null;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'photo': photo,
      'createdBy': createdBy,
      '_id': id,
      'createdAt': createdAt?.toIso8601String(),
      '__v': v,
    };
  }
}
