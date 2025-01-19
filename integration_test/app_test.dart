import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:travelhive/firebase_options.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:travelhive/views/login_view/login_page.dart';
import 'package:travelhive/views/register_view/register_page.dart';
import 'package:travelhive/widgets/login_widgets/login_button.dart';
import 'package:travelhive/widgets/login_widgets/forget_button.dart';
import 'package:travelhive/widgets/login_widgets/google_button.dart';
import 'package:travelhive/widgets/login_widgets/facebook_button.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  testWidgets('renders login page widgets', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(home: LoginPage())),
    );

    // Verify all essential widgets are present
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.byType(LoginButton), findsOneWidget);
    expect(find.byType(ForgetButton), findsOneWidget);
    expect(find.text('Don\'t have an account?'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
    expect(find.byType(GoogleButton), findsOneWidget);
    expect(find.byType(FacebookButton), findsOneWidget);
  });

  testWidgets('validates empty email and password',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(home: LoginPage())),
    );

    await tester.tap(find.byType(LoginButton));
    await tester.pump();

    expect(find.text('Exception: Email and Password cannot be empty'),
        findsOneWidget);
  });

  testWidgets('displays error message on missing password login',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(home: LoginPage())),
    );

    await tester.enterText(
        find.widgetWithText(TextField, 'Email'), 'invalid-email');
    await tester.tap(find.byType(LoginButton));
    await tester.pump();
    expect(find.text('Exception: Email and Password cannot be empty'),
        findsOneWidget);
  });

  testWidgets('displays error message on bad email',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(home: LoginPage())),
    );

    await tester.enterText(
        find.widgetWithText(TextField, 'Email'), 'invalid-email');
    await tester.enterText(find.widgetWithText(TextField, 'Password'), '123');
    await tester.tap(find.byType(LoginButton));
    await tester.pump();

    await tester.pump(const Duration(seconds: 2));

    expect(find.text('The email address is badly formatted.'), findsOneWidget);
  });

  testWidgets('displays error message on wrong password',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(home: LoginPage())),
    );

    await tester.enterText(
        find.widgetWithText(TextField, 'Email'), 'khizarcs123@gmail.com');
    await tester.enterText(find.widgetWithText(TextField, 'Password'), '123');
    await tester.tap(find.byType(LoginButton));
    await tester.pump();

    await tester.pump(const Duration(seconds: 2));

    expect(find.text('The supplied auth credential is incorrect, malformed or has expired.'), findsOneWidget);
  });

  testWidgets('User Successful login', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(home: LoginPage())),
    );

    await tester.enterText(find.widgetWithText(TextField, 'Email'), 'khizarcs123@gmail.com');
    await tester.enterText(find.widgetWithText(TextField, 'Password'), '1234567');
    await tester.tap(find.byType(LoginButton));
    await tester.pumpAndSettle(const Duration(seconds: 20));
    expect(find.text('Explore the world'), findsOneWidget);
  });

  testWidgets('User Google Login', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(home: LoginPage())),
    );

    await tester.tap(find.byType(GoogleButton));
    await tester.pumpAndSettle(const Duration(seconds: 20));
    expect(find.text('Explore the world'), findsOneWidget);
  });

  testWidgets('navigates to RegisterPage when "Register" is clicked',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: LoginPage()),
    );

    // Tap the register button
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    expect(find.byType(RegisterPage), findsOneWidget);
  });
}
