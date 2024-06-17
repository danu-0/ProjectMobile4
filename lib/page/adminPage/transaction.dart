import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransactionStatusPage extends StatefulWidget {
  @override
  _TransactionStatusPageState createState() => _TransactionStatusPageState();
}

class _TransactionStatusPageState extends State<TransactionStatusPage> {
  Future<List<Map<String, dynamic>>> fetchTransactions() async {
    final response = await http.get(
      Uri.parse('https://nest-js-nine.vercel.app/transaksi'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Map<String, dynamic>> transactions =
          data.cast<Map<String, dynamic>>();
      return transactions;
    } else {
      print(response.body);
      throw Exception('Failed to load transaction status');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Status'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No transactions found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final transaction = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text('Order ID: ${transaction['orderId']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Status: ${transaction['status']}'),
                        Text('Total Harga: ${transaction['totalHarga']}'),
                        Text('Jumlah Produk: ${transaction['jumlahProduk']}'),
                        Text(
                            'Waktu Transaksi: ${DateTime.parse(transaction['createdAt']).toLocal()}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
