import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcase_app/blocs/navigation/nav_bloc.dart';
import 'package:showcase_app/blocs/navigation/nav_event.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<StatefulWidget> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) =>

      /// Not web app and is Apple device
      !kIsWeb && (Platform.isIOS || Platform.isMacOS)
          ? CupertinoTabBar(
              onTap: (int index) => context.read<NavBloc>().add(
                    PageChangedEvent(
                      index: index,
                    ),
                  ),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  tooltip: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.settings),
                  tooltip: 'Settings',
                ),
              ],
            )
          : NavigationBar(
              onDestinationSelected: (int index) => context.read<NavBloc>().add(
                    PageChangedEvent(
                      index: index,
                    ),
                  ),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            );
}
