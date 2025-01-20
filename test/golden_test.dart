import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travelhive/views/change_password_view/change_password_page.dart';
import 'package:travelhive/views/login_view/login_page.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:travelhive/views/register_view/register_page.dart';
import 'package:travelhive/views/verification_view/verification_page.dart';


Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      skipGoldenAssertion: () => !Platform.isMacOS,
    ),
  );
}

void main() {
  // setupFirebaseAuthMocks();
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await testExecutable(() {});
  });

  testGoldens('Golden test for LoginPage', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) {
            return MaterialApp(
              title: 'Travel Hive',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: LoginPage(),
            );
          }),
    );
    await tester.pumpAndSettle(const Duration(seconds: 8));
    await screenMatchesGolden(tester, 'test_login_sc');
  });

  testGoldens('Golden test for Register Page', (WidgetTester tester) async {
    // Inject dependencies if required
    await tester.pumpWidget(
      ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) {
            return MaterialApp(
              title: 'Travel Hive',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: RegisterPage(),
            );
          }),
    );
    await tester.pumpAndSettle(const Duration(seconds: 8));
    await screenMatchesGolden(tester, 'test_register_sc');
  });

  testGoldens('Golden test for Verification Page', (WidgetTester tester) async {
    // Inject dependencies if required
    await tester.pumpWidget(
      ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) {
            return MaterialApp(
              title: 'Travel Hive',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: VerificationPage(),
            );
          }),
    );
    await tester.pumpAndSettle(const Duration(seconds: 8));
    await screenMatchesGolden(tester, 'test_verification_sc');
  });

  testGoldens('Golden test for Change Password Page',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) {
            return MaterialApp(
              title: 'Travel Hive',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: ChangePasswordPage(),
            );
          }),
    );
    await tester.pumpAndSettle(const Duration(seconds: 8));
    await screenMatchesGolden(tester, 'test_cpw_sc');
  });
}
