class Post {
  final String tags;

  final String largeImageURL;

  final String userImageURL;
  final String user;

  Post({
    required this.user,
    required this.tags,
    required this.largeImageURL,
    required this.userImageURL,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        user: json['user'] ?? '',
        tags: json['tags'] ?? '',
        largeImageURL: json['largeImageURL'] ?? '',
        userImageURL: json['userImageURL'] ?? '');
  }
}
