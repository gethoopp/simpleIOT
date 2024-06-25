

import 'package:flutter/material.dart';

IconButton userIconButton(
    {required String icons, required void Function()? itemtap}) {
  return IconButton(
      onPressed: itemtap,
      icon: ImageIcon(color: Colors.black, size: 60, AssetImage(icons)));
}
