import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/index.dart';
import 'package:haimezjohn/src/models/portfolio/schema/portfolio_schema.dart';
import 'package:haimezjohn/src/models/portfolio/state/portfolio_provider.dart';
import 'package:haimezjohn/src/utils/const/text_error.dart';
import 'package:haimezjohn/src/utils/mixins/validator.dart';

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

  /// creation portfolio
  Future<void> _createPortfolio() async {
    if (_formKey.currentState!.validate()) {
      /// creation portfolio
      final newPortfolio = PortfolioSchema(
        subTitle: _subTitle.text.trim(),
        title: _title.text.trim(),
      );

      /// creation dans la bdd
      await ref.watch(portfolioChange).addPortfolio(newPortfolio);
      Notif(
        text: 'Creation réussis',
        error: false,
      ).notification(context);
    } else {
      Notif(
        text: 'Impossible de créer le profil',
        error: true,
      ).notification(context);
    }
  }

  /// update portfolio
  Future<void> _updatePortfolio(String idPortfolio) async {
    if (_formKey.currentState!.validate()) {
      /// creation du portfolio
      final newPortfolio = PortfolioSchema(
        subTitle: _subTitle.text.trim(),
        title: _title.text.trim(),
      );

      /// modification de la bdd
      await ref
          .watch(portfolioChange)
          .updatePortfolio(idPortfolio, newPortfolio);
      Notif(
        text: 'Modification réussis',
        error: false,
      ).notification(context);
    } else {
      Notif(
        text: 'Impossible de modifier le profil',
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// on recupere la largeur
    final _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width > 700 ? 600 : double.infinity,
      margin: const EdgeInsets.only(top: 30.0, bottom: 50.0),
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Form(
        key: _formKey,
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
                        children: [
                          /// input title
                          inputBasic(
                            controller: _title,
                            labelText: 'Titre du portfolio',
                            validator: (value) =>
                                Validator.validatorInputTextBasic(
                              textError: TextError.inputErrorTitle,
                              value: value,
                            ),
                          ),

                          /// input subTitle
                          inputBasic(
                            controller: _subTitle,
                            labelText: 'Sous titre',
                            validator: (value) =>
                                Validator.validatorInputTextBasic(
                              textError: 'Texte oblogatoire',
                              value: value,
                            ),
                          ),

                          /// btn create/update
                          btnElevated(
                            onPressed: () async {
                              portfolio != null
                                  ? await _updatePortfolio(portfolio.id!)
                                  : await _createPortfolio();
                            },
                            text: 'Enregistrer',
                          ),
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
