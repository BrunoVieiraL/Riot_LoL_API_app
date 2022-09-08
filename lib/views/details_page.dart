import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lol_api_getx_dio_app/global_variables/global_variables.dart';
import 'package:lol_api_getx_dio_app/models/skin_model.dart';
import 'package:lol_api_getx_dio_app/views/home_page.dart';
import '../services/champion_api.dart';
import 'details_page/components/pageview_champion_list_skins_component.dart';
import 'details_page/components/row_champion_passive_and_spells_component.dart';

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
                PageViewChampionListOfSkinsComponent(pageViewController: pageViewController, skinName: skinName, skinNum: skinNum),
                RowChampionPassiveAndSpellsComponent(
                    onTapText: onTapText,
                    championPassiveDescription: championPassiveDescription,
                    championPassiveName: championPassiveName,
                    championPassive: championPassive,
                    championSpellDescription: championSpellDescription,
                    championSpellsName: championSpellsName,
                    championSpells: championSpells),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => Text(
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
}

