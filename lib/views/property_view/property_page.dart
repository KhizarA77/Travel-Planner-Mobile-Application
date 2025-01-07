import 'package:flutter/material.dart';
import 'package:travelhive/models/property.dart';
import 'package:intl/intl.dart';

class PropertyDetailsPage extends StatelessWidget {
  final Property property;

  const PropertyDetailsPage({required this.property});

  String formatAvailabilityDates(List<DateTime> dates) {
    if (dates.isEmpty) return 'No availability';
    final formattedDates = dates.map((date) => DateFormat('d MMM').format(date)).toList();
    return '${formattedDates.first} – ${formattedDates.last}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(property.propertyName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              child: PageView.builder(
                itemCount: property.imageUrls.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    property.imageUrls[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property Description
                  Text(
                    property.propertyDescription,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Amenities
                  Text(
                    'Amenities',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: property.amenities
                        .map((amenity) => Chip(label: Text(amenity)))
                        .toList(),
                  ),
                  SizedBox(height: 16),

                  // Location
                  Text(
                    'Location: ${property.location}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Availability Dates
                  Text(
                    'Availability',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    formatAvailabilityDates(property.availabilityDates),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Reviews
                  Text(
                    'Reviews',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  ...property.reviews
                      .map((review) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              review,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ))
                      .toList(),
                  SizedBox(height: 16),

                  // Price Per Night
                  Text(
                    'Price per night: \$${property.pricePerNight}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
