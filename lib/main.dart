import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/router.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:provider/provider.dart';
import 'common/widgets/bottom_bar.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  bool _isLoading = true;
  String? _error;
  // @override
  // void initState() {
  //   super.initState();
  //   authService.getUserData(context);
  // }

  @override
  void initState() {
    super.initState();
    print("Initializing app...");
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      print("Getting user data...");
      await authService.getUserData(context);
      print("User data retrieved successfully");
    } catch (e) {
      print("Error getting user data: $e");
      _error = e.toString();
    } finally {
      print("Setting _isLoading to false");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Building app. _isLoading: $_isLoading");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amazon Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0.0, //Elevation of the app barfof
          iconTheme: IconThemeData(color: Colors.black),
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: _isLoading
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : _error != null
              ? Scaffold(
                  body: Center(
                    child: Text('Error: $_error'),
                  ),
                )
              : Provider.of<UserProvider>(context).user.token.isNotEmpty
                  ? Provider.of<UserProvider>(context).user.type == 'user'
                      ? const BottomBar()
                      : const AdminScreen()
                  : const AuthScreen(),
    );
  }
}
