class AppLocationModel {
  double lat, long;

  AppLocationModel({
    required this.lat,
    required this.long,
  });

  factory AppLocationModel.fromMap(Map<String, dynamic> json) => AppLocationModel(
    lat: json["lat"]?.toDouble(),
    long: json["lng"]?.toDouble(),
  );

}
