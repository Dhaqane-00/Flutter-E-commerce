class Banners {
  String? id;
  String? name;
  String? description;
  String? images;
  int? brand;
  String? createdBy;
  DateTime? createdAt;
  int? version;

  Banners({
    this.id,
    this.name,
    this.description,
    this.images,
    this.brand,
    this.createdBy,
    this.createdAt,
    this.version,
  });

  factory Banners.fromJson(Map<String, dynamic> json) {
    return Banners(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      images: json['images'] as String?,
      brand: json['brand'] as int?,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      version: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'images': images,
      'brand': brand,
      'createdBy': createdBy,
      'createdAt': createdAt?.toIso8601String(),
      '__v': version,
    };
  }
}
