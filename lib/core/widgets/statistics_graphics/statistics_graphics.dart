import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:task_repository/task_repository.dart';

class TasksGraphics extends StatefulWidget {

  final List<Task> tasks;

  const TasksGraphics({ 
    Key? key,
    required this.tasks, 
    }) : super(key: key);

  @override
  _TasksGraphicsState createState() => _TasksGraphicsState();
}

class _TasksGraphicsState extends State<TasksGraphics> {

  ChartType selectedChart = ChartType.pie;
  int pendingCount = 0, overdueCount = 0,completedCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gtg();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 9,
          child: Container(
            width: 320,
            height: 320,
            child: selectedChart == ChartType.pie? 
            _PieGraphics()
            :(selectedChart == ChartType.bar)?
            _BarsGraphic()
            :(selectedChart == ChartType.radar)?
            _RadarGraphic()
            :_PieGraphics(),
          ),
        ),
        Expanded(
          flex: 1,
          child: _GraphicsSelector(
            onSelectionChanged: (selection){
              setState(() {
                selectedChart = selection;
              });
            },
          ),
        )
      ],
    );
  }

  void gtg(){

    int pending = 0, overdue = 0,completed = 0;

    widget.tasks.forEach((task) { 

      if (task.isPending){
        pending +=1;

      }else if (task.isOverdue){
        overdue +=1;

      }else if (task.completed!){
        completed +=1;
      }
    });

    setState(() {
      pendingCount = pending;
      overdueCount = overdue;
      completedCount = completed;
    });

    print(pendingCount);
    print(overdueCount);
    print(completedCount);
  }
}

class _GraphicsSelector extends StatefulWidget {


  final Function(ChartType) onSelectionChanged;

  _GraphicsSelector({
    Key? key,
    required this.onSelectionChanged
    }) : super(key: key);

  @override
  __GraphicsSelectorState createState() => __GraphicsSelectorState();
}

class __GraphicsSelectorState extends State<_GraphicsSelector> {

  ChartType currentSelectedGraphic = ChartType.pie;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: ()=>updateSelection(ChartType.bar),
          icon: const Icon(Icons.bar_chart),
          color: currentSelectedGraphic == ChartType.bar? Colors.blue.shade700 : Colors.grey.shade500,
        ),
        const SizedBox(height: 30,),
        IconButton(
          onPressed: ()=>updateSelection(ChartType.pie),
          icon: const Icon(Icons.pie_chart) ,
          color: currentSelectedGraphic == ChartType.pie? Colors.blue.shade700 : Colors.grey.shade500,
        ),
        const SizedBox(height: 30,),
        IconButton(
          onPressed: ()=>updateSelection(ChartType.radar),
          icon: const Icon(Icons.radar) ,
          color: currentSelectedGraphic == ChartType.radar? Colors.blue.shade700 : Colors.grey.shade500,
        )
      ],
    );
  }

  updateSelection(ChartType selected){
    setState(() {
      currentSelectedGraphic = selected;
    });

    widget.onSelectionChanged(currentSelectedGraphic);
  }
}

class _PieGraphics extends StatelessWidget {

_PieGraphics({Key? key}) : super(key: key);

    PieChartData pieData = PieChartData(
    sections: [
      PieChartSectionData(
        title: '20%',
        value:20,
     ),
      PieChartSectionData(
        title: '70%',
        value:70,
     ),
      PieChartSectionData(
        title: '10%',
        value:10,
     ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return PieChart(pieData);
  }
}

class _BarsGraphic extends StatelessWidget {

   _BarsGraphic({ Key? key }) : super(key: key);

   BarChartData barData = BarChartData(
    alignment: BarChartAlignment.center,
    groupsSpace: 70,
    gridData: FlGridData(
      show: false,
    ),
    borderData: FlBorderData(
      show: false,
    ),
    titlesData: FlTitlesData(
      rightTitles: SideTitles(
        showTitles: false,
      ),
      topTitles: SideTitles(
        showTitles: false,
      ),
      leftTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
      ),
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 10,
        getTitles: (double num){
          switch (num.toInt()) {
            case 1:
                return 'Done';
            case 2:
              return 'Pending';
            case 3: 
              return 'Overdue';
            default:
              return '';
          }
        },
      ),
      
    ),

    barGroups: [
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            y: 7,
            width: 25,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(7),
              topRight: Radius.circular(7)
            )
          )
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            y: 4,
            width: 25,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(7),
              topRight: Radius.circular(7)
            )
          )
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            y: 3,
            width: 25,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(7),
              topRight: Radius.circular(7)
            )
          )
        ],
      ),
    ]
  );

  @override
  Widget build(BuildContext context) {
    return BarChart(
      barData,
      swapAnimationDuration: Duration(milliseconds: 800),
    );
  }
}

class _RadarGraphic extends StatelessWidget {
  
   _RadarGraphic({Key? key}) : super(key: key);

  RadarChartData radarData = RadarChartData(
    getTitle:(int num){
      switch(num){
        case 0:
         return 'Done';
        case 1:
          return 'Pending';
        case 2:
          return 'Overdue';
        default:
          return '';
      }
    } ,
    radarBorderData: const BorderSide(
      color: Colors.transparent,
    ),
    tickBorderData: const BorderSide(
      color: Colors.transparent,
    ),
    gridBorderData:  BorderSide(
      color: Colors.blue.withOpacity(0.7),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    ticksTextStyle: TextStyle(color: Colors.transparent),

    dataSets: [
      RadarDataSet(

        dataEntries: [
          const RadarEntry(value:4),
          const RadarEntry(value:7),
          const RadarEntry(value:3),
        ]
      ),
    ]
  );

  @override
  Widget build(BuildContext context) {
    return RadarChart(
      radarData,
    );
  }
}

enum ChartType {
  bar,
  pie,
  radar
}