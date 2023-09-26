import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:El3b/Domain/UseCase/GetGameDetailsUseCase.dart';
import 'package:El3b/Presentation/UI/GameDetails/GameDetailsNavigator.dart';
import 'package:El3b/Presentation/UI/GameDetails/GameDetailsViewModel.dart';
import 'package:El3b/Presentation/UI/GameDetails/Widgets/DiscriptionWidget.dart';
import 'package:El3b/Presentation/UI/GameDetails/Widgets/ImagesSlider.dart';
import 'package:El3b/Presentation/UI/GameDetails/Widgets/MetacriticPlatformsRatingsWidget.dart';
import 'package:El3b/Presentation/UI/GameDetails/Widgets/RatingWidget.dart';
import 'package:El3b/Presentation/UI/GameDetails/Widgets/ReleaseDateWidget.dart';
import 'package:El3b/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class GameDetailsView extends StatefulWidget {

  static const String routeName = "GameDetails";

  RAWGGame game;
  GameDetailsView({required this.game , super.key});

  @override
  State<GameDetailsView> createState() => _GameDetailsViewState();
}

class _GameDetailsViewState extends BaseState<GameDetailsView , GameDetailsViewModel> implements GameDetailsNavigator{

  @override
  void initState() {
    super.initState();
    viewModel!.getGameDetails();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            viewModel!.game.name??"No Name",
          ),
        ),
        body: Stack(
          children: [
            // the backGround Image
            CachedNetworkImage(
              imageUrl: viewModel!.game.backgroundImage??"",
              imageBuilder: (context, imageProvider) => Stack(
                children: [
                  Image(image: imageProvider,
                    fit: BoxFit.cover ,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: MyTheme.darkPurple.withOpacity(0.75),
                  )
                ],
              ),
              errorWidget: (context, url, error) =>  Image.asset(
                "Assets/Images/errorImage.png" ,
                fit: BoxFit.cover ,
                width: double.infinity,
                height: double.infinity,
              ),
              placeholder: (context, url) => Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: MyTheme.lightPurple,
                    borderRadius: BorderRadius.circular(15)
                ),
                child:const Center(child: CircularProgressIndicator(color: MyTheme.offWhite,),),
              ),
            ),
            // the screen content
            SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 80,),
                    // the game screen shots
                    ImagesSlider(images: viewModel!.game.shortScreenshots??[]),
                    Consumer<GameDetailsViewModel>(
                        builder: (context, value, child) {
                          if (value.gameErrorMessage != null){
                            return ErrorMessageWidget(
                                errorMessage: value.gameErrorMessage!,
                                fixErrorFunction: value.getGameDetails
                            );
                          }else if (value.gameDetails == null){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: value.themeProvider!.isDark()
                                      ? Lottie.asset(
                                      "Assets/Animations/loading2.json",
                                      width: 150,
                                      height: 120)
                                      : Lottie.asset(
                                      "Assets/Animations/loading3.json",
                                      width: 300,
                                      height: 300),
                                ),
                              ],
                            );
                          }else {
                            return Column(
                              children: [
                                ReleaseDateWidget(date: value.gameDetails!.released??"--/--/----"),
                                // change the design of the metacitic rating
                                // MetacriticPlatformsRatingsWidget(metacriticPlatforms: value.gameDetails!.metacriticPlatforms??[])
                                // the game description
                                DescriptionWidget(title: value.local!.description,description: value.gameDetails!.descriptionRaw??value.local!.noDescription),
                                RatingWidget(title: value.local!.rating, count: value.calcGameRatingsCount(), ratings: value.gameDetails!.ratings??[])
                              ],
                            );
                          }
                        },
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

  @override
  GameDetailsViewModel initViewModel() {
    return GameDetailsViewModel(
      game: widget.game,
      getGameDetailsUseCase: injectGetGameDetailsUseCase()
    );
  }
}
