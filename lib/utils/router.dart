part of 'utils.dart';

class AppRouter {
  final _taskBloc = TaskBloc();
  final _taskFormBloc = TaskFormBloc();

  /// Handles the [Route]s that were pushed using [Navigator.pushNamed].
  ///
  /// Use this route generator in [MaterialApp.onGenerateRoute].
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final screenRouteName = settings.name;
    switch (settings.name) {
      case HomePage.route:
        return _homeRoute();
      case TaskInformationPage.route:
        return _taskInformationRoute(args);
      default:
        return MaterialPageRoute(
          builder: (_) => NotFoundPage(screenRouteName: screenRouteName),
        );
    }
  }

  MaterialPageRoute<HomePage> _homeRoute() {
    return MaterialPageRoute(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _taskBloc),
          BlocProvider.value(value: _taskFormBloc),
        ],
        child: const HomePage(),
      ),
    );
  }

  MaterialPageRoute<TaskInformationPage> _taskInformationRoute(Object? args) {
    Task? task;
    try {
      if (args != null) {
        task = Task.fromMap((args as ScreenArguments).data);
      }
    } on TypeError {
      // TODO: `args` no es un tipo de `ScreenArguments`. Loggear esto.
    }
    return MaterialPageRoute(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _taskBloc),
          BlocProvider.value(value: TaskFormBloc(task: task)),
        ],
        child: const TaskInformationPage(),
      ),
    );
  }
}
