import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neptune/main.dart';
import 'package:neptune/router/router.dart';

import '../bloc/audio.dart';
import 'icon_button.dart';

class SoundAndSettings extends StatelessWidget {

  const SoundAndSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 5 * MediaQuery.of(context).devicePixelRatio),
            child: CustomIconButton(
              path: 'assets/icons/settings.svg',
              callback: (_) {
                context.router.push(const SettingsRoute());
              },
            ),
          )
        ],
      ),
    );
  }
}
