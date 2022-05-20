import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haimezjohn/src/components/display_image_form/display_image_form.dart';
import 'package:haimezjohn/src/models/techno/schema/techno_schema.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';

Widget technoItem({
  required TechnoSchema techno,
  required BuildContext context,
}) =>
    Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 40,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(Responsive.isDesktop(context) ? 20 : 0),
        ),
      ),
      child: GridTile(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            /// image
            Row(
              children: techno.images.map((e) {
                return displayImage(
                  margin: const EdgeInsets.only(right: 20, bottom: 40),
                  height: 50,
                  circle: true,
                  urlE:
                      'https://8oj0p722.directus.app/assets/${e!.directusFilesId}',
                );
              }).toList(),
            ),

            /// title
            Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  techno.title,
                  style: GoogleFonts.openSans(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            /// text
            Flexible(
              flex: 2,
              child: Html(
                data: techno.text,
              ),
            ),
          ],
        ),
      ),
    );
