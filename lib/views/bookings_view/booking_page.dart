import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travelhive/bloc/user_data_bloc/bloc.dart';



class BookingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<UserDataBloc, UserDataState>(
      builder: (context, state) {
        if (state is UserDataLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else if (state is UserDataFailure) {
          return Center(
            child: Text('Failed to load user data: ${state.error}'),
          );
        }
        else if (state is UserDataSuccess) {
            return Scaffold(
              appBar: AppBar(),
              body: Expanded(
                child: ListView.builder(
                itemCount: state.userData.bookings.length,
                itemBuilder: (context, index) {
                  final booking = state.userData.bookings[index]!;
                    return GestureDetector(
                    onTap: () {
                      // Handle booking tap
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                        ),
                      ],
                      ),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                        children: [
                          ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                          child: SizedBox(
                            height: 175.h,
                            width: double.infinity,
                            child: PageView.builder(
                            controller: PageController(),
                            itemCount: booking.imageUrls.length,
                            itemBuilder: (context, index) {
                              return Image.network(
                              booking.imageUrls[index],
                              fit: BoxFit.cover,
                              );
                            },
                            ),
                          ),
                          ),
                        ],
                        ),
                        SizedBox(height: 6.h),
                        Center(
                        // child: SmoothPageIndicator(
                        //   controller: PageController(),
                        //   count: booking.imageUrls.length,
                        //   effect: ExpandingDotsEffect(
                        //   dotHeight: 8.h,
                        //   dotWidth: 8.w,
                        //   activeDotColor: Colors.blue,
                        //   dotColor: Colors.grey.shade300,
                        //   ),
                        // ),
                        ),
                        Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Expanded(
                              child: Text(
                              booking.propertyName,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                                size: 16,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                booking.rating.toString(),
                                style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                ),
                              ),
                              ],
                            ),
                            ],
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            booking.location,
                            style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Your Booking Date: ${DateFormat('d MMM').format(booking.availabilityDates.first)} – ${DateFormat('d MMM').format(booking.availabilityDates.last)}',
                            style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            '\$${booking.pricePerNight}',
                            style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                          ],
                        ),
                        ),
                      ],
                      ),
                    ),
                    );
                },
                ),
              ),
            );
        }
        else {
          return Container();
        }
    });


  }


}