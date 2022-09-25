class Videos {
  String? category;
  String? image;
  List? videos;

  Videos({
    required this.category,
    required this.image,
    required this.videos,
  });

  factory Videos.fromJSON(Map json) {
    return Videos(
      category: json['category'],
      image: json['image'],
      videos: json['videos'],
    );
  }
}
