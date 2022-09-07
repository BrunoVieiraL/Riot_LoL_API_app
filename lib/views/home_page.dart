import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lol_api_getx_dio_app/controllers/champion_controller.dart';
import 'package:lol_api_getx_dio_app/views/details_page.dart';

import '../global_variables/global_variables.dart';
import '../models/champions_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ChampionController championController = ChampionController();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Center(
            child: Text(
              'Lista de Campeões',
              style: TextStyle(color: Color(0xFFA7935F)),
            ),
          )),
      body: FutureBuilder(
        future: championController.mapChampion,
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
            final champions = Champion.fromMap(snapshot.data!);
            var championList = champions.data.values.toList();

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: championList.length,
              itemBuilder: (context, index) => Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.off(() => const DetailsPage(),
                          arguments: championList.elementAt(index).nameGlobal);
                      nameChamp = championList.elementAt(index).nameGlobal;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Container(
                        width: 200,
                        height: 180,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                '$championImagesPath${championList.elementAt(index).nameGlobal}_0.jpg'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          championList.elementAt(index).namePtBr,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                            championList
                                .elementAt(index)
                                .title
                                .capitalizeFirst!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
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
                      return const HomePage();
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
