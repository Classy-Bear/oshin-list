import 'package:oshin_list/modules/task/bloc/bloc.dart';
import 'package:task_repository/task_repository.dart';
import 'package:mockito/annotations.dart';


/// Gemerate files with this command:
/// flutter packages pub run build_runner build --delete-conflicting-outputs
@GenerateMocks([
    TaskBloc, 
    TaskDataProvider,
])
void main() {}