class Category {
  String? name;
  String? description;
  int? brands;
  String? photo;
  String? createdBy;
  String? id;
  DateTime? createdAt;
  int? v;

  Category({
    this.name,
    this.description,
    this.brands,
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
      brands: json['brands'] as int?,
      photo: json['photo'] as String?,
      createdBy: json['createdBy'] as String?,
      id: json['_id'] as String?,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'brands': brands,
      'photo': photo,
      'createdBy': createdBy,
      '_id': id,
      'createdAt': createdAt?.toIso8601String(),
      '__v': v,
    };
  }
}
