import 'package:core/Base/BaseState.dart';
import 'package:core/Theme/Theme.dart';
import 'package:domain/Models/Developers/Developers.dart';
import 'package:domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:domain/UseCase/GetGameAchievementsUseCase.dart';
import 'package:domain/UseCase/GetGameDetailsUseCase.dart';
import 'package:domain/UseCase/GetGameDevelopersUseCase.dart';
import 'package:presentation/UI/DeveloperProfile/DeveloperProfileView.dart';
import 'package:presentation/UI/GameAchievementsList/GameAchievementsListView.dart';
import 'package:presentation/UI/GameDetails/GameDetailsNavigator.dart';
import 'package:presentation/UI/GameDetails/GameDetailsViewModel.dart';
import 'package:presentation/UI/GameDetails/Widgets/DiscriptionWidget.dart';
import 'package:presentation/UI/GameDetails/Widgets/GameAchievementsListWidget.dart';
import 'package:presentation/UI/GameDetails/Widgets/GameDevelopersWidget.dart';
import 'package:presentation/UI/GameDetails/Widgets/GameGenresWidget.dart';
import 'package:presentation/UI/GameDetails/Widgets/GamePlatformsWidget.dart';
import 'package:presentation/UI/GameDetails/Widgets/ImagesSlider.dart';
import 'package:presentation/UI/GameDetails/Widgets/RatingWidget.dart';
import 'package:presentation/UI/GameDetails/Widgets/ReleaseDateWidget.dart';
import 'package:presentation/UI/GameDetails/Widgets/StoresWidget.dart';
import 'package:presentation/UI/GameDetails/Widgets/TagsListWidget.dart';
import 'package:presentation/UI/Widgets/ErrorMessageWidget.dart';
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
    viewModel.getGameDetails();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          // the backGround Image
          CachedNetworkImage(
            imageUrl: viewModel.game.backgroundImage??"",
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
            errorWidget: (context, url, error) =>  Container(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            placeholder: (context, url) => Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: MyTheme.darkPurple,
                  borderRadius: BorderRadius.circular(15)
              )
            ),
          ),

          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                viewModel.game.name??"No Name",
              ),
            ),
            body: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: ListView(
                children: [
                  // the game screen shots
                  ImagesSlider(images: viewModel.game.shortScreenshots??[] , tag: viewModel.game.id.toString()),
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
                              // the game description
                              DescriptionWidget(title: value.local!.description,description: value.gameDetails!.descriptionRaw??value.local!.noDescription),
                              // add image rating
                              RatingWidget(title: value.local!.rating, ratings: value.calcStepsList() , ratingMeanings: value.getRatingMeaning() ,colors:  value.getColorsList()),
                              // the genres of the game
                              GameGenresWidget(title: value.local!.genre, genres: value.gameDetails!.genres??[]),
                              // stores to buy the games
                              StoresWidget(title: value.local!.whereToBuy, stores: value.gameDetails!.stores??[] ),
                              // game developers widget
                              Consumer<GameDetailsViewModel>(
                                  builder: (context, value, child) {
                                    if (value.developersErrorMessage != null){
                                      return const SizedBox();
                                    }else if (!value.gameDevelopersLoaded){
                                      return const Padding(
                                        padding: EdgeInsets.all(40),
                                        child: CircularProgressIndicator(),
                                      );
                                    }else if( value.gameDevelopers.isNotEmpty){
                                      return GameDevelopersWidget(
                                        title: value.local!.developers,
                                        developers: value.gameDevelopers,
                                        goToDeveloperProfile: value.goToGameDeveloperProfile,
                                      );
                                    }else {
                                    return const SizedBox();
                                    }
                                  },
                              ),
                              // the game platforms and its requirements
                              GamePlatformsWidget(
                                title: value.local!.availableOn,
                                platforms: value.gameDetails!.platforms??[]
                              ),
                              // game tags widget
                              TagsListWidget(title: value.local!.tags, tags: value.gameDetails!.tags??[]),
                              // game achievements widget
                              Consumer<GameDetailsViewModel>(
                                builder: (context, value, child) {
                                  if (value.developersErrorMessage != null){
                                    return const SizedBox();
                                  }else if (!value.gameDevelopersLoaded){
                                    return const Padding(
                                      padding: EdgeInsets.all(40),
                                      child: CircularProgressIndicator(),
                                    );
                                  }else if (value.gameAchievements.isNotEmpty){
                                    return GameAchievementsListWidget(
                                      title: value.local!.gameAchievements,
                                      achievements: value.gameAchievements,
                                      buttonTitle: value.local!.viewAll,
                                      goToGameAchievementsList: value.goToAchievementsListScreen,
                                    );
                                  }else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ],
                          );
                        }
                      },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  GameDetailsViewModel initViewModel() {
    return GameDetailsViewModel(
      game: widget.game,
      getGameDetailsUseCase: injectGetGameDetailsUseCase(),
      getGameDevelopersUseCase:  injectGetGameDevelopersUseCase(),
      getGameAchievementsUseCase: injectGetGameAchievementsUseCase()
    );
  }

  @override
  goToDeveloperProfileScreen({required Developer developer}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DeveloperProfileView(developer: developer,)));
  }

  @override
  goToAchievementsListScreen({required String gameId}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => GameAchievementsListView( gameId: gameId,)));
  }
}
