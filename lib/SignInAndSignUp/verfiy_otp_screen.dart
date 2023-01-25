import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pinput/pinput.dart';
import 'package:testauth/moduls/auth_cubit/auth_cubit.dart';

class MyVerify extends StatefulWidget {
  const MyVerify({Key? key}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  var code = '';

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );



    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
            ),
            elevation: 0,
          ),
          body: Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/welcome2.jpg',
                    height: 180,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Phone Verification",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "We need to register your phone without getting started!",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Pinput(
                    length: 6,
                     defaultPinTheme: defaultPinTheme,
                    showCursor: true,
                    onCompleted: (val) {
                      code = val;
                    },
                    onChanged: (val) {
                      code = val;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: HexColor('#0148a4'),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () async {
                          await AuthCubit.get(context).signInWihtPhoneNumber(verificationId: AuthCubit.get(context).verify,code: code,context: context);
                        },
                        child: Text("Verify Phone Number",style: TextStyle(color: Colors.white),)),
                  ),
                  /////////////////////////////////////////////
                  ///githere
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Edit Phone Number ?",
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}