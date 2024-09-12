import 'package:core/Base/base_state.dart';
import 'package:domain/UseCase/get_genres_use_case.dart';
import 'package:presentation/UI/GamesList/GamesListView.dart';
import 'package:presentation/UI/Home/Tabs/Explore/ExploreTabNavigator.dart';
import 'package:presentation/UI/Home/Tabs/Explore/ExploreTabViewModel.dart';
import 'package:presentation/UI/Home/Tabs/Explore/Widgets/TabButton.dart';
import 'package:presentation/UI/Widgets/CustomSearchBarButton.dart';
import 'package:presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ExploreTabView extends StatefulWidget {
  const ExploreTabView({super.key});

  @override
  State<ExploreTabView> createState() => _ExploreTabViewState();
}

class _ExploreTabViewState
    extends BaseState<ExploreTabView, ExploreTabViewModel>
    implements ExploreTabNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.getGenres();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          titleSpacing: 10,
          centerTitle: true,
          leadingWidth: 0,
          title: CustomSearchBarButton(
            navigation: viewModel.goToSearchScreen,
          ),
        ),
        body: Consumer<ExploreTabViewModel>(
          builder: (context, value, child) {
            if (value.errorMessage != null) {
              return ErrorMessageWidget(
                  errorMessage: value.errorMessage!,
                  fixErrorFunction: value.getGenres);
            } else if (value.genres.isEmpty) {
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
            } else {
              return ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(overscroll: false),
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 15),
                              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.7,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10
                              ),
                            itemBuilder: (context, index) => TabButton(
                              genre: value.genres[index],
                              goToSearchScreen: value.goToGameListScreen,
                            ),
                            itemCount: value.genres.length,
                          ),
                        )
                      ],
                    ),
                  );
            }
          },
        ),
      ),
    );
  }

  @override
  ExploreTabViewModel initViewModel() {
    return ExploreTabViewModel(getGenresUseCase: injectGetGenresUseCase(),);
  }

  @override
  goToGameListScreen(String id) {

    Navigator.pushNamed(context, GamesListView.routeName , arguments: id);
  }
}
