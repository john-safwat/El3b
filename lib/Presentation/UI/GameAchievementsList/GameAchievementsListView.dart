import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/UseCase/GetAllGameAchievementsUseCase.dart';
import 'package:El3b/Presentation/UI/GameAchievementsList/GameAchievementsListNavigator.dart';
import 'package:El3b/Presentation/UI/GameAchievementsList/GameAchievementsListViewModel.dart';
import 'package:El3b/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class GameAchievementsListView extends StatefulWidget {

  String gameId;
  GameAchievementsListView({required this.gameId , super.key});

  @override
  State<GameAchievementsListView> createState() => _GameAchievementsListViewState();
}

class _GameAchievementsListViewState extends BaseState<GameAchievementsListView , GameAchievementsListViewModel> implements GameAchievementsListNavigator {

  @override
  void initState() {
    super.initState();
    viewModel!.getGameAchievements();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel!.local!.gameAchievements),
      ),
      body: ChangeNotifierProvider(
        create: (context) => viewModel!,
        builder: (context, child) => Consumer<GameAchievementsListViewModel>(
          builder: (context, value, child) {
            if(value.errorMessage != null){
              return ErrorMessageWidget(
                  errorMessage: value.errorMessage!,
                  fixErrorFunction: value.getGameAchievements
              );
            }else if (value.achievements.isEmpty){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: value.themeProvider!.isDark()
                        ? Lottie.asset("Assets/Animations/loading2.json",
                        width: 150, height: 120)
                        : Lottie.asset("Assets/Animations/loading3.json",
                        width: 300, height: 300),
                  ),
                ],
              );
            }else {
              return Column(
                children: [
                  Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        itemBuilder: (context, index) {

                          if(index != value.achievements.length){
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient:const LinearGradient(
                                      colors: [
                                        MyTheme.lightPurple ,
                                        MyTheme.purple
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight
                                  )
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: CachedNetworkImage(
                                      imageUrl: value.achievements[index].image ?? "",
                                      imageBuilder: (context, imageProvider) => Image(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                        width: 70,
                                        height:70,
                                      ),
                                      errorWidget: (context, url, error) => Image.asset(
                                        "Assets/Images/errorImage.png",
                                        fit: BoxFit.cover,
                                        width: 70,
                                        height: 70,
                                      ),
                                      placeholder: (context, url) => Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            color: MyTheme.lightPurple,
                                            borderRadius: BorderRadius.circular(15)),
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: MyTheme.offWhite,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(value.achievements[index].name??"No Name" , style:const TextStyle(
                                              color: MyTheme.offWhite,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500
                                          ),
                                            maxLines: 1,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(value.achievements[index].description??"No Name" , style:const TextStyle(
                                            color: MyTheme.offWhite,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                            maxLines:2,
                                          ),
                                        ],
                                      )
                                  )
                                ],
                              ),
                            );
                          }else{
                            value.getGameAchievements();
                            return  const Padding(
                              padding: EdgeInsets.all(30.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: MyTheme.offWhite,
                                ),
                              ),
                            );
                          }

                        },
                        itemCount:
                        value.next == null? value.achievements.length :
                        value.achievements.length +1,
                        separatorBuilder: (context, index) =>const SizedBox(height: 15,),
                      )
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  @override
  GameAchievementsListViewModel initViewModel() {
    return GameAchievementsListViewModel(
        gameId: widget.gameId,
        getAllGameAchievementsUseCase: injectGetAllGameAchievementsUseCase()
    );
  }
}
