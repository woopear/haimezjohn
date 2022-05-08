import 'package:flutter/material.dart';
import 'package:haimezjohn/src/components/side_menu/side_menu_list_item.dart';
import 'package:haimezjohn/src/components/side_menu/side_menu_title.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive_size.dart';

Widget sideMenu({
  required BuildContext context,
  required String nameUserConnected,
  double? width,
}) {
  return SizedBox(
    width: width,
    child: Drawer(
      elevation: 0,
      child: SizedBox(
        width: double.infinity,
        height: ResponsiveSize.screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// title
              sideMenutitle(
                text: nameUserConnected,
              ),

              /// menu
              sideMenuListItem(context: context)
            ],
          ),
        ),
      ),
    ),
  );
}
