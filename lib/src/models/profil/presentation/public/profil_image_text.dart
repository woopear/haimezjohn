import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
                image: 'https://2v5q6w6a.directus.app/assets/${profil.image}',
                margin: const EdgeInsets.only(bottom: 20.0),
                size: Responsive.isDesktop(context) ? 400 : 200,
                context: context,
              ),

              /// title
              Container(
                margin: const EdgeInsets.only(bottom: 50.0),
                child: Text(
                  profil.title,
                  style: const TextStyle().copyWith(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.isDesktop(context) ? 38 : 20,
                  ),
                ),
              ),
            ],
          ),
        ),

        /// text
        SizedBox(
          width: 600,
          child: Html(
            data: profil.text,
          ),
        ),
      ],
    ),
  );
}
