import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:tester/theme/theme.dart';
import '../../widget/chart.dart';

class TransactionStatisticsPage extends StatefulWidget {
  @override
  _TransactionStatisticsPageState createState() =>
      _TransactionStatisticsPageState();
}

class _TransactionStatisticsPageState extends State<TransactionStatisticsPage> {
  late List<Transaction> transactions = [];
  List<BarChartGroupData> barChartData = [];
  Map<String, int> dailyTotal = {};

  @override
  void initState() {
    super.initState();
    fetchTransactions().then((data) {
      setState(() {
        transactions = data;
        _generateBarChartData();
      });
    });
  }

  Future<List<Transaction>> fetchTransactions() async {
    final response = await http.get(
      Uri.parse('https://nest-js-nine.vercel.app/transaksi'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Transaction> transactions =
          data.map((json) => Transaction.fromJson(json)).toList();
      return transactions;
    } else {
      print(response.body);
      throw Exception('Failed to load transactions');
    }
  }

  void _generateBarChartData() {
    dailyTotal.clear();

    for (var transaction in transactions) {
      DateTime createdAt = DateTime.parse(transaction.createdAt);
      String dayOfWeek = _getDayOfWeek(createdAt.weekday);
      if (dailyTotal.containsKey(dayOfWeek)) {
        dailyTotal[dayOfWeek] =
            dailyTotal[dayOfWeek]! + transaction.jumlahProduk;
      } else {
        dailyTotal[dayOfWeek] = transaction.jumlahProduk;
      }
    }

    barChartData = dailyTotal.entries
        .map((entry) => BarChartGroupData(
              x: _getDayIndex(entry.key),
              barRods: [
                BarChartRodData(
                  toY: entry.value.toDouble(),
                  color: Colors.blue,
                  width: 20,
                ),
              ],
            ))
        .toList();
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
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

  int _getDayIndex(String day) {
    switch (day) {
      case 'Senin':
        return 1;
      case 'Selasa':
        return 2;
      case 'Rabu':
        return 3;
      case 'Kamis':
        return 4;
      case 'Jumat':
        return 5;
      case 'Sabtu':
        return 6;
      case 'Minggu':
        return 7;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg.png'), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(30),
                Text(
                  'Distribusi Pembelian per Hari',
                  style: TextStyle(
                      color: primary, fontSize: 24, fontWeight: semiBold),
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: BarChartWidget(
                        barChartData: barChartData, dailyTotal: dailyTotal),
                  ),
                ),
                Gap(5),
                Text(
                  'BarChart',
                  style:
                      TextStyle(color: primary, fontWeight: bold, fontSize: 16),
                ),
                Gap(20),
                Text(
                  'Distribusi Pembelian per Hari',
                  style: TextStyle(
                    color: primary,
                    fontSize: 24,
                    fontWeight: semiBold,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: PieChartWidget(dailyTotal: dailyTotal),
                  ),
                ),
                SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  children: buildLegend(),
                ),
                Gap(5),
                Text(
                  'PieChart',
                  style:
                      TextStyle(color: primary, fontWeight: bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildLegend() {
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

    List<Widget> legendItems = [];

    for (int i = 0; i < days.length; i++) {
      legendItems.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                  color: colors[i], borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(width: 4),
            Text(
              days[i],
              style: TextStyle(color: primary),
            ),
          ],
        ),
      );
    }

    return legendItems;
  }
}

class Transaction {
  final int id;
  final String orderId;
  final String namaPemesan;
  final int jumlahProduk;
  final int totalHarga;
  final String status;
  final String createdAt;
  final String updatedAt;

  Transaction({
    required this.id,
    required this.orderId,
    required this.namaPemesan,
    required this.jumlahProduk,
    required this.totalHarga,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      orderId: json['orderId'],
      namaPemesan: json['namaPemesan'],
      jumlahProduk: json['jumlahProduk'],
      totalHarga: json['totalHarga'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
