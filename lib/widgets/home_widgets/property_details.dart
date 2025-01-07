import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travelhive/bloc/property_bloc/bloc.dart';
import 'package:travelhive/bloc/user_data_bloc/bloc.dart';
import 'package:travelhive/models/property.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:travelhive/services/property_collection_service.dart';
import 'package:travelhive/services/user_collection_service.dart';

class PropertyDetailsPage extends StatefulWidget {
  final Property property;

  const PropertyDetailsPage({
    required this.property,
  });

  @override
  _PropertyDetailsPageState createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  final PageController _pageController = PageController();

  String formatAvailabilityDates(List<DateTime> dates) {
    if (dates.isEmpty) return 'No availability';
    final formattedDates =
        dates.map((date) => DateFormat('d MMM').format(date)).toList();
    return '${formattedDates.first} – ${formattedDates.last}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding:
            EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w, bottom: 60.h),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: 80.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          height: 250.h,
                          width: double.infinity,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: widget.property.imageUrls.length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                widget.property.imageUrls[index],
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16.h,
                        right: 16.w,
                        child: IconButton(
                          onPressed: () {},
                          icon:
                              Icon(Icons.favorite_border, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: widget.property.imageUrls.length,
                      effect: ExpandingDotsEffect(
                        dotHeight: 8.h,
                        dotWidth: 8.w,
                        activeDotColor: Colors.blue,
                        dotColor: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.property.propertyName,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Hosted by ${widget.property.hostName}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          widget.property.propertyDescription,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                        const Divider(),
                        SizedBox(height: 5.h),
                        Text(
                          'Availability: ${formatAvailabilityDates(widget.property.availabilityDates)}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Rating: ${widget.property.rating}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                        const Divider(),
                        SizedBox(height: 5.h),
                        Text(
                          'Amenities:',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        ...widget.property.amenities.map(
                          (amenity) => Padding(
                            padding: EdgeInsets.only(bottom: 4.h),
                            child: Row(
                              children: [
                                Icon(Icons.check,
                                    size: 16, color: Colors.green),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    amenity,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Container(
                          height: 200.h,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(widget.property.latitude,
                                  widget.property.longitude),
                              zoom: 14,
                            ),
                            markers: {
                              Marker(
                                markerId: MarkerId('propertyLocation'),
                                position: LatLng(widget.property.latitude,
                                    widget.property.longitude),
                              ),
                            },
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await UserCollectionService().addBooking(uid: FirebaseAuth.instance.currentUser!.uid, booking: widget.property);
                      final response = await PropertyCollectionService()
                          .updatePropertyAvailability(
                              widget.property.propertyId);
                      if (response == 'Success') {
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.success(
                            message: "Booking Completed",
                          ),
                        );
                        Navigator.pop(context);
                        BlocProvider.of<PropertyBloc>(context).add(FetchProperties());
                        BlocProvider.of<UserDataBloc>(context).add(UserDataLoad(userId: FirebaseAuth.instance.currentUser!.uid));
                      } else {
                        throw Exception("Booking Failed");
                      }
                    } catch (e) {
                      showTopSnackBar(
                        Overlay.of(context),
                        CustomSnackBar.error(
                          message: e.toString(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Book Now for \$${widget.property.pricePerNight}',
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
