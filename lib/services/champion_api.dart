import 'package:dio/dio.dart';
import '../global_variables/global_variables.dart';

class ChampionApi {
  static Future<Map<String, dynamic>> getAllChampion() async {
    var dio = Dio();
    try {
      var response = await dio.get('${championPath}champion.json');
      return response.data;
    } finally {
      dio.close();
    }
  }

  static Future<Map<String, dynamic>> getSkinChampion(var championId) async {
    var dio = Dio();
    try {
      var response = await dio.get('$championAtual$championId.json');
      return response.data;
    } finally {
      dio.close();
    }
  }
}
