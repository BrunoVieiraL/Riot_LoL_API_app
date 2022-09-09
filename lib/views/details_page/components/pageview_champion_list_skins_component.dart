import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../global_variables/global_variables.dart';

class PageViewChampionListOfSkinsComponent extends StatelessWidget {
  const PageViewChampionListOfSkinsComponent({
    Key? key,
    required this.pageViewController,
    required this.skinName,
    required this.skinNum,
  }) : super(key: key);

  final PageController pageViewController;
  final List<String?> skinName;
  final List<int?> skinNum;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: PageView.builder(
        controller: pageViewController,
        itemCount: skinName.length,
        itemBuilder: (context, index) => Column(
          children: [
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    '$championImagesPath$nameChamp'
                    '_${skinNum.elementAt(index)}.jpg',
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    skinName.elementAt(index)!.replaceFirst(' ', '\n'),
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                  ),
                  SmoothPageIndicator(
                      controller: pageViewController,
                      count: skinName.length,
                      onDotClicked: (pageIndicator) =>
                          pageViewController.animateToPage(pageIndicator,
                              duration: const Duration(milliseconds: 700),
                              curve: Curves.ease)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
