import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcase_app/blocs/theme/theme_bloc.dart';
import 'package:showcase_app/blocs/theme/theme_event.dart';
import 'package:showcase_app/views/components/switch_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchButton(
          mode: context.read<ThemeBloc>().state.mode == ThemeMode.dark,
          onChanged: (mode) => context
              .read<ThemeBloc>()
              .add(ThemeChanged(mode: mode ? ThemeMode.light : ThemeMode.dark)),
        ),
      ],
    );
  }
}
