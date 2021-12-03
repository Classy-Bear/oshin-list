import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:task_repository/task_repository.dart';

class TasksGraphics extends StatelessWidget {
  final TaskList tasks;
  final Function(ChartType) onChangedChart;
  final ChartType? selectedChart;
  final int completedCount;
  final int overdueCount;
  final int pendingCount;

  const TasksGraphics({
    Key? key,
    required this.tasks,
    required this.onChangedChart,
    required this.selectedChart,
    required this.completedCount,
    required this.overdueCount,
    required this.pendingCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 320,
          height: 320,
          child: selectedChart == ChartType.pie
              ? _PieGraphics(
                  done: completedCount,
                  overdue: overdueCount,
                  pending: pendingCount,
                )
              : (selectedChart == ChartType.bar)
                  ? _BarsGraphic(
                      done: completedCount,
                      pending: pendingCount,
                      overdue: overdueCount,
                    )
                  : (selectedChart == ChartType.radar)
                      ? _RadarGraphic(
                          done: completedCount,
                          pending: pendingCount,
                          overdue: overdueCount,
                        )
                      : Container(),
        ),
        _GraphicsSelector(
          onSelectionChanged: onChangedChart,
        )
      ],
    );
  }
}

class _GraphicsSelector extends StatefulWidget {
  final Function(ChartType) onSelectionChanged;

  const _GraphicsSelector({Key? key, required this.onSelectionChanged})
      : super(key: key);

  @override
  __GraphicsSelectorState createState() => __GraphicsSelectorState();
}

class __GraphicsSelectorState extends State<_GraphicsSelector> {
  ChartType? currentSelectedGraphic;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      setState(() {
        currentSelectedGraphic = ChartType.bar;
        widget.onSelectionChanged(currentSelectedGraphic!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => updateSelection(ChartType.bar),
          icon: const Icon(Icons.bar_chart),
          color: currentSelectedGraphic == ChartType.bar
              ? Colors.blue.shade700
              : Colors.grey.shade500,
        ),
        const SizedBox(
          height: 30,
        ),
        IconButton(
          onPressed: () => updateSelection(ChartType.pie),
          icon: const Icon(Icons.pie_chart),
          color: currentSelectedGraphic == ChartType.pie
              ? Colors.blue.shade700
              : Colors.grey.shade500,
        ),
        const SizedBox(
          height: 30,
        ),
        IconButton(
          onPressed: () => updateSelection(ChartType.radar),
          icon: const Icon(Icons.radar),
          color: currentSelectedGraphic == ChartType.radar
              ? Colors.blue.shade700
              : Colors.grey.shade500,
        )
      ],
    );
  }

  updateSelection(ChartType selected) {
    setState(() {
      currentSelectedGraphic = selected;
    });

    widget.onSelectionChanged(currentSelectedGraphic!);
  }
}

class _PieGraphics extends StatefulWidget {
  final int pending;
  final int overdue;
  final int done;

  const _PieGraphics({
    Key? key,
    required this.pending,
    required this.overdue,
    required this.done,
  }) : super(key: key);

  @override
  State<_PieGraphics> createState() => _PieGraphicsState();
}

class _PieGraphicsState extends State<_PieGraphics> {
  late double donePercentaje;
  late double overduePercentaje;
  late double pendingPercentaje;

  @override
  void initState() {
    super.initState();

    donePercentaje = 100;
    overduePercentaje = 0;
    pendingPercentaje = 0;

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      generatePieData();
    });
  }

  generatePieData() {
    int total = widget.pending + widget.overdue + widget.done;
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        donePercentaje = ((widget.done * 100) / total);
        pendingPercentaje = ((widget.pending * 100) / total);
        overduePercentaje = ((widget.overdue * 100) / total);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            title: '${donePercentaje.round()} %',
            value: donePercentaje,
            color: Colors.blue.shade300,
          ),
          PieChartSectionData(
            title: '${overduePercentaje.round()} %',
            value: overduePercentaje,
            color: Colors.red.shade500,
          ),
          PieChartSectionData(
            title: '${pendingPercentaje.round()} %',
            value: pendingPercentaje,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}

class _BarsGraphic extends StatefulWidget {
  final int pending;
  final int overdue;
  final int done;

  const _BarsGraphic({
    Key? key,
    required this.done,
    required this.pending,
    required this.overdue,
  }) : super(key: key);

  @override
  State<_BarsGraphic> createState() => _BarsGraphicState();
}

class _BarsGraphicState extends State<_BarsGraphic> {
  late int pendingValue;
  late int overdueValue;
  late int doneValue;

  @override
  void initState() {
    super.initState();

    doneValue = 6;
    pendingValue = 3;
    overdueValue = 2;

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      generateBarsData();
    });
  }

  generateBarsData() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        doneValue = widget.done;
        pendingValue = widget.pending;
        overdueValue = widget.overdue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
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
            getTitles: (double num) {
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
                colors: [
                  Colors.blue.shade300,
                ],
                y: doneValue.toDouble(),
                width: 25,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
              )
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                colors: [Colors.orange],
                y: pendingValue.toDouble(),
                width: 25,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
              )
            ],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [
              BarChartRodData(
                colors: [Colors.red.shade500],
                y: overdueValue.toDouble(),
                width: 25,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _RadarGraphic extends StatefulWidget {
  final int pending;
  final int overdue;
  final int done;

  const _RadarGraphic({
    Key? key,
    required this.done,
    required this.pending,
    required this.overdue,
  }) : super(key: key);

  @override
  State<_RadarGraphic> createState() => _RadarGraphicState();
}

class _RadarGraphicState extends State<_RadarGraphic> {
  late int pendingValue;
  late int overdueValue;
  late int doneValue;

  @override
  void initState() {
    super.initState();

    doneValue = 9;
    pendingValue = 4;
    overdueValue = 7;

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      generateRadarData();
    });
  }

  generateRadarData() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        doneValue = widget.done;
        pendingValue = widget.pending;
        overdueValue = widget.overdue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RadarChart(
      RadarChartData(
        getTitle: (int num) {
          switch (num) {
            case 0:
              return 'Done';
            case 1:
              return 'Pending';
            case 2:
              return 'Overdue';
            default:
              return '';
          }
        },
        radarBorderData: const BorderSide(
          color: Colors.transparent,
        ),
        tickBorderData: const BorderSide(
          color: Colors.transparent,
        ),
        gridBorderData: BorderSide(
          color: Colors.blue.withOpacity(0.7),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        ticksTextStyle: const TextStyle(color: Colors.transparent),
        dataSets: [
          RadarDataSet(
            dataEntries: [
              RadarEntry(value: doneValue.toDouble()),
              RadarEntry(value: pendingValue.toDouble()),
              RadarEntry(value: overdueValue.toDouble()),
            ],
          ),
        ],
      ),
    );
  }
}

enum ChartType { bar, pie, radar }
