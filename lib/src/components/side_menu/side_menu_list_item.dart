import 'package:flutter/material.dart';
import 'package:haimezjohn/src/components/side_menu/side_menu_item.dart';
import 'package:haimezjohn/src/utils/config/routes/routes.dart';

List<Map<String, dynamic>> textMenu = [
  {
    'name': 'Retour',
    'nav': Routes().home,
    'icon': Icons.home,
  },
  {
    'name': 'Profil',
    'nav': Routes().profilPrivate,
    'icon': Icons.person,
  },
  {
    'name': 'Compétence',
    'nav': Routes().competencePrivate,
    'icon': Icons.school,
  },
  {
    'name': 'Portfolio',
    'nav': Routes().portfolioPrivate,
    'icon': Icons.web,
  },
  {
    'name': 'Contact',
    'nav': Routes().contactPrivate,
    'icon': Icons.contact_mail,
  },
  {
    'name': 'Lien',
    'nav': Routes().linkPagePrivate,
    'icon': Icons.link,
  },
  {
    'name': 'Footer',
    'nav': Routes().footerPagePrivate,
    'icon': Icons.follow_the_signs,
  },
  {
    'name': 'Infos perso',
    'nav': Routes().infoPersoPrivate,
    'icon': Icons.info,
  },
  {
    'name': 'Paramètre',
    'nav': Routes().home,
    'icon': Icons.settings,
  },
  {
    'name': 'Conditions générales',
    'nav': Routes().conditionGenePagePrivate,
    'icon': Icons.account_balance,
  },
];

List<Widget> items(List<Map<String, dynamic>> textMenu, BuildContext context) {
  return textMenu.map((e) {
    return sideMenuItem(
      text: e['name'],
      icon: e['icon'],
      context: context,
      onTapText: () {
        Navigator.popAndPushNamed(context, e['nav']);
      },
    );
  }).toList();
}

Widget sideMenuListItem({
  required BuildContext context,
}) {
  return Column(
    children: [
      ...items(textMenu, context),
    ],
  );
}
