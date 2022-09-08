import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_variables/global_variables.dart';

class TapChampionPassiveComponent extends StatelessWidget {
  const TapChampionPassiveComponent({
    Key? key,
    required this.onTapText,
    required this.championPassiveDescription,
    required this.championPassiveName,
    required this.championPassive,
  }) : super(key: key);

  final RxString onTapText;
  final String? championPassiveDescription;
  final String? championPassiveName;
  final String? championPassive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    );
  }
}

