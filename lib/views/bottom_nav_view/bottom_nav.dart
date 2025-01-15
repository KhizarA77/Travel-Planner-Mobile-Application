import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:flutter/material.dart';
import 'package:travelhive/bloc/property_bloc/bloc.dart';
import 'package:travelhive/bloc/swipe_bloc/bloc.dart';
import 'package:travelhive/bloc/user_data_bloc/bloc.dart';
import 'package:travelhive/views/home_view/home_page.dart';
import 'package:travelhive/views/profile_view/profile_page.dart';

class BottomNav extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserDataBloc>(
          create: (context) => UserDataBloc()
            ..add(UserDataLoad(userId: FirebaseAuth.instance.currentUser!.uid)),
        ),
        BlocProvider<PropertyBloc>(
          create: (context) => PropertyBloc()..add(FetchProperties()),
        ),
        BlocProvider<SwipeBloc>(
          create: (context) => SwipeBloc(),
        ),
      ],
      child: PersistentTabView(tabs:
      [
        PersistentTabConfig(screen: HomePage(), item: ItemConfig(icon: Icon(Icons.home), title: "Home")),
        PersistentTabConfig(screen: ProfilePage(), item: ItemConfig(icon: Icon(Icons.person), title: "Profile"))
      ] 
      , navBarBuilder: (navBarConfig) => Style2BottomNavBar(navBarConfig: navBarConfig)
      ),
    );
  }

}