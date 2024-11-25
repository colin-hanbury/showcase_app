import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcase_app/blocs/theme/theme_bloc.dart';
import 'package:showcase_app/blocs/theme/theme_event.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'Change theme',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: _themeButton(),
          ),
        ],
      ),
    );
  }

  Widget _themeButton() {
    return PopupMenuButton<int>(
      tooltip: 'Theme',
      padding: const EdgeInsets.all(10.0),
      constraints: const BoxConstraints(
        minWidth: 50.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      icon: Icon(
        Icons.format_color_fill_outlined,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          padding: const EdgeInsets.all(.0),
          value: 1,
          child: Center(
            child: ListTile(
              title: const Text('Light'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.light,
                groupValue: context.read<ThemeBloc>().state.mode,
                onChanged: (mode) {
                  context.read<ThemeBloc>().add(ThemeChanged(mode: mode!));
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        PopupMenuItem<int>(
          padding: const EdgeInsets.all(0.0),
          value: 1,
          child: Center(
            child: ListTile(
              title: const Text('Dark'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: context.read<ThemeBloc>().state.mode,
                onChanged: (mode) {
                  context.read<ThemeBloc>().add(ThemeChanged(mode: mode!));
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        PopupMenuItem<int>(
          padding: const EdgeInsets.all(0.0),
          value: 1,
          child: Center(
            child: ListTile(
              title: const Text('System'),
              leading: Radio<ThemeMode>(
                  value: ThemeMode.system,
                  groupValue: context.read<ThemeBloc>().state.mode,
                  onChanged: (mode) {
                    context.read<ThemeBloc>().add(ThemeChanged(mode: mode!));
                    Navigator.pop(context);
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
