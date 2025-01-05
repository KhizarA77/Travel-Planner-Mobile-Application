import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.sp),
        border:
            Border.all(color: Colors.grey, width: 1.w), // Border color and width
      ),
      child: Row(
        children: [
          SizedBox(width: 15.w), // Left padding
          Icon(
            Icons.search,
            color: Colors.grey, // Icon color
          ),
          SizedBox(width: 5.w), // Spacing between icon and text
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search places', // Placeholder text
                hintStyle: TextStyle(
                  color: Colors.grey, // Hint text color
                  fontSize: 16.sp, // Font size
                ),
                border: InputBorder.none, // Remove the border
              ),
              onChanged: (value) {
                // Handle search input changes
                print('Search input: $value');
              },
            ),
          ),
          VerticalDivider(
            color: Colors.grey, // Divider color
            width: 1.w, // Divider thickness
            indent: 10.h, // Top padding for divider
            endIndent: 10.w, // Bottom padding for divider
          ),
          IconButton(
            icon: Icon(
              Icons.tune, // Filter icon
              color: Colors.grey, // Icon color
            ),
            onPressed: () {
              // Action for filter button
              print('Filter button clicked');
            },
          ),
        ],
      ),
    );
  }
}
