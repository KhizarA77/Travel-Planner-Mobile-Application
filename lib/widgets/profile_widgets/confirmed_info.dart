import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ConfirmedInfo extends StatelessWidget {
  final String name;
  const ConfirmedInfo({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${name}\'s confirmed information', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 10.h,),
        Row(
          children: [
            Icon(Icons.check_circle, color: Colors.black, size: 30.sp,),
            SizedBox(width: 10.w,),
            Text('Email address', style: TextStyle(fontSize: 15.sp),),
          ],
        ),
      ],
    );
  }


}