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
      QuerySnapshot<Map<String, dynamic>> response = await _firestore
          .collection('properties')
          .where("availabilityDates", isNotEqualTo: []).get();
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

  Future<List<Property>> searchProperties(String query) async {
    try {
      QuerySnapshot<Map<String, dynamic>> response = await _firestore
          .collection('properties')
          .where("availabilityDates", isNotEqualTo: []).get();
      List<Property> properties = [];
      response.docs.forEach((property) {
        Map<String, dynamic> data = property.data();
        data['propertyId'] = property.id;
        if (data['propertyName']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            data['location']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            data['propertyType']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase())) {
          properties.add(Property.fromMap(data));
        }
      });
      return properties;
    } catch (e) {
      return [];
    }
  }

  Future<String> updatePropertyAvailability(String? propertyId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> propertySnapshot =
          await _firestore.collection('properties').doc(propertyId).get();
      if (propertySnapshot.exists) {
        Map<String, dynamic>? data = propertySnapshot.data();
        if (data != null && data.containsKey('availabilityDates')) {
          List<DateTime> availabilityDates =
              (data['availabilityDates'] as List<dynamic>)
                  .map((timestamp) => DateTime.fromMillisecondsSinceEpoch(
                      timestamp.millisecondsSinceEpoch))
                  .toList();
          ;
          List<DateTime> availabilityDatesList = [];
          if (availabilityDates.length > 1) {
            DateTime secondDate = availabilityDates[1];
            DateTime newDate = secondDate.add(Duration(days: 7));
            availabilityDatesList.add(secondDate);
            availabilityDatesList.add(newDate);
          }
          await _firestore.collection('properties').doc(propertyId).update({
            'availabilityDates': availabilityDatesList
                .map((date) => Timestamp.fromDate(date))
                .toList(),
          });
          return 'Success';
        } else {
          return 'No availability dates found for this property.';
        }
      } else {
        return 'Property not found.';
      }
    } catch (e) {
      return e.toString();
    }
  }
}
