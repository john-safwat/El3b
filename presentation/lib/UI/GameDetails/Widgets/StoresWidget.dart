import 'package:core/Theme/theme.dart';
import 'package:domain/Models/Games/GameDetails/Stores.dart';
import 'package:presentation/UI/GameDetails/Widgets/TitleWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StoresWidget extends StatelessWidget {
  String title;
  List<Stores> stores;
  StoresWidget({required this.title, required this.stores, super.key});

  @override
  Widget build(BuildContext context) {
    return stores.isEmpty ? const SizedBox() : Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 20,),
            TitleWidget(title: title),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height:70,
          child: Row(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: stores.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
                  itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: MyTheme.purple,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            width: 2, color: MyTheme.lightPurple)),
                    child: SvgPicture.asset(
                      stores[index].store!.icon ?? "Assets/SVG/browser.svg",
                      color: MyTheme.offWhite,
                      width: 35,
                    ),
                  )
                )
              ),
            ],
          ),
        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}
