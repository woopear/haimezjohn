import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/models/condition_gene/models/article_condition/state/article_condition_state.dart';

final articleConditionChange = ChangeNotifierProvider<ArticleConditionState>(
  (ref) => ArticleConditionState(),
);

final articleConditionAllStream =
    StreamProvider.family((ref, String idConditionGene) {
  return ref
      .watch(articleConditionChange)
      .streamAllArticleCondition(idConditionGene);
});
