import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcase_app/blocs/actions/actions_bloc.dart';
import 'package:showcase_app/blocs/navigation/nav_bloc.dart';
import 'package:showcase_app/blocs/navigation/nav_event.dart';
import 'package:showcase_app/blocs/navigation/nav_state.dart';
import 'package:showcase_app/blocs/theme/theme_bloc.dart';
import 'package:showcase_app/blocs/theme/theme_state.dart';
import 'package:showcase_app/blocs/welcome/welcome_bloc.dart';
import 'package:showcase_app/repos/actions_repo.dart';
import 'package:showcase_app/repos/welcome_repo.dart';
import 'package:showcase_app/routes.dart';
import 'package:showcase_app/views/home_page.dart';
import 'package:showcase_app/views/settings_page.dart';

class ShowcaseApp extends StatelessWidget {
  const ShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (BuildContext context) => WelcomeRepo(),
        ),
        RepositoryProvider(
          create: (BuildContext context) => ActionsRepo(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => WelcomeBloc(
              welcomeRepo: context.read<WelcomeRepo>(),
            ),
          ),
          BlocProvider(
            create: (BuildContext context) => ActionsBloc(
              actionsRepo: context.read<ActionsRepo>(),
            ),
          ),
          BlocProvider(
            create: (BuildContext context) => ThemeBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => NavBloc(),
          ),
        ],
        child: SafeArea(
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) => MaterialApp(
              debugShowCheckedModeBanner: false,
              onGenerateRoute: generateRoute,
              initialRoute: Routes.root,
              title: 'Adapptor Showcase',
              themeMode: state.mode,
              theme: ThemeData(
                colorScheme: const ColorScheme.light(),
                brightness: Brightness.light,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                colorScheme: const ColorScheme.dark(),
              ),
              home: const RootPage(),
            ),
          ),
        ),
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBloc, NavState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: NavigationBar(
            selectedIndex: state.pageIndex,
            onDestinationSelected: (int index) => context.read<NavBloc>().add(
                  PageChangedEvent(
                    index: index,
                  ),
                ),
            destinations: const <Widget>[
              NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
          body: _body(state.pageIndex),
        );
      },
    );
  }

  Widget _body(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const SettingsPage();
      default:
        return const HomePage();
    }
  }
}
