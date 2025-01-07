import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:travelhive/bloc/property_bloc/bloc.dart';
import 'package:travelhive/models/property.dart';
import 'package:travelhive/services/property_collection_service.dart';
import 'package:travelhive/services/upload_service.dart';

class HostPage extends StatefulWidget {
  @override
  _HostPageState createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  final List<TextEditingController> _amenityControllers = [];
  final List<XFile> _images = [];
  DateTime? _startDate;
  DateTime? _endDate;
  LatLng? _selectedLocation;
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _propertyDescriptionController =
      TextEditingController();
  final TextEditingController _propertyNameController = TextEditingController();
  final TextEditingController _propertyTypeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  // @override
  // // void dispose() {
  // //   _amenityControllers.forEach((controller) => controller.dispose());
  // //   _locationController.dispose();
  // //   _priceController.dispose();
  // //   _propertyDescriptionController.dispose();
  // //   _propertyNameController.dispose();
  // //   _propertyTypeController.dispose();
  // //   super.dispose();
  // // }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedImages = await picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        _images.addAll(pickedImages);
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _addAmenityField() {
    setState(() {
      _amenityControllers.add(TextEditingController());
    });
  }

  void _selectLocation(LatLng location) {
    setState(() {
      _selectedLocation = location;
      _locationController.text = '${location.latitude}, ${location.longitude}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Host a Property'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _propertyNameController,
              decoration: InputDecoration(labelText: 'Property Name'),
            ),
            TextField(
              controller: _propertyTypeController,
              decoration: InputDecoration(labelText: 'Property Type'),
            ),
            TextField(
              controller: _propertyDescriptionController,
              decoration: InputDecoration(labelText: 'Property Description'),
              maxLines: 3,
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Total Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _countryController,
              decoration: InputDecoration(labelText: 'City, Country'),
              // keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
              readOnly: true,
            ),
            Container(
              height: 300,
              child: AbsorbPointer(
                absorbing: false,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(37.7749, -122.4194),
                    zoom: 10,
                  ),
                  onTap: _selectLocation,
                  markers: _selectedLocation != null
                      ? {
                          Marker(
                            markerId: MarkerId('selected-location'),
                            position: _selectedLocation!,
                          ),
                        }
                      : {},
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context, true),
              child: Text(_startDate == null
                  ? 'Select Start Date'
                  : DateFormat.yMMMd().format(_startDate!)),
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context, false),
              child: Text(_endDate == null
                  ? 'Select End Date'
                  : DateFormat.yMMMd().format(_endDate!)),
            ),
            ElevatedButton(
              onPressed: _pickImages,
              child: Text('Add Images'),
            ),
            Wrap(
              children: _images.map((image) {
                return Image.file(
                  File(image.path),
                  width: 100,
                  height: 100,
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _addAmenityField,
              child: Text('Add Amenity'),
            ),
            Column(
              children: _amenityControllers.map((controller) {
                return TextField(
                  controller: controller,
                  decoration: InputDecoration(labelText: 'Amenity'),
                );
              }).toList(),
            ),
            SizedBox(height: 10.h),
            ElevatedButton(
              onPressed: () async {
                try {
                  final String location = _countryController.text.trim();
                  final String propertyName =
                      _propertyNameController.text.trim();
                  final String propertyType =
                      _propertyTypeController.text.trim();
                  final String propertyDescription =
                      _propertyDescriptionController.text.trim();
                  final double pricePerNight =
                      double.parse(_priceController.text.trim());
                  final DateTime startDate = _startDate!;
                  final DateTime endDate = _endDate!;
                  final List<DateTime> availabilityDates = [startDate, endDate];
                  final double latitude = _selectedLocation!.latitude;
                  final double longitude = _selectedLocation!.longitude;
                  final List<String> amenities = _amenityControllers
                      .map((controller) => controller.text.trim())
                      .toList();
                  final String hostId = FirebaseAuth.instance.currentUser!.uid;
                  final String hostName = FirebaseAuth.instance.currentUser!.displayName! ?? 'Host';
                  final List<String> imageUrls = [];
                  final List<String> reviews = ["Credible Host"];
                  final double rating = 2.5;
                  for (final image in _images) {
                    // Upload image to server and get the URL
                    String url =
                        await UploadService().uploadImageToServer(image);
                    String _url = 'http://110.93.247.8:3000${url}';
                    imageUrls.add(_url);
                  }
                  Property property = Property(
                    propertyId: 'placeholder',
                    location: location,
                    propertyName: propertyName,
                    propertyType: propertyType,
                    propertyDescription: propertyDescription,
                    pricePerNight: pricePerNight,
                    availabilityDates: availabilityDates,
                    latitude: latitude,
                    longitude: longitude,
                    amenities: amenities,
                    hostId: hostId,
                    hostName: hostName,
                    imageUrls: imageUrls,
                    reviews: reviews,
                    rating: rating,
                  );
                  await PropertyCollectionService()
                      .addPropertyToCollection(property: property);
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.success(
                      message: "Property Listed!",
                    ),
                  );
                  BlocProvider.of<PropertyBloc>(context).add(FetchProperties());
                  Navigator.pop(context);
                } catch (e) {
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.error(
                      message: e.toString(),
                    ),
                  );
                }
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 100.h), // Add some space below the button
          ],
        ),
      ),
    );
  }
}
