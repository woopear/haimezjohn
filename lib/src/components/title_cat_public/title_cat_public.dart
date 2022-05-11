import 'package:flutter/material.dart';
import 'package:haimezjohn/src/utils/config/theme/colors.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';

Widget titleCatPublic({
  required String title,
  required String subTitle,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  bool oneOnOne = false,
  required BuildContext context,
}) {
  double sizeTitle = Responsive.isDesktop(context) ? 86 : 40 ;
  double sizeSubTitle = Responsive.isDesktop(context) ? 40 : 24 ;

  return Container(
    margin: margin,
    padding: padding,
    width: double.infinity,
    child: Responsive.isDesktop(context) || oneOnOne
        ? oneOnOne
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// text base
                  Text(
                    title,
                    textAlign: TextAlign.justify,
                    style: const TextStyle().copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: sizeTitle,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorCustom().greyTextDark
                          : ColorCustom().greyText,
                    ),
                  ),

                  /// super text
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      subTitle,
                      textAlign: TextAlign.justify,
                      style: const TextStyle().copyWith(
                        fontWeight: FontWeight.w200,
                        fontSize: sizeSubTitle,
                      ),
                    ),
                  )
                ],
              )
            : Responsive.isDesktop(context)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      /// text base
                      Text(
                        title,
                        textAlign: TextAlign.justify,
                        style: const TextStyle().copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: sizeTitle,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? ColorCustom().greyTextDark
                              : ColorCustom().greyText,
                        ),
                      ),

                      /// super text
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            subTitle,
                            textAlign: TextAlign.justify,
                            style: const TextStyle().copyWith(
                              fontWeight: FontWeight.w200,
                              fontSize: sizeSubTitle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// text base
              Text(
                title,
                textAlign: TextAlign.justify,
                style: const TextStyle().copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: sizeTitle,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorCustom().greyTextDark
                      : ColorCustom().greyText,
                ),
              ),

              /// super text
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: Text(
                  subTitle,
                  textAlign: TextAlign.justify,
                  style: const TextStyle().copyWith(
                    fontWeight: FontWeight.w200,
                    fontSize: sizeSubTitle,
                  ),
                ),
              ),
            ],
          ),
  );
}
