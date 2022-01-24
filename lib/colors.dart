import 'package:flutter/material.dart';

// Map to help create the various shades of a material color.
Map<int, Color> color = {
  50: const Color.fromRGBO(76, 86, 106, .1),
  100: const Color.fromRGBO(76, 86, 106, .2),
  200: const Color.fromRGBO(76, 86, 106, .3),
  300: const Color.fromRGBO(76, 86, 106, .4),
  400: const Color.fromRGBO(76, 86, 106, .5),
  500: const Color.fromRGBO(76, 86, 106, .6),
  600: const Color.fromRGBO(76, 86, 106, .7),
  700: const Color.fromRGBO(76, 86, 106, .8),
  800: const Color.fromRGBO(76, 86, 106, .9),
  900: const Color.fromRGBO(76, 86, 106, 1.0),
};

// Custom Colors for our app.
MaterialColor colorDark = MaterialColor(0xff4c566a, color);
MaterialColor colorDarker = MaterialColor(0xff2e3440, color);
MaterialColor colorLight = MaterialColor(0xffd8dee9, color);
