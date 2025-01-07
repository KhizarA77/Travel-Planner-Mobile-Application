class Property {

  final String propertyId;
  final String propertyName;
  final String propertyDescription;
  final String location;
  final List<String> imageUrls;
  final List<String> amenities;
  final double longitude;
  final double latitude;
  final double rating;
  final List<DateTime> availabilityDates;
  final List<String> reviews;
  final double pricePerNight;
  final String propertyType;
  final String hostId;
  final String hostName;


  Property({
    required this.propertyId,
    required this.propertyName,
    required this.propertyDescription,
    required this.location,
    required this.imageUrls,
    required this.amenities,
    required this.longitude,
    required this.latitude,
    required this.rating,
    required this.availabilityDates,
    required this.reviews,
    required this.pricePerNight,
    required this.propertyType,
    required this.hostId,
    required this.hostName,
  });

  factory Property.fromMap(Map<String, dynamic> data) {

    List<dynamic> imageUrls = data['imageUrls'] as List<dynamic>;
    List<dynamic> amenities = data['amenities'] as List<dynamic>;
    List<dynamic> availabilityDates = data['availabilityDates'] as List<dynamic>;
    List<dynamic> reviews = data['reviews'] as List<dynamic>;
    // String hostId = data['hostId'].id;

    List<String> imageUrlsList = imageUrls.map((url) => url as String).toList();
    List<String> amenitiesList = amenities.map((amenity) => amenity as String).toList();
    List<String> reviewsList = reviews.map((review) => review as String).toList();
    List<DateTime> availabilityDatesList = availabilityDates.map((timestamp) => DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch)).toList();

    return Property(
      propertyId: data['propertyId'],
      propertyName: data['propertyName'],
      propertyDescription: data['propertyDescription'],
      location: data['location'],
      imageUrls: imageUrlsList,
      amenities: amenitiesList,
      longitude: data['longitude'],
      latitude: data['latitude'],
      rating: data['rating'],
      availabilityDates: availabilityDatesList, 
      reviews: reviewsList,
      pricePerNight: data['pricePerNight'],
      propertyType: data['propertyType'],
      hostId: data['hostId'],
      hostName: data['hostName'],
    );
  }

  Map<String, dynamic> toMap() {
    Map <String, dynamic> map = {
      'propertyId': propertyId,
      'propertyName': propertyName,
      'propertyDescription': propertyDescription,
      'location': location,
      'imageUrls': imageUrls,
      'amenities': amenities,
      'longitude': longitude,
      'latitude': latitude,
      'rating': rating,
      'availabilityDates': availabilityDates,
      'reviews': reviews,
      'pricePerNight': pricePerNight,
      'propertyType': propertyType,
      'hostId': hostId,
      'hostName': hostName,
    };
    return map;
    
  }


}