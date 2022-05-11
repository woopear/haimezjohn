import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/layout_partial_public/layout_partial_public.dart';
import 'package:haimezjohn/src/components/title_cat_public/title_cat_public.dart';
import 'package:haimezjohn/src/models/projet/presentation/public/projet_public_list.dart';

class PortfolioPublicWidget extends ConsumerStatefulWidget {
  const PortfolioPublicWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PortfolioPublicWidgetState();
}

class _PortfolioPublicWidgetState extends ConsumerState<PortfolioPublicWidget> {
  @override
  Widget build(BuildContext context) {
    return layoutPartialPublic(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          /// title
          titleCatPublic(
            oneOnOne: true,
            title: 'PortFolio',
            subTitle: 'Ci-dessous, quelques exemples de réalisations effectuées durant la formation, le stage et autre.',
            context: context,
          ),

          /// list des réalisations
          const ProjetPublicList(),
        ],
      ),
    );
  }
}
