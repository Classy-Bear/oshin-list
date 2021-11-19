part of 'widgets.dart';

class TaskTileWidget extends StatelessWidget {
  final Task task;
  final Function(Task) onLongPress;
  final Function(Task) onDone;
  final Function(Task) onDelete;

  const TaskTileWidget({
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
        color: Color(task.selectedColor),
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
              color: Color(task.selectedColor),
            ),
          ),
          title: Text(task.title ?? ''),
          textColor: Color(task.selectedColor),
          subtitle: Text(
            'Date due: ${task.date?.formatedDate ?? "Date not found"}',
          ),
          trailing: const Icon(
            Icons.remove,
            color: Colors.transparent,
          ),
          children: [
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(task.description ?? ''),
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
                        onDelete(task);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.check_circle_outline_outlined,
                        color: Color(task.selectedColor),
                      ),
                      onPressed: () {
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
