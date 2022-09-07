class Champion {
  Champion({
    required this.data,
  });

  Map<String, ChampionInfo> data;

  factory Champion.fromMap(Map<String, dynamic> json) => Champion(
        data: Map.from(json["data"]).map(
          (key, value) => MapEntry<String, ChampionInfo>(
            key,
            ChampionInfo.fromMap(value),
          ),
        ),
      );
}

class ChampionInfo {
  ChampionInfo({
    required this.nameGlobal,
    required this.namePtBr,
    required this.title,
  });

  String nameGlobal;
  String namePtBr;
  String title;

  factory ChampionInfo.fromMap(Map<String, dynamic> json) => ChampionInfo(
        nameGlobal: json['id'],
        namePtBr: json["name"],
        title: json["title"],
      );
}
