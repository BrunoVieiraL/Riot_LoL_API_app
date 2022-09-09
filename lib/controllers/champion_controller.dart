import 'package:lol_api_getx_dio_app/services/champion_api.dart';

class ChampionController {
  Future<Map<String, dynamic>> mapChampion = ChampionApi.getAllChampion();
}
