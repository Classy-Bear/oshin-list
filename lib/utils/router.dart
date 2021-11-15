part of 'utils.dart';

/// Handles the [Route]s that were pushed using [Navigator.pushNamed].
///
/// Use this route generator in [MaterialApp.onGenerateRoute].
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    default:
      return MaterialPageRoute(
        builder: (_) {
          return NotFoundPage(screenName: settings.name);
        },
      );
  }
}
