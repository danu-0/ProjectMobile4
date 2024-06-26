import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:Medaran/theme/theme.dart';

class BarChartWidget extends StatelessWidget {
  final List<BarChartGroupData> barChartData;
  final Map<String, int> dailyTotal;

  BarChartWidget({required this.barChartData, required this.dailyTotal});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: barChartData,
        titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 5,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      value.toInt().toString(),
                      style: TextStyle(
                          fontSize: 10, color: primary, fontWeight: semiBold),
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  final dayOfWeek = _getDayFromIndex(value.toInt());
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      dayOfWeek,
                      style: TextStyle(
                          fontSize: 10, color: primary, fontWeight: semiBold),
                    ),
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
        borderData: FlBorderData(show: false),
        barTouchData: BarTouchData(enabled: true),
      ),
    );
  }

  String _getDayFromIndex(int index) {
    switch (index) {
      case 1:
        return 'Senin';
      case 2:
        return 'Selasa';
      case 3:
        return 'Rabu';
      case 4:
        return 'Kamis';
      case 5:
        return 'Jumat';
      case 6:
        return 'Sabtu';
      case 7:
        return 'Minggu';
      default:
        return '';
    }
  }
}

class PieChartWidget extends StatelessWidget {
  final Map<String, int> dailyTotal;

  PieChartWidget({required this.dailyTotal});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: _generatePieChartData(),
        centerSpaceRadius: 40,
        sectionsSpace: 2,
      ),
    );
  }

  List<PieChartSectionData> _generatePieChartData() {
    List<Color> colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ];

    List<String> days = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    List<PieChartSectionData> pieChartData = [];

    for (int i = 0; i < days.length; i++) {
      if (dailyTotal.containsKey(days[i])) {
        pieChartData.add(
          PieChartSectionData(
            color: colors[i],
            value: dailyTotal[days[i]]!.toDouble(),
            title: '${dailyTotal[days[i]]}',
            radius: 50,
            titleStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      }
    }

    return pieChartData;
  }
}
