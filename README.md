# Showcase App

A showcase Flutter app to demonstrate the app development skills of Colin Hanbury for a developer role at Adapptor.

## Getting Started

### Prerequisites

* Have installed Flutter, Dart and a code editor of your choice

### Local Setup

- flutter pub get
- create a .dotenv file in lib directory
- populate baseurl with localhost url or if swap out localhost for a cloud hosted url
    - BASE_URL=http://localhost:8080
  - or if don't want to set up the local server just use:
    - BASE_URL=https://showcase-api-service-378876075190.australia-southeast2.run.app
- run in chrome or android (iOS not yet tested) using the following: flutter run lib/main.dart

## Tech

### Flutter

* Cross-platform
* Fast development
  * pre built components
* good native mobile performance

## Architecture

* BLoC pattern
    * Nice state management capabilities
    * Separation of concerns
    * Clean & Readable


## Future Improvements & Extensions

* JSON serialization with code generation
  * Too much boilerplate for a small project like this
  * future proofing against typos and human errors decoding json
* HydratedBloc for state persistence
  * Again, out of scope for this small project but nice to have in the future

