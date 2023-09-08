import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ErrorMessageWidget extends StatelessWidget {
  String errorMessage;
  Function fixErrorFunction;
  ErrorMessageWidget({required this.errorMessage ,required this.fixErrorFunction , super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    var local = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("Assets/SVG/ErrorImage${theme.isDark()?"":"2"}.svg"),
          const SizedBox(height: 10,),
          Text(errorMessage , style: Theme.of(context).textTheme.displayMedium,),
          const SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () => fixErrorFunction(),
            child: Text(local.tryAgain),
          ),
        ],
      ),
    );
  }
}