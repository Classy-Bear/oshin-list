import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:task_repository/task_repository.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Function(Task) onLongPress;
  final Function(Task) onDone;
  final Function(Task) onDelete;

  const TaskTile({
    Key? key,
    required this.task,
    required this.onDone,
    required this.onDelete,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('dimiss'),
      background: Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        height: double.infinity,
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Icon(
            Icons.cancel,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        width: double.infinity,
        height: double.infinity,
        color: Color(task.color!),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Icon(
            Icons.check,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      child: GestureDetector(
        onLongPress: () {
          onLongPress(task);
        },
        child: ExpansionTile(
          leading: SizedBox(
            height: double.infinity,
            child: Icon(
              Icons.circle,
              color: Color(task.color!),
            ),
          ),
          title: Text(task.title ?? ''),
          textColor: Color(task.color!),

          subtitle: Text(
              'Date due : ${task.date?.day}-${task.date?.month}-${task.date?.year}'),
          //don't wanna nothing in trailing, but need the layout working fine. so a transparent icon is a good solution ;)
          trailing: const Icon(
            Icons.remove,
            color: Colors.transparent,
          ),
          children: [
            Column(
              children: [
                 Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(task.description??''),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        //looking for auto-drag solution
                        onDelete(task);
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.check_circle_outline_outlined,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        //looking for an auto-drag solution
                        onDone(task);
                      },
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class TaskTileList extends StatelessWidget {
//   List<Task> taskList;

//   const TaskTileList(
//     {Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
