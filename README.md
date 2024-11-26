# Showcase App

A showcase Flutter app to demonstrate the app development skills of Colin Hanbury for a developer role at Adapptor.

## Getting Started


### Local Setup

* Install flutter & dart
  * https://docs.flutter.dev/get-started/install
* get dependencies
  flutter pub get
* create a .dotenv file in lib directory
* populate baseurl with localhost url
    - BASE_URL=http://localhost:8080
* setup and run local server
  * see https://github.com/colin-hanbury/showcase_server for details
* run in chrome or android (iOS not yet tested) using the following:
  flutter run lib/main.dart

#### Express Startup Guide

* flutter pub get
* create a .dotenv file in lib directory
* populate baseurl with localhost url
  - BASE_URL=https://showcase-api-service-378876075190.australia-southeast2.run.app
* run in chrome or android (iOS not yet tested) using the following:
  * flutter run lib/main.dart


## Tech

### Flutter

* Cross-platform
* Fast development
  * Pre built components
* Very good native mobile performance

## Architecture

* BLoC pattern
  * Nice state management capabilities
  * Separation of concerns
  * Clean & Readable
* Shared Preferences
  * Fast way persist data across sessions
  * Data is none sensitive for this use-case

## Future Improvements & Extensions

* JSON serialization with code generation
  * Too much boilerplate for a small project like this
  * future proofing against typos and human errors decoding json
* HydratedBloc for state persistence
  * Again, out of scope for this small project but nice to have in the future

