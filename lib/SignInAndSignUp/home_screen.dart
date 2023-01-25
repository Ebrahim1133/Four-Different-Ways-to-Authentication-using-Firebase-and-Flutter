import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:testauth/moduls/auth_cubit/auth_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Sucess Auth',style: TextStyle(color: Colors.black,fontSize: 30),),
                  Container(
                    height: 60,
                    width: 250,
                    decoration: BoxDecoration(
                        color: HexColor('#0148a4'),
                        borderRadius: BorderRadius.circular(35)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: MaterialButton(
                        minWidth: 250,
                        onPressed: ()  {
                           AuthCubit.get(context).signOutWithGoogleAndFacebook(context: context);
                        },
                        child: Text(
                          'LOG Out',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ),
        );
      },
    );
  }
}
