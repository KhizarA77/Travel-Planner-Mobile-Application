import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelhive/models/property.dart';

class PropertyCollectionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addPropertyToCollection({required Property property}) async {
    await _firestore.collection('properties').add({
      'propertyName': property.propertyName,
      'propertyDescription': property.propertyDescription,
      'location': property.location,
      'imageUrls': property.imageUrls,
      'amenities': property.amenities,
      'longitude': property.longitude,
      'latitude': property.latitude,
      'rating': property.rating,
      'availabilityDates': property.availabilityDates,
      'reviews': property.reviews,
      'pricePerNight': property.pricePerNight,
      'propertyType': property.propertyType,
      'hostId': property.hostId,
      'hostName': property.hostName,
    });
  }

  Future<List<Property>> getProperties() async {
    try {
      QuerySnapshot<Map<String, dynamic>> response = await _firestore.collection('properties').get();
      List<Property> properties = response.docs.map((property) {
        Map<String, dynamic> data = property.data();
        data['propertyId'] = property.id;
        return Property.fromMap(data);
      }).toList();
      return properties;
    } catch (e) {
      return [];
    }
  }
}
