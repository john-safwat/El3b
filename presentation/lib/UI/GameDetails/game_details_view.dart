import 'package:core/Base/base_state.dart';
import 'package:core/Theme/theme.dart';
import 'package:domain/Models/Developers/developers.dart';
import 'package:domain/Models/Games/RAWG/rawg_game.dart';
import 'package:domain/UseCase/get_game_achievements_use_case.dart';
import 'package:domain/UseCase/get_game_details_use_case.dart';
import 'package:domain/UseCase/get_game_developers_use_case.dart';
import 'package:presentation/UI/DeveloperProfile/developer_profile_view.dart';
import 'package:presentation/UI/GameAchievementsList/game_achievements_list_view.dart';
import 'package:presentation/UI/GameDetails/game_details_navigator.dart';
import 'package:presentation/UI/GameDetails/game_details_view_model.dart';
import 'package:presentation/UI/GameDetails/Widgets/description_widget.dart';
import 'package:presentation/UI/GameDetails/Widgets/game_achievements_list_widget.dart';
import 'package:presentation/UI/GameDetails/Widgets/game_developers_widget.dart';
import 'package:presentation/UI/GameDetails/Widgets/game_genres_widget.dart';
import 'package:presentation/UI/GameDetails/Widgets/game_platforms_widget.dart';
import 'package:presentation/UI/GameDetails/Widgets/images_slider.dart';
import 'package:presentation/UI/GameDetails/Widgets/rating_widget.dart';
import 'package:presentation/UI/GameDetails/Widgets/release_date_widget.dart';
import 'package:presentation/UI/GameDetails/Widgets/stores_widget.dart';
import 'package:presentation/UI/GameDetails/Widgets/tags_list_widget.dart';
import 'package:presentation/UI/Widgets/error_message_widget.dart';
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
