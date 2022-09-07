import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lol_api_getx_dio_app/global_variables/global_variables.dart';
import 'package:lol_api_getx_dio_app/models/skin_model.dart';
import 'package:lol_api_getx_dio_app/views/home_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../services/champion_api.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var pageViewController = PageController(keepPage: false);

    Future<Map<String, dynamic>> skinChampion =
        ChampionApi.getSkinChampion(nameChamp);
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                Get.off(() => const HomePage());
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text(
                'Voltar',
                style: TextStyle(),
                textDirection: TextDirection.ltr,
                overflow: TextOverflow.clip,
              ),
              style: TextButton.styleFrom(foregroundColor: Colors.white),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: skinChampion,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.active) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final champions = ChampionSkin.fromMap(snapshot.data!);
            var championSkinInfoList =
                champions.data!.championUniqueInfo!.skins!.toList();
            var skinName = championSkinInfoList.map((e) => e.name).toList();
            var skinNum = championSkinInfoList.map((e) => e.num).toList();
            skinName.first = nameChamp;
            var championSpellsList =
                champions.data!.championUniqueInfo!.spells!.toList();
            var championSpells = championSpellsList.map((e) => e.id);
            var championSpellsName = championSpellsList.map((e) => e.name);
            var championSpellDescription =
                championSpellsList.map((e) => e.description);
            var championPassive =
                champions.data!.championUniqueInfo!.passive!.image!.full;
            var championPassiveName =
                champions.data!.championUniqueInfo!.passive!.name;
            var championPassiveDescription =
                champions.data!.championUniqueInfo!.passive!.description;

            var onTapText = ''.obs;
            return Column(
              children: [
                SizedBox(
                  height: 500,
                  child: PageView.builder(
                    controller: pageViewController,
                    itemCount: skinName.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 450,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  NetworkImage('$championImagesPath$nameChamp'
                                      '_${skinNum.elementAt(index)}.jpg'),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                skinName
                                    .elementAt(index)!
                                    .replaceFirst(' ', '\n'),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 25),
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.center,
                              ),
                              SmoothPageIndicator(
                                  controller: pageViewController,
                                  count: skinName.length,
                                  onDotClicked: (pageIndicator) =>
                                      pageViewController.animateToPage(
                                          pageIndicator,
                                          duration:
                                              const Duration(milliseconds: 600),
                                          curve: Curves.ease)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                         onTapText.value = championPassiveDescription!;
                      },
                      child: SizedBox(
                        width: 75,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              championPassiveName!,
                              style: const TextStyle(color: Color(0xFFA7935F)),
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center,
                            ),
                            Image(
                              image: NetworkImage('$championPassivePath'
                                  '$championPassive'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                         onTapText.value = championSpellDescription.elementAt(0)!;
                      },
                      child: spellContainer(championSpellsName, championSpells, 0,
                          championSpellDescription),
                    ),
                    GestureDetector(
                      onTap: () {
                         onTapText.value = championSpellDescription.elementAt(1)!;
                      },
                      child: spellContainer(championSpellsName, championSpells, 1,
                          championSpellDescription),
                    ),
                    GestureDetector(
                      onTap: () {
                        onTapText.value =  onTapText.value = championSpellDescription.elementAt(2)!;
                      },
                      child: spellContainer(championSpellsName, championSpells, 2,
                          championSpellDescription),
                    ),
                    GestureDetector(
                      onTap: () {
                        onTapText.value = championSpellDescription.elementAt(3)!;
                      },
                      child: spellContainer(championSpellsName, championSpells,
                          3, championSpellDescription),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  ()=> Text(
                    onTapText.string,
                    style:
                        const TextStyle(color: Color(0xFFA7935F), fontSize: 15),
                  ),
                ),
              ],
            );
          }

          return Center(
            child: ElevatedButton(
              child: const Icon(Icons.refresh),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const DetailsPage();
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget spellContainer(
    Iterable<String?> spellName,
    Iterable<String?> championSpells,
    int spellIndex,
    Iterable<String?> spellDesc,
  ) {
    return SizedBox(
      width: 75,
      child: Column(
        children: [
          Text(
            spellName.elementAt(spellIndex)!,
            style: const TextStyle(color: Color(0xFFA7935F)),
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
          ),
          Image(
            image: NetworkImage('$championSpellPath'
                '${championSpells.elementAt(spellIndex)}.png'),
          ),
        ],
      ),
    );
  }
}
