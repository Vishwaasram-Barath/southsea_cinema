class Movie {
  final String id;
  final String title;
  final String ageRating;
  final String synopsis;
  final String screeningTime;
  final String imagePath;
  final double price;

  const Movie(
      {required this.id,
      required this.title,
      required this.ageRating,
      required this.synopsis,
      required this.screeningTime,
      required this.imagePath,
      required this.price});

  factory Movie.fromJson(Map<String, dynamic> json) {
    final String id = json['id'] as String;
    final String title = json['title'] as String;
    final String ageRating = json['ageRating'] as String;
    final String synopsis = json['synopsis'] as String;
    final String screeningTime = json['screeningTime'] as String;
    final String imagePath = json['imagePath'] as String;
    final num priceNumber = json['price'] as num;
    final double price = priceNumber.toDouble();

    return Movie(
      id: id,
      title: title,
      ageRating: ageRating,
      synopsis: synopsis,
      screeningTime: screeningTime,
      imagePath: imagePath,
      price: price,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'title': title,
      'ageRating': ageRating,
      'synopsis': synopsis,
      'screeningTime': screeningTime,
      'imagePath': imagePath,
      'price': price,
    };
    return data;
  }

  String get formattedPrice => '£${price.toStringAsFixed(2)}';
  bool get isChildFriendly => ageRating == 'U' || ageRating == 'PG';
  bool get isAdultOnly => ageRating == '18';
}
