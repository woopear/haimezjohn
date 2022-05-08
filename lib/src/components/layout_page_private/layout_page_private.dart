import 'package:flutter/material.dart';
import 'package:haimezjohn/src/components/side_menu/side_menu.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';

Widget layoutPagePrivate({
  required Widget child,
  required BuildContext context,
}) {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  return SafeArea(
    child: Scaffold(
      key: _drawerKey,
      drawer:
          sideMenu(nameUserConnected: 'Bienvenu John Haimez', context: context),
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  _drawerKey.currentState!.openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              actions: const [],
            )
          : const PreferredSize(
              preferredSize: Size.zero,
              child: SizedBox(),
            ),
      body: Row(
        children: [
          /// menu
          if (Responsive.isDesktop(context))
            Expanded(
              flex: 1,
              child: sideMenu(
                context: context,
                nameUserConnected: 'Bienvenu John Haimez',
              ),
            ),

          /// content
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Center(
                child: child,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
