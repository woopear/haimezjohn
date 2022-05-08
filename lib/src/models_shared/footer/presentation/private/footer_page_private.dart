import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/layout_content_private/layout_content_private.dart';
import 'package:haimezjohn/src/components/layout_page_private/layout_page_private.dart';
import 'package:haimezjohn/src/components/title_page_admin/title_page_admin.dart';
import 'package:haimezjohn/src/models_shared/footer/presentation/private/footer_form.dart';

class FooterPagePrivate extends ConsumerStatefulWidget {
  const FooterPagePrivate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FooterPagePrivateState();
}

class _FooterPagePrivateState extends ConsumerState<FooterPagePrivate> {
  @override
  Widget build(BuildContext context) {
    return layoutPagePrivate(
      child: layoutContentPrivate(
        children: [
          /// title
          titlePageAdmin(text: 'Le footer', context: context),

          /// formulaire
          const FooterForm(),
        ],
      ),
    );
  }
}
