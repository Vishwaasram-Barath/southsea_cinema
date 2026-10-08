class Movie {
  final String id;
  final String title;
  final String ageRating;
  final String synopsis;
  final String screeningTime;
  final String imagePath;
  final double price;

  const Movie({
      required this.id,
      required this.title,
      required this.ageRating,
      required this.synopsis,
      required this.screeningTime,
      required this.imagePath,
      required this.price});

  String get formattedPrice => '£${price.toStringAsFixed(2)}';
  bool get isChildFriendly => ageRating == 'U' || ageRating == 'PG-13';
  bool get isAdultOnly => ageRating == '18';
}
