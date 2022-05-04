import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/title_page_admin/title_page_admin.dart';
import 'package:haimezjohn/src/models/portfolio/presentation/private/portfolio_form.dart';
import 'package:haimezjohn/src/models/projet/presentation/private/projet_form.dart';
import 'package:haimezjohn/src/models/projet/presentation/private/projet_list.dart';

class PortfolioPagePrivate extends ConsumerStatefulWidget {
  const PortfolioPagePrivate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PortfolioPagePrivateState();
}

class _PortfolioPagePrivateState extends ConsumerState<PortfolioPagePrivate> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(child: Container(
            child: Column(
              children: [
                /// title page
                titlePageAdmin(text: 'Portfolio', context: context),

                /// form portfolio
                const PortfolioForm(),
                
                /// list projet
                const ProjetList(),
                
                /// form projet
                const ProjetForm(),
              ],
            ),
          ),), 
        ),
      ),
    );
  }
}