class Post {
  String postId;
  final String details;
  final String image;
  Map likes;
  bool isFavorite;

  Post({
    this.postId = '',
    required this.details,
    required this.image,
    required this.likes,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'details': details,
      'image': image,
      'likes': likes,
      'isFavorite': isFavorite,
    };
  }

  static Post fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['postId'] as String,
      details: json['details'] as String,
      image: json['image'] as String,
      likes: json['likes'] as Map,
      isFavorite: json['isFavorite'] as bool,
    );
  }
}
