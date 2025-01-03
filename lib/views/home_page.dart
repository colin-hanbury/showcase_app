import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcase_app/blocs/actions/actions_bloc.dart';
import 'package:showcase_app/blocs/actions/actions_event.dart';
import 'package:showcase_app/blocs/actions/actions_state.dart';
import 'package:showcase_app/blocs/welcome/welcome_bloc.dart';
import 'package:showcase_app/blocs/welcome/welcome_event.dart';
import 'package:showcase_app/blocs/welcome/welcome_state.dart';
import 'package:showcase_app/models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameInputController = TextEditingController();
  final nationalityInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _layout();
  }

  Widget _layout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<WelcomeBloc, WelcomeState>(builder: (context, state) {
          return _welcomeMessage();
        }),
        BlocBuilder<ActionsBloc, ActionsState>(builder: (context, state) {
          return _actions();
        }),
      ],
    );
  }

  Widget _welcomeMessage() {
    return Center(
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: _messageContent(),
        ),
      ),
    );
  }

  Widget _messageContent() {
    final status = context.read<WelcomeBloc>().state.status;
    switch (status) {
      case WelcomeStatus.loading:
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        );
      case WelcomeStatus.initial:
        context.read<WelcomeBloc>().add(
              GetWelcomeMessage(),
            );
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        );
      default:
        return ListTile(
          title: Text(
            context.read<WelcomeBloc>().state.message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
    }
  }

  Widget _actions() {
    final status = context.read<ActionsBloc>().state.status;

    switch (status) {
      case ActionsStatus.loading:
        return Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: _form(),
            ),
            Center(
              child: CircularProgressIndicator(
                backgroundColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        );
      case ActionsStatus.error:
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error submitting details'),
            ),
          ),
        );
        return _form();
      case ActionsStatus.success:
        context.read<WelcomeBloc>().add(
              GetWelcomeMessage(),
            );
        return _form();
      default:
        return _form();
    }
  }

  Widget _form() {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 500.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                key: const Key("name-field"),
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                ),
                controller: nameInputController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Invalid input';
                  }
                  return null;
                },
              ),
              TextFormField(
                key: const Key("nationality-field"),
                decoration: const InputDecoration(
                  hintText: 'Enter your nationality',
                ),
                controller: nationalityInputController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Invalid input';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            Theme.of(context).colorScheme.secondaryContainer),
                        textStyle: WidgetStateProperty.all(
                          TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
                        )),
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        context.read<ActionsBloc>().add(
                              SubmitDetails(
                                user: User(
                                  name: nameInputController.value.text.trim(),
                                  nationality: nationalityInputController
                                      .value.text
                                      .trim(),
                                ),
                              ),
                            );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
