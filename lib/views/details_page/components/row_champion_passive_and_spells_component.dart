import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/tap_champion_spell_widget.dart';
import '../components/tap_champion_passive_component.dart';

class RowChampionPassiveAndSpellsComponent extends StatelessWidget {
  const RowChampionPassiveAndSpellsComponent({
    Key? key,
    required this.onTapText,
    required this.championPassiveDescription,
    required this.championPassiveName,
    required this.championPassive,
    required this.championSpellDescription,
    required this.championSpellsName,
    required this.championSpells,
  }) : super(key: key);

  final RxString onTapText;
  final String? championPassiveDescription;
  final String? championPassiveName;
  final String? championPassive;
  final Iterable<String?> championSpellDescription;
  final Iterable<String?> championSpellsName;
  final Iterable<String?> championSpells;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TapChampionPassiveComponent(onTapText: onTapText, championPassiveDescription: championPassiveDescription, championPassiveName: championPassiveName, championPassive: championPassive),
        TapChampionSpellCustomWidget(
          onTapText: onTapText,
          championSpellDescription: championSpellDescription,
          championSpellsName: championSpellsName,
          championSpells: championSpells,
          index: 0,
        ),
        TapChampionSpellCustomWidget(
          onTapText: onTapText,
          championSpellDescription: championSpellDescription,
          championSpellsName: championSpellsName,
          championSpells: championSpells,
          index: 1,
        ),
        TapChampionSpellCustomWidget(
          onTapText: onTapText,
          championSpellDescription: championSpellDescription,
          championSpellsName: championSpellsName,
          championSpells: championSpells,
          index: 2,
        ),
        TapChampionSpellCustomWidget(
          onTapText: onTapText,
          championSpellDescription: championSpellDescription,
          championSpellsName: championSpellsName,
          championSpells: championSpells,
          index: 3,
        ),
      ],
    );
  }
}
