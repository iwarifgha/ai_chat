
class BusinessInChat {
  final String? id;
  final List<String>? images;
  final String? address;
  final int? reviewCount;
  final double? rating;
  final String name;
  final String? openStatus;
  final BusinessCategoryInChat category;
  final String? description;
  final String? website;
  final String? city;

  BusinessInChat(
      {required this.images,
        required this.address,
        required this.reviewCount,
        required this.rating,
        required this.openStatus,
        required this.id,
        required this.name,
        required this.category,
        required this.description,
        required this.website,
        required this.city});

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'description': description,
  //     'website': website,
  //     'city': city,
  //     'category': category.toJson()
  //   };
  // }

  factory BusinessInChat.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? imageStrings = json['images'] as List<dynamic>?;
    final images = imageStrings?.map((item) => item as String).toList();
    return BusinessInChat(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        website: json['website'],
        city: json['city'],
        category: BusinessCategoryInChat.fromJson(json['category']),
        images: images ,
        address:  json['address'],
        reviewCount:json['review_count'],
        rating: json['rating'],
        openStatus:  json['open_status']);
  }
}

class BusinessCategoryInChat {
  final int id;
  final String name;

  BusinessCategoryInChat({required this.id, required this.name});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory BusinessCategoryInChat.fromJson(Map<String, dynamic> json) {
    return BusinessCategoryInChat(
      id: json['id'],
      name: json['name'],
    );
  }
}
