import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelhive/bloc/property_bloc/bloc.dart';
import 'package:travelhive/bloc/user_data_bloc/bloc.dart';
import 'package:travelhive/widgets/home_widgets/page_container.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const PageContainer(),
    );
  }
}
