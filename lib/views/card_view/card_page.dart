import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelhive/widgets/profile_widgets/confirmed_info.dart';
import 'package:travelhive/widgets/profile_widgets/profile_card.dart';

class CardPage extends StatelessWidget {
  final String name;
  final String photo;
  const CardPage({Key? key, required this.name, required this.photo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(30.sp),
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            ProfileCard(name: name, photoURL: photo),
            SizedBox(height: 20.h,),
            ConfirmedInfo(name: name)
          ],
        ),
      )
    );
  }
}