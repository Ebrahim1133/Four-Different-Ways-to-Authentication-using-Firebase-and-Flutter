import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:testauth/moduls/auth_cubit/auth_cubit.dart';
import 'bloc_observer.dart';
import 'moduls/SignInAndSignUp/signIn_screen.dart';
import 'moduls/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//3ZLW/TAqPvR43Zh79ejFQDOdka8=
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) => AuthCubit(),),
      ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        theme: defaultTheme,
        home: SignInScreen(),
      ),
    );
  }
}

