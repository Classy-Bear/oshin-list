part of 'utils.dart';

/// Handles the [Route]s that were pushed using [Navigator.pushNamed].
///
/// Use this route generator in [MaterialApp.onGenerateRoute].
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePage.route:
      return MaterialPageRoute(
        builder: (_) {
          return BlocProvider(
            create: (context) => TaskBloc(),
            child: const HomePage(),
          );
        },
      );
    case TaskInformationPage.route:
      return MaterialPageRoute(
        builder: (_) {
          return BlocProvider(
            create: (context) => TaskBloc(),
            child: const TaskInformationPage(),
          );
        },
      );
    default:
      return MaterialPageRoute(
        builder: (_) {
          return NotFoundPage(screenName: settings.name);
        },
      );
  }
}
