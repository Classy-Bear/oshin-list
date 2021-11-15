import 'package:flutter/material.dart';
import 'package:oshin_list/core/widgets/filter_chips/filter_chips.dart';
import 'package:oshin_list/core/widgets/task_tile/task_tile.dart';
import 'package:task_repository/task_repository.dart';

class TasksScreen extends StatelessWidget {

 TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  
    Column(
        children:[
          //=======Filters row==========
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: FilterChipsRow(
              filtersList: const[
                'Recently added',
                'Pending today',
                'Done',
                'OverDue',
                'highest pripority'
              ],
              onFilterSelect: (f){},
            ),
          ),

          //=======Tasks=========
          ListView.builder(
            shrinkWrap: true,
            itemCount: tasks.length ,
            itemBuilder: (BuildContext context, int index){
              
              Task task = tasks[index];

              return TaskTile(
                task: task,
                onDone: (rt){},
                onDelete: (rt){},
                onLongPress: (rt){},
              );
            },
          )
        ], 
      );
  }

    List<Task> tasks = [
                Task.create(
                  'terminar el homescreen',
                  'se supone que debo deterinar la pantalla principal donde se mostrarán los tasks, pero no se muy bien como la haré', 
                  1, 
                  0xff5600D3,
                  DateTime.now(),
                  false,
                ),
                Task.create(
                  'terminar el homescreen',
                  'se supone que debo deterinar la pantalla principal donde se mostrarán los tasks, pero no se muy bien como la haré', 
                  1, 
                  0xff09876A,
                  DateTime.now(),
                  false,
                ),
  ];
}