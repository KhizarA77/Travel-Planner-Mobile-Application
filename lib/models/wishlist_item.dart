class WishlistItem {

  final String propertyId;
  final String propertyName;
  final String location;
  final List<String> imageUrls;

  WishlistItem({
    required this.propertyId,
    required this.propertyName,
    required this.location,
    required this.imageUrls,
  });

  factory WishlistItem.fromMap(Map<String, dynamic> data) {

    return WishlistItem(
      propertyId: data['propertyId'],
      propertyName: data['propertyName'],
      location: data['location'],
      imageUrls: data['imageUrls'],
    );
  }

  Map<String, dynamic> toMap() {
    Map <String, dynamic> map = {
      'propertyId': propertyId,
      'propertyName': propertyName,
      'location': location,
      'imageUrls': imageUrls,
    };
    return map;
    
  }


}