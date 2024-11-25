import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text('Toggle theme'),
          ),
          // Padding(
          //   padding: EdgeInsets.all(5.0),
          //   child: SwitchButton(
          //     mode: context.read<ThemeBloc>().state.mode == ThemeMode.dark,
          //     onChanged: (mode) => context.read<ThemeBloc>().add(
          //         ThemeChanged(mode: mode ? ThemeMode.light : ThemeMode.dark)),
          //   ),
          // ),
        ],
      ),
    );
  }
}
