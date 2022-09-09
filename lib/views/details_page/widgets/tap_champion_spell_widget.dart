import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global_variables/global_variables.dart';

class TapChampionSpellCustomWidget extends StatelessWidget {
  const TapChampionSpellCustomWidget({
    Key? key,
    required this.onTapText,
    required this.championSpellDescription,
    required this.championSpellsName,
    required this.championSpells,
    this.championPassiveName,
    this.index,
  }) : super(key: key);

  final RxString onTapText;
  final Iterable<String?> championSpellDescription;
  final Iterable<String?> championSpellsName;
  final Iterable<String?> championSpells;
  final String? championPassiveName;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapText.value = championSpellDescription.elementAt(index!)!;
      },
      child: SizedBox(
        width: 75,
        child: Column(
          children: [
            Text(
              championSpellsName.elementAt(index!)!,
              style: const TextStyle(color: Color(0xFFA7935F)),
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
            ),
            Image(
              image: NetworkImage('$championSpellPath'
                  '${championSpells.elementAt(index!)}.png'),
            ),
          ],
        ),
      ),
    );
  }
}
