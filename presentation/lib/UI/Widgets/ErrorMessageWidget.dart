import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:core/Providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
          Lottie.asset("Assets/Animations/errorImage.json" ,width: double.infinity ,fit: BoxFit.cover ),
          const SizedBox(height: 10,),
          Text(errorMessage , style: Theme.of(context).textTheme.displayMedium,),
          const SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () => fixErrorFunction(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10),
              child: Text(local.tryAgain),
            ),
          ),
        ],
      ),
    );
  }
}
