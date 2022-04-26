import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/models/portfolio/state/portfolio_state.dart';

/// state de la class PortfolioState
final portfolioChange =
    ChangeNotifierProvider<PortfolioState>((ref) => PortfolioState());

/// stream tous les portfolios
final portfoliosStream = StreamProvider((ref) {
  return ref.watch(portfolioChange).streamPortfolios();
});
