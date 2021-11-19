part of 'task_form_bloc.dart';

class TaskFormState extends Equatable {
  const TaskFormState({
    this.title = const TitleValidator.pure(),
    this.description = const DescriptionValidator.pure(),
    this.color = const ColorValidator.pure(),
    this.dateTime = const DateTimeValidator.pure(),
    this.type = const TypeValidator.pure(),
    this.status = FormzStatus.pure,
  });

  final TitleValidator title;
  final DescriptionValidator description;
  final ColorValidator color;
  final DateTimeValidator dateTime;
  final TypeValidator type;
  final FormzStatus status;

  @override
  List<Object> get props => [
        title,
        description,
        color,
        color,
        dateTime,
        type,
        status
      ];

  TaskFormState copyWith({
    TitleValidator? title,
    DescriptionValidator? description,
    ColorValidator? color,
    DateTimeValidator? dateTime,
    TypeValidator? type,
    FormzStatus? status,
  }) {
    return TaskFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      color: color ?? this.color,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }
}

