import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.text, required this.icons, required this.emailcon });

  final String text;
  final IconData icons;
  final TextEditingController emailcon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 301,
      height: 52,
      child: TextFormField(
        controller: emailcon,
        decoration: InputDecoration(
            suffixIcon: Icon(icons),
            suffixIconColor: Colors.white,
            labelText: text,
            labelStyle: GoogleFonts.roboto(
                fontWeight: FontWeight.w500, color: Colors.white),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: BorderSide(color: Colors.yellow)),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.yellow)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: BorderSide(color: Colors.yellow))),
      ),
    );
  }
}
