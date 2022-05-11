import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/layout_page_public/layout_page_public.dart';
import 'package:haimezjohn/src/components/title_cat_public/title_cat_public.dart';
import 'package:haimezjohn/src/components/waiting_error/waiting_error.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models/condition_gene/models/article_condition/state/article_condition_provider.dart';
import 'package:haimezjohn/src/models/condition_gene/state/condition_gene_provider.dart';
import 'package:haimezjohn/src/utils/config/theme/colors.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';

class ConditionGenePagePublic extends ConsumerStatefulWidget {
  const ConditionGenePagePublic({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConditionGenePagePublicState();
}

class _ConditionGenePagePublicState
    extends ConsumerState<ConditionGenePagePublic> {
  @override
  Widget build(BuildContext context) {
    final conditionGene = ref.watch(conditionGeneAllStream);

    return layoutPagePublic(
      context: context,
      seeAppBar: true,
      child: SizedBox(
        width: Responsive.isDesktop(context) ? 900 : double.infinity,
        child: conditionGene.when(
          data: (conditions) {
            /// la condition
            final condition = conditions[0];

            return Container(
              child: condition != null
                  ? Column(
                      children: [
                        /// title
                        titleCatPublic(
                            title: condition.title,
                            subTitle:
                                'du ${condition.date!.toDate().month < 10 ? '0${condition.date!.toDate().month}' : '${condition.date!.toDate().month}'}/${condition.date!.toDate().year}',
                            context: context,
                            oneOnOne: true,
                            margin: const EdgeInsets.only(bottom: 90.0)),

                        /// liste des articles
                        ref
                            .watch(articleConditionAllStream(condition.id!))
                            .when(
                              data: (articles) {
                                return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: articles.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final article = articles[index];
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 50.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          /// title de l'article
                                          Container(
                                            margin: const EdgeInsets.only(top: 50.0, bottom: 30),
                                            child: Text(
                                            article.title,
                                            style: const TextStyle().copyWith(
                                              fontSize: 28,
                                              color: ColorCustom().blueLight,
                                            ),
                                          ),
                                          ),
                                          

                                          /// contenue de l'article
                                          Text(article.text),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              error: (error, stack) => WaitingError(
                                messageError:
                                    'Impossible de recuperer les articles',
                              ),
                              loading: () => WaitingLoad(),
                            ),
                      ],
                    )
                  : Container(),
            );
          },
          error: (error, stack) => WaitingError(
            messageError: 'Impossible de récuperer les conditions',
          ),
          loading: () => WaitingLoad(),
        ),
      ),
    );
  }
}
