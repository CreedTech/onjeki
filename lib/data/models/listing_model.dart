class Listing {
  final String id;
  final String apartmentName;
  final String country;
  final String city;
  final String province;
  final String district;
  final List<String> advertPhotos;
  final double pricePerNight;
  final String availableDate;
  final double latitude;
  final double longitude;
  final double rating;
  final int filterTypeId;

  Listing({
    required this.id,
    required this.apartmentName,
    required this.country,
    required this.city,
    required this.province,
    required this.district,
    required this.advertPhotos,
    required this.pricePerNight,
    required this.availableDate,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.filterTypeId,
  });

  factory Listing.fromMap(Map<String, dynamic> map) {
    return Listing(
      id: map['id'],
      apartmentName: map['apartmentName'],
      country: map['country'],
      city: map['city'],
      province: map['province'],
      district: map['district'],
      advertPhotos: List<String>.from(map['advertPhotos']),
      pricePerNight: map['pricePerNight'],
      availableDate: map['availableDate'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      rating: map['rating'],
      filterTypeId: map['filterTypeId'],
    );
  }
}


