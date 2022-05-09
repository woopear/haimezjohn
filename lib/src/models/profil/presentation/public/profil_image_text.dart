import 'package:flutter/material.dart';
import 'package:haimezjohn/src/components/display_avatar_circle/display_avatar_circle.dart';
import 'package:haimezjohn/src/models/profil/schema/profil_schema.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';

Widget profilImageText({
  required BuildContext context,
  required ProfilSchema profil,
}) {
  return Responsive.isDesktop(context)
      ? Container(
          margin: const EdgeInsets.only(top: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// image
              displayAvatartCircle(
                image: profil.image,
                margin: const EdgeInsets.only(left: 80.0),
                size: 200,
                context: context,
              ),

              /// text
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 120.0),
                  child: Text(
                    profil.text,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
        )
      : Container(
          margin: const EdgeInsets.only(top: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// image
              displayAvatartCircle(
                image: profil.image,
                margin: const EdgeInsets.only(bottom: 80.0),
                size: 200,
                context: context,
              ),

              /// text
              Container(
                child: Text(
                  profil.text,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        );
}
