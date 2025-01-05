import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelhive/widgets/home_widgets/custom_list_view.dart';
import 'package:travelhive/widgets/home_widgets/listing_card.dart';
import 'package:travelhive/widgets/home_widgets/search_bar.dart';
import 'package:travelhive/widgets/home_widgets/user_info.dart';

class PageContainer extends StatelessWidget {
  const PageContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
      width: double.infinity, // Set the width of the container
      height: double.infinity, // Set the height of the container
      padding: EdgeInsets.all(30.sp),
      decoration: BoxDecoration(
        color: Colors.white, // Background color (optional)
        border: Border.all(color: Colors.grey, width: 1), // Optional border
        borderRadius: BorderRadius.circular(10.sp), // Optional rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: Column(
        children: [
          UserInfo(),
          SizedBox(height: 25.h), // Vertical spacing
          CustomSearchBar(),
          SizedBox(height: 0.2.h), // Vertical spacing
          CustomListView(),
        ],
      ),
    );
  }
}
