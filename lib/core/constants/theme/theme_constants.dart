import 'package:ai_chat/core/constants/textstyles/text_styles.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';

class ThemeManager{
 static final ThemeData dark = ThemeData(
      brightness: Brightness.dark,
      toggleButtonsTheme: ToggleButtonsThemeData(
        color: Colors.red,
        //kColorPrimary,
        selectedColor: kColorPurple,

        borderColor: kColorGrey,
      ) ,
      iconTheme: IconThemeData(
        size: 20,
        color: kColorWhite
      ),
      colorScheme: ColorScheme(
        primary: kColorPurple,
        secondary: kColorCyanAccent,
        error: kColorRedAccent,
        brightness: Brightness.dark,
        onPrimary: kColorPurple,
        onSecondary: kColorCyanAccent,
        onError: kColorRedAccent,
        surface: kColorPrimary,
        onSurface: kColorWhite,
        shadow: kColorGrey
      ),
      primaryColor: kColorPrimary,
      scaffoldBackgroundColor: kColorPrimary,
      textTheme: TextTheme(
        bodyLarge: kStyleWhiteBodyLarge,
        bodySmall: kStyleWhiteBodySmall,
        bodyMedium: kStyleWhiteBodyMedium,
        titleLarge: kStyleWhiteTitleLarge,
        titleMedium: kStyleWhiteTitleMedium,
        titleSmall: kStyleWhiteTitleSmall
      )
    //elevatedButtonTheme:
  );

 static final ThemeData light = ThemeData(
      brightness: Brightness.light,
     toggleButtonsTheme: ToggleButtonsThemeData(
       color: kColorWhite,
       selectedColor: kColorPurple,
       borderColor: kColorGrey,
     ) ,
     iconTheme: IconThemeData(
         size: 20,
         color: kColorPrimary
     ),
     colorScheme: ColorScheme(
       primary: kColorPurple,
       secondary: kColorCyanAccent,
       error: kColorRedAccent,
       brightness: Brightness.light,
       onPrimary: kColorPurple,
       onSecondary: kColorCyanAccent,
       onError: kColorRedAccent,
       surface: kColorWhite,
       onSurface: kColorPrimary,
       shadow: kColorGrey.shade100
     ),
     primaryColor: kColorWhite,
     scaffoldBackgroundColor: kColorWhite,
     textTheme: TextTheme(
         bodyLarge: kStyleBlackBodyLarge,
         bodySmall: kStyleBlackBodySmall,
         bodyMedium: kStyleBlackBodyMedium,
         titleLarge: kStyleBlackTitleLarge,
         titleMedium: kStyleBlackTitleMedium,
         titleSmall: kStyleBlackTitleSmall
     )
   //
  );


 static ThemeData getTheme(BuildContext context){
   return Theme.of(context);
 }
}