import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelhive/bloc/property_bloc/bloc.dart';

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
            Border.all(color: Colors.grey, width: 1.w),
      ),
      child: Row(
        children: [
          SizedBox(width: 15.w),
          Icon(
            Icons.search,
            color: Colors.grey, 
          ),
          SizedBox(width: 5.w),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search places',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.sp,
                ),
                border: InputBorder.none, 
              ),
              onChanged: (value) {
                BlocProvider.of<PropertyBloc>(context).add(SearchProperties(query: value));

              },
            ),
          ),
        ],
      ),
    );
  }
}
