import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_iot/controller/controller.dart';
import 'package:simple_iot/cubit/auth_cubit_cubit.dart';
import 'package:simple_iot/widget/button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.brown,
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: size.height * 0.55,
                width: size.width * 1,
                child: Image.asset(
                  "Assets/image/Bg.png",
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.3, left: size.width * 0.04),
                child: Text(
                  ' Simple \n IOT app',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 40,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.04, left: size.width * 0.12),
            child: Row(
              children: [
                Text(
                  'Sign in',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.02),
            child:  Button(
              text: 'Email ID',
              icons: Icons.email,
              emailcon: emailCon,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.02),
            child:  Button(
              text: 'Enter Password',
              icons: Icons.password,
              emailcon: passCon,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
              width: 301,
              height: 52,
              child: FloatingActionButton(
                onPressed: () {
                  context.read<AuthCubitCubit>().login(emailCon.text, passCon.text);
                },
                backgroundColor: Colors.yellowAccent,
                child: const Text('Login'),
              )),

              const SizedBox(height: 15,),

              Text('Don\'t have account yet?', style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Colors.white
              ),),

              Text('Create an account', 
              
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Colors.yellowAccent,
              ),)
        ],
      ),
    );
  }
}
