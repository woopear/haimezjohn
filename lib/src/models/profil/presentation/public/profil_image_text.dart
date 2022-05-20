import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haimezjohn/src/components/display_avatar_circle/display_avatar_circle.dart';
import 'package:haimezjohn/src/models/profil/schema/profil_schema.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';

Widget profilImageText({
  required BuildContext context,
  required ProfilSchema profil,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 50.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              /// image
              displayAvatartCircle(
                image: 'https://8oj0p722.directus.app/assets/${profil.image}',
                margin: const EdgeInsets.only(bottom: 20.0),
                size: Responsive.isDesktop(context) ? 400 : 200,
                context: context,
              ),

              /// title
              Container(
                margin: EdgeInsets.only(
                    bottom: Responsive.isDesktop(context) ? 90.0 : 50),
                child: Text(
                  profil.title,
                  style: GoogleFonts.openSans(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.isDesktop(context) ? 38 : 20,
                  ),
                ),
              ),
            ],
          ),
        ),

        /// sub title
        Container(
          child: Text(
            profil.subTitle!,
            style: GoogleFonts.openSans(
              fontSize: Responsive.isDesktop(context) ? 56 : 38,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),

        /// text
        SizedBox(
          width: 650,
          child: Html(
            data: profil.text,
            style: {'*': Style(fontSize: Responsive.isDesktop(context) ? FontSize.xxLarge : FontSize.xLarge)},
          ),
        ),
      ],
    ),
  );
}
