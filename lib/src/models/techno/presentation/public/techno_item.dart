import 'package:flutter/material.dart';
import 'package:haimezjohn/src/components/display_image_form/display_image_form.dart';
import 'package:haimezjohn/src/models/techno/schema/techno_schema.dart';

Widget technoItem({
  required TechnoSchema techno,
}) =>
    Container(
      margin: const EdgeInsets.only(top: 50.0),
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          /// image
          displayImage(circle: true, urlE: techno.image),

          /// title
          Container(
            margin: const EdgeInsets.only(bottom: 40.0),
            child: Text(
              techno.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          /// text
          Text(
            techno.text,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
