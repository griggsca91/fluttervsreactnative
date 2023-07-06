class Location {
  final double lat;
  final double long;
  final String displayName;
  final String address;
  String? displayImage;

  Location(
      {required this.lat,
      required this.long,
      required this.displayName,
      required this.address,
      this.displayImage});

  Location.fromJson(Map<String, dynamic> json)
      : lat = double.parse(json["lat"]),
        long = double.parse(json["long"]),
        displayName = json["display_name"],
        address = json["address"],
        displayImage = json["image_url"];
}
