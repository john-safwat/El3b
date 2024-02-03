import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Domain/UseCase/SendFeedbackUseCase.dart';
import 'package:El3b/Presentation/UI/Feedback/FeedbackNavigator.dart';
import 'package:El3b/Presentation/UI/Feedback/FeedbackViewModel.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomLongTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackView extends StatefulWidget {

  static const String routeName = "Feedback";
  const FeedbackView({super.key});

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends BaseState<FeedbackView , FeedbackViewModel> implements FeedbackNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.local!.feedback),
      ),
      body: Column(
        children: [
          Expanded(
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text(
                    viewModel.local!.feedbackMessage,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        letterSpacing: 1
                    ),
                  ),
                  const SizedBox(height: 40,),
                  Row(
                    children: [
                      Text(
                        viewModel.local!.rating,
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  RatingBar.builder(
                    initialRating: viewModel.rating,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    glowColor: Colors.amber,
                    maxRating: 5,
                    unratedColor: Colors.grey,
                    itemPadding:const EdgeInsets.symmetric(horizontal: 5.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      viewModel.changeRating(rating);
                    },
                  ),
                  const SizedBox(height: 30,),
                  CustomLongTextFormField(
                    label: viewModel.local!.yourFeedback,
                    controller: viewModel.controller,
                    inputType: TextInputType.text,
                    validator: viewModel.feedbackValidation,
                  ),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                      onPressed: viewModel.sendFeedback,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                                viewModel.local!.sendYourFeedback
                            ),
                          ),
                        ],
                      )
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }

  @override
  FeedbackViewModel initViewModel() {
    return FeedbackViewModel(
      useCase: injectSendFeedbackUseCase()
    );
  }
}
