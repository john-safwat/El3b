
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/Base/BaseState.dart';
import 'package:core/Theme/Theme.dart';
import 'package:domain/Models/Developers/Developers.dart';
import 'package:domain/UseCase/GetGameDeveloperDetailsUseCase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lottie/lottie.dart';
import 'package:presentation/UI/DeveloperProfile/DeveloperProfileNavigator.dart';
import 'package:presentation/UI/DeveloperProfile/DeveloperProfileViewModel.dart';
import 'package:presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:provider/provider.dart';

class DeveloperProfileView extends StatefulWidget {

  Developer developer;
  DeveloperProfileView({required this.developer , super.key});

  @override
  State<DeveloperProfileView> createState() => _DeveloperProfileViewState();
}

class _DeveloperProfileViewState extends BaseState<DeveloperProfileView , DeveloperProfileViewModel> implements DeveloperProfileNavigator {

  @override
  void initState() {
    super.initState();
    viewModel.getDeveloperDetails();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        // the backGround Image
        CachedNetworkImage(
          imageUrl: viewModel.developer.imageBackground??"",
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
                color: MyTheme.darkPurple,
                borderRadius: BorderRadius.circular(15)
            ),
            child:const Center(child: CircularProgressIndicator(color: MyTheme.offWhite,),),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(viewModel.developer.name??"No Name"),
          ),
          body: ChangeNotifierProvider(
            create: (context) => viewModel,
            child: Consumer<DeveloperProfileViewModel>(
              builder:(context, value, child) {
                if(value.errorMessage != null){
                  return ErrorMessageWidget(
                      errorMessage: value.errorMessage!,
                      fixErrorFunction: value.getDeveloperDetails
                  );
                }else if (value.notLoaded){
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
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Row(children: [SizedBox(height: 60,)],),
                          Container(
                            margin: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              border: Border.all(width: 2 , color: MyTheme.lightPurple),
                              borderRadius: BorderRadius.circular(1000),
                              boxShadow: const [
                                BoxShadow(
                                  color: MyTheme.lightPurple,
                                  blurRadius: 50,
                                  spreadRadius: 10,
                                  offset: Offset(0,0)
                                )
                              ]
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: CachedNetworkImage(
                                imageUrl: value.developer.image ?? "",
                                imageBuilder: (context, imageProvider) => Image(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  width: 150,
                                  height: 150,
                                ),
                                errorWidget: (context, url, error) => Image.asset(
                                  "Assets/Images/errorImage.png",
                                  fit: BoxFit.cover,
                                  width: 150,
                                  height: 150,
                                ),
                                placeholder: (context, url) => Container(
                                  width: 150,
                                  height: 150,
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
                          ),
                          HtmlWidget(
                            value.developer.description??'No Description' ,
                            textStyle: Theme.of(context).textTheme.displayMedium,
                          )
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ),
      ],
    );
  }

  @override
  DeveloperProfileViewModel initViewModel() {
    return DeveloperProfileViewModel(
      developer: widget.developer,
      getGameDeveloperDetailsUseCase: injectGetGameDeveloperDetailsUseCase()
    );
  }
}
