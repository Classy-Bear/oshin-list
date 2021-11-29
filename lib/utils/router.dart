part of 'utils.dart';

/// Handles the [Route]s that were pushed using [Navigator.pushNamed].
///
/// Use this route generator in [MaterialApp.onGenerateRoute].
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final taskBloc = TaskBloc();
  final taskFormBloc = TaskFormBloc();
  final args = settings.arguments;
  final screenRouteName = settings.name;
  switch (settings.name) {
    case HomePage.route:
      return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: taskBloc),
            BlocProvider.value(value: taskFormBloc),
          ],
          child: const HomePage(),
        ),
      );
    case TaskInformationPage.route:
      Task? task;
      if (args != null) {
        task = Task.fromMap((args as ScreenArguments).data);
      }
      return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: taskBloc),
            BlocProvider.value(value: TaskFormBloc(task: task)),
          ],
          child: const TaskInformationPage(),
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => NotFoundPage(screenRouteName: screenRouteName),
      );
  }
}
