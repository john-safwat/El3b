import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Domain/UseCase/GetAllGiveGamesUseCase.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/HomeTabNavigator.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/HomeTabViewModel.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/Widgets/GivaawayList.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomSearchBar.dart';
import 'package:El3b/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:El3b/Presentation/UI/Widgets/LanguageSwitch.dart';
import 'package:El3b/Presentation/UI/Widgets/ThemeSwitch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTabView extends StatefulWidget {
  const HomeTabView({super.key});
  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends BaseState<HomeTabView , HomeTabViewModel> implements HomeTabNavigator {
  @override
  void initState() {
    super.initState();
    viewModel!.getGames();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const CustomSearchBarButton(),
        toolbarHeight: 90
      ),
      body: ChangeNotifierProvider(
        create: (context) => viewModel!,
        child: Consumer<HomeTabViewModel>(
          builder: (context, value, child) {
            if (value.errorMessage != null){
              return ErrorMessageWidget(errorMessage: value.errorMessage! , fixErrorFunction: viewModel!.getGames,);
            }else if(value.listGiveawayGames.isEmpty){
              return const Center(child: CircularProgressIndicator(),);
            }else {
              return Column(
                children: [
                  GiveawayList(games: value.listGiveawayGames,),
                  const SizedBox(height: 20,),
                  const ThemeSwitch(),
                  const SizedBox(height: 20,),
                  const LanguageSwitch()
                ],
              );
            }
          },
        ),
      ),
    );
  }

  @override
  HomeTabViewModel initViewModel() {
    return HomeTabViewModel(
      getAllGiveGamesUseCase: injectGetAllGiveGamesUseCase()
    );
  }
}
