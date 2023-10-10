import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hr_management/organization/provider/language_translation_provider.dart';
import 'package:flutter_hr_management/organization/provider/localization_provider.dart';
import 'package:flutter_hr_management/organization/util/app_constants.dart';
import 'package:translator/translator.dart';

class CustomText extends StatelessWidget {
  CustomText(this.data, {Key? key, this.language, this.style, this.strutStyle, this.textAlign, this.textDirection, this.locale, this.softWrap, this.overflow, this.textScaleFactor, this.maxLines, this.semanticsLabel, this.textWidthBasis, this.textHeightBehavior, }) : super(key: key);
  final translator = GoogleTranslator();
  final String data;
  final String? language;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;



  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
      builder: (context, provider, child)=> FutureBuilder<Translation>(
          future: translator.translate(data, to: language ?? AppConstants.languages[provider.languageIndex].languageCode!),
          builder: (context, snapshot) => snapshot.hasData
              ? Text(
            snapshot.data!.text,
            style: style,
            strutStyle: strutStyle,
            textAlign: textAlign,
            textDirection: textDirection,
            locale: locale,
            softWrap: softWrap,
            overflow: overflow,
            textScaleFactor: textScaleFactor,
            maxLines: maxLines,
            semanticsLabel: semanticsLabel,
            textWidthBasis: textWidthBasis,
            textHeightBehavior: textHeightBehavior,

          )
              : const Text('')),
    );
  }
}
