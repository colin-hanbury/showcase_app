import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:showcase_app/blocs/actions/actions_bloc.dart';
import 'package:showcase_app/blocs/navigation/nav_bloc.dart';
import 'package:showcase_app/blocs/theme/theme_bloc.dart';
import 'package:showcase_app/blocs/welcome/welcome_bloc.dart';
import 'package:showcase_app/repos/actions_repo.dart';
import 'package:showcase_app/repos/welcome_repo.dart';
import 'package:showcase_app/showcase_app.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(MultiRepositoryProvider(
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
      child: const ShowcaseApp(),
    ),
  ));
}
