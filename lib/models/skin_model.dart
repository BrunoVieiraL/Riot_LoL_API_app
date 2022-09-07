import '../global_variables/global_variables.dart';

class ChampionSkin {
  ChampionSkin({
    this.data,
  });

  Data? data;

  factory ChampionSkin.fromMap(Map<String, dynamic> json) => ChampionSkin(
        data: Data.fromMap(json["data"]),
      );
}

class Data {
  Data({
    this.championUniqueInfo,
  });

  ChampionUniqueInfo? championUniqueInfo;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        championUniqueInfo: ChampionUniqueInfo.fromMap(json[nameChamp]),
      );
}

class ChampionUniqueInfo {
  ChampionUniqueInfo({
    this.id,
    this.key,
    this.name,
    this.title,
    this.skins,
    this.lore,
    this.spells,
    this.passive,
  });

  String? id;
  String? key;
  String? name;
  String? title;
  List<Spell>? spells;
  List<Skin>? skins;
  String? lore;
  Passive? passive;

  factory ChampionUniqueInfo.fromMap(Map<String, dynamic> json) =>
      ChampionUniqueInfo(
        id: json["id"],
        key: json["key"],
        name: json["name"],
        title: json["title"],
        skins: List<Skin>.from(json["skins"].map((x) => Skin.fromMap(x))),
        lore: json["lore"],
        spells: List<Spell>.from(json["spells"].map((x) => Spell.fromMap(x))),
        passive: Passive.fromMap(json["passive"]),
      );
}

class Skin {
  Skin({
    this.num,
    this.name,
  });

  int? num;
  String? name;

  factory Skin.fromMap(Map<String, dynamic> json) => Skin(
        num: json["num"],
        name: json["name"],
      );
}

class Spell {
  Spell({
    this.id,
    this.name,
    this.description,
  });

  String? id;
  String? name;
  String? description;

  factory Spell.fromMap(Map<String, dynamic> json) => Spell(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );
}

class Passive {
  Passive({
    this.name,
    this.description,
    this.image,
  });

  String? name;
  String? description;
  ImageChampion? image;

  factory Passive.fromMap(Map<String, dynamic> json) => Passive(
        name: json["name"],
        description: json["description"],
        image: ImageChampion.fromMap(json["image"]),
      );
}

class ImageChampion {
  ImageChampion({
    this.full,
    this.sprite,
    this.group,
  });

  String? full;
  String? sprite;
  String? group;

  factory ImageChampion.fromMap(Map<String, dynamic> json) => ImageChampion(
        full: json["full"],
        sprite: json["sprite"],
        group: json["group"],
      );
}
