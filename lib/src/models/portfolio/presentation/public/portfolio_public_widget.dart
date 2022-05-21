import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haimezjohn/src/components/layout_partial_public/layout_partial_public.dart';
import 'package:haimezjohn/src/components/waiting_error/waiting_error.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models/portfolio/state/portfolio_provider.dart';
import 'package:haimezjohn/src/models/projet/presentation/public/projet_public_list.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';

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
          ref.watch(portfolioFuture).when(
                data: (portfolio) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: Responsive.isDesktop(context)
                            ? null
                            : const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          portfolio.title,
                          style: GoogleFonts.openSans(
                            fontSize: Responsive.isDesktop(context) ? 56 : 38,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),

                      /// text
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: Responsive.isDesktop(context)
                            ? null
                            : const EdgeInsets.symmetric(horizontal: 30),
                        width: 600,
                        child: Html(
                          data: portfolio.subTitle,
                          style: {
                            '*': Style(
                              fontSize: Responsive.isDesktop(context)
                                  ? FontSize.xxLarge
                                  : FontSize.xLarge,
                            )
                          },
                        ),
                      ),
                    ],
                  );

                  /// title
                },
                error: (error, stack) => WaitingError(
                  messageError: 'Impossible de récuperer le portfolio',
                ),
                loading: () => WaitingLoad(),
              ),

          /// list des réalisations
          const ProjetPublicList(),
        ],
      ),
    );
  }
}
