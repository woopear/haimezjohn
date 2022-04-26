import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/index.dart';
import 'package:haimezjohn/src/models/portfolio/schema/portfolio_schema.dart';
import 'package:haimezjohn/src/models/portfolio/state/portfolio_provider.dart';

class PortfolioForm extends ConsumerStatefulWidget {
  const PortfolioForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PortfolioFormState();
}

class _PortfolioFormState extends ConsumerState<PortfolioForm> {
  final _formKey = GlobalKey<FormState>();

  /// input
  TextEditingController _title = TextEditingController(text: '');
  TextEditingController _subTitle = TextEditingController(text: '');

  @override
  void dispose() {
    _title.dispose();
    _subTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// on recupere la largeur
    final _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width > 700 ? 600 : double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
      child: Form(
        child: Column(
          children: [
            ref.watch(portfoliosStream).when(
                  data: (portfolios) {
                    PortfolioSchema? portfolio;

                    if (portfolios.isNotEmpty) {
                      portfolio = portfolios[0];
                      _title = TextEditingController(text: portfolio.title);
                      _subTitle =
                          TextEditingController(text: portfolio.subTitle);
                    }

                    return Container(
                      child: Column(
                        children: const [
                          /// todo faire contenu form
                        ],
                      ),
                    );
                  },
                  error: (error, stack) => WaitingError(
                    messageError: 'Impossible de récuperer les portfolios',
                  ),
                  loading: () => WaitingLoad(),
                ),
          ],
        ),
      ),
    );
  }
}
