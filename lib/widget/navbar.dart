import 'package:flutter/material.dart';
import 'package:simple_iot/view/details/conditioner.dart';
import 'package:simple_iot/view/details/cooler.dart';
import 'package:simple_iot/view/details/ceil.dart';
import 'package:simple_iot/view/details/homes.dart';
import 'package:simple_iot/view/details/lamp.dart';
import 'package:simple_iot/widget/icons_button.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selectedindex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const Detail1(),
    const Detail2(),
    const Detail3(),
    const Detail4()
  ];

  void ontapIndex(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.brown[500],
        bottomNavigationBar: SafeArea(
            child: Container(
          height: 75,
          margin: EdgeInsets.only(
              left: size.width * 0.2, bottom: size.height * 0.05),
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.white,
              Color.fromARGB(255, 180, 126, 107),
              Color.fromARGB(255, 77, 56, 49)
            ]),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            color: Colors.amber,
          ),
          child: Row(
            children: [
              userIconButton(
                  icons: "Assets/icons/lamp 1.png",
                  itemtap: () => ontapIndex(1)),
              userIconButton(
                  icons: "Assets/icons/air-conditioner 1.png",
                  itemtap: () => ontapIndex(2)),
              userIconButton(
                  icons: "Assets/icons/light-bulb 1.png", itemtap: () => ontapIndex(3)),
              userIconButton(
                  icons: "Assets/icons/Group.png", itemtap: () => ontapIndex(4)),
            ],
          ),
        )),
        body: IndexedStack(
          index: selectedindex,
          children: pages,
        ));
  }
}
