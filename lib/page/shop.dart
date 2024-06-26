import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:Medaran/page/home.dart';
import 'package:Medaran/page/profile.dart';
import 'package:Medaran/widget/bottomNav.dart';
import 'package:Medaran/widget/buton.dart';
import 'package:http/http.dart' as http;
import 'package:Medaran/widget/popDialog.dart';
import '../controller/controller.dart';
import '../theme/theme.dart';
import '../widget/list.dart';
import '../widget/listFavorit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String clientKey = dotenv.env['MIDTRANS_CLIENT_KEY'] ?? "";
  String baseUrl = dotenv.env['BASE_URL'] ?? "";
  late final MidtransSDK? _midtrans;

  var currentIndex = 2;
  final UserController userController = Get.find<UserController>();
  List<Map<String, dynamic>> selectedItems = [];
  List<Map<String, dynamic>> cardPesanan = [];
  final TextEditingController nameController = TextEditingController();
  double totalHarga = 0;
  int totalProduk = 0;
  String? orderId;
  String? status;
  String formatHarga(int harga) {
    final hargaFormat = NumberFormat("#,##0", "id_ID");
    return hargaFormat.format(harga);
  }

  @override
  void initState() {
    super.initState();
    fetchPesananData();
    _initSDK();
  }

  void _initSDK() async {
    try {
      _midtrans = await MidtransSDK.init(
        config: MidtransConfig(
          clientKey: clientKey,
          merchantBaseUrl: "https://nest-js-nine.vercel.app/midtrans/payment/",
          colorTheme: ColorTheme(
            colorPrimary: primary3,
            colorPrimaryDark: primary,
            colorSecondary: primary4,
          ),
        ),
      );
      _midtrans?.setUIKitCustomSetting(
        skipCustomerDetailsPages: true,
      );
      _midtrans!.setTransactionFinishedCallback((result) {
        setState(() {
          orderId = result.orderId;
          status = result.statusMessage;
        });
        _printSelectedData();
        _showToast('Berhasil di Bayar', false);
        setState(() {
          selectedItems.clear();
          totalHarga = 0;
          totalProduk = 0;
        });
      });
      print('SDK Initialized Successfully');
    } catch (e) {
      print('Error initializing Midtrans SDK: $e');
      _showToast('Gagal melakukan pembayaran', true);
    }
  }

  void _showToast(String msg, bool isError) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: white,
      fontSize: 16.0,
    );
  }

  @override
  void dispose() {
    _midtrans?.removeTransactionFinishedCallback();
    super.dispose();
  }

  Future<void> fetchPesananData() async {
    try {
      final userId = userController.userData['id'];
      final response = await http.get(
        Uri.parse('https://nest-js-nine.vercel.app/pesanan/user/$userId'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          cardPesanan = data.cast<Map<String, dynamic>>();
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> deletePesanan(int pesananId) async {
    final url = Uri.parse('https://nest-js-nine.vercel.app/pesanan/$pesananId');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        fetchPesananData();

        Get.snackbar(
          'Hapus',
          'Berhasil Hapus Pesanan',
          backgroundColor: Colors.white.withOpacity(0.5),
          colorText: primary,
        );
      } else {
        print('Gagal menghapus pesanan. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting pesanan: $error');
    }
  }

  Future<void> updatePesanan(int pesananId, int newQtt) async {
    final url = Uri.parse('https://nest-js-nine.vercel.app/pesanan/$pesananId');
    try {
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'qtt': newQtt}),
      );
      if (response.statusCode == 200) {
        fetchPesananData();
        Get.snackbar(
          'Update',
          'Berhasil Update Pesanan',
          backgroundColor: Colors.white.withOpacity(0.5),
          colorText: primary,
        );
      } else {
        print('Gagal memperbarui pesanan. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating pesanan: $error');
    }
  }

  Future<void> createPayment() async {
    final List<Map<String, dynamic>> payments = selectedItems.map((pesanan) {
      return {
        'id': pesanan['id'],
        'produkId': pesanan['produkId'],
        'ProdukName': pesanan['ProdukName'],
        'qtt': pesanan['qtt'],
        'harga': pesanan['harga'],
      };
    }).toList();

    final Map<String, dynamic> paymentData = {
      'namaPemesan': nameController.text,
      'pesanan': payments,
      'totalHarga': totalHarga.toInt(),
      'status': '${status}',
    };
    try {
      final response = await http.post(
        Uri.parse('https://nest-js-nine.vercel.app/midtrans/payment/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(paymentData),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        print('Pembayaran berhasil, token: $token');

        _midtrans?.startPaymentUiFlow(token: token);

        // Hapus pesanan setelah pembayaran berhasil
        for (var pesanan in selectedItems) {
          await deletePesanan(pesanan['id']);
          await updateStokProduk(pesanan['produkId'], pesanan['qtt']);
        }
      } else {
        print(
            'Gagal melakukan pembayaran. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error making payment: $error');
    }
  }

  void _showUpdateDialog(Map<String, dynamic> pesanan) {
    showDialog<int>(
      context: context,
      builder: (context) {
        return UpdateOrderDialog(
          pesananId: pesanan['id'],
          nama: pesanan['ProdukName'],
          harga: pesanan['harga'],
          desk: pesanan['desk'],
          currentQtt: pesanan['qtt'],
          kategori: pesanan['kategori'],
        );
      },
    ).then((newQtt) {
      if (newQtt != null) {
        updatePesanan(pesanan['id'], newQtt);
      }
    });
  }

  void _onCardSelected(Map<String, dynamic> pesanan, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedItems.add(pesanan);
        totalHarga += pesanan['harga'] * pesanan['qtt'];
      } else {
        selectedItems.remove(pesanan);
        totalHarga -= pesanan['harga'] * pesanan['qtt'];
      }
    });
  }

  //dialog delete data
  void _delDialog(BuildContext context, int pesananId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialoguu(
            alert: 'Delete',
            pesan: 'Yakin Ingin Hapus',
            btn: 'Delete',
            onPressed: () {
              deletePesanan(pesananId);
              Navigator.pop(context);
            });
      },
    );
  }

  Future<void> _printSelectedData() async {
    final String namaPemesan = nameController.text;

    // hitung jumlah produk dan total harga dari selectedItems
    final int jumlahProduk =
        selectedItems.fold<int>(0, (sum, item) => sum + item['qtt'] as int);
    final int totalHargaInt = selectedItems.fold<int>(
        0, (sum, item) => sum + item['harga'] * item['qtt'] as int);

    print('Nama Pemesan: $namaPemesan');
    print('Jumlah Produk: $jumlahProduk');
    print('Total Harga: $totalHargaInt');
    if (orderId != null || status != null) {
      print('order id: $orderId');
      print('status: $status');
    }
    final Map<String, dynamic> transactionData = {
      'orderId': orderId,
      'namaPemesan': namaPemesan,
      'jumlahProduk': jumlahProduk,
      'totalHarga': totalHargaInt,
      'status': status,
    };
    final url = Uri.parse('https://nest-js-nine.vercel.app/transaksi');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(transactionData),
      );

      if (response.statusCode == 201) {
        print('Data transaksi berhasil disimpan di backend');
        // Tambahkan logika tambahan jika diperlukan setelah menyimpan transaksi
      } else {
        print(
            'Gagal menyimpan data transaksi di backend. Status code: ${response.statusCode}');
        // Handle error jika perlu
      }
    } catch (error) {
      print('Error saat mengirim data transaksi: $error');
      // Handle error koneksi atau kesalahan lainnya
    }
  }

  Future<void> updateStokProduk(int produkId, int quantity) async {
    final url = Uri.parse(
        'https://nest-js-nine.vercel.app/product/update-stock/$produkId');
    try {
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'stok': quantity}),
      );
      if (response.statusCode == 200) {
        print('Stok produk berhasil diperbarui');
      } else {
        print(
            'Gagal memperbarui stok produk. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating product stock: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cController = Get.put(MyController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(top: 60, left: 30, right: 30),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg.png'), fit: BoxFit.cover)),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.to(Profile()),
                child: Row(
                  children: [
                    Container(
                        child: Icon(
                      Icons.account_circle_outlined,
                      size: 56,
                    )),
                    Gap(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${userController.userData['username']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: semiBold,
                            color: primary,
                          ),
                        ),
                        Text(
                          '${userController.userData['role']}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: regular,
                            color: secondarytext,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(30),
                      ListMenu(text: 'List Pesan'),
                      Gap(10),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 400,
                              color: Colors.transparent,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: cardPesanan.length,
                                itemBuilder: (context, index) {
                                  final pesanan = cardPesanan[index];
                                  if (pesanan != true) {
                                    final id = pesanan['id'];
                                    final produkName = pesanan['ProdukName'];
                                    final harga = pesanan['harga'];
                                    final qtt = pesanan['qtt'];
                                    final desk = pesanan['desk'];
                                    final kategori = pesanan['kategori'];
                                    final createdAt = pesanan['createdAt'];
                                    final produkNames = produkName ??
                                        'Nama Produk Tidak Tersedia';

                                    final totalPesanan = qtt ?? 0;
                                    final hargaa = harga ?? 0;

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        PesananCard(
                                          id: id,
                                          produkName: produkNames,
                                          harga: hargaa,
                                          qtt: totalPesanan,
                                          desk: desk,
                                          kategori: kategori,
                                          createdAt: createdAt,
                                          onPressed: () => _delDialog(
                                              context, pesanan['id']),
                                          onpressedEdit: () =>
                                              _showUpdateDialog(pesanan),
                                          onSelect: (isSelected) =>
                                              _onCardSelected(
                                                  pesanan, isSelected),
                                        ),
                                        Gap(20),
                                      ],
                                    );
                                  } else {
                                    return Text('Data pesanan tidak lengkap');
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          fillColor: primary,
                          labelText: 'Nama Pemesan',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                  Gap(10),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child: buton(
                          onPressed: () {
                            if (selectedItems.isEmpty) {
                              Fluttertoast.showToast(
                                msg: 'Pilih setidaknya satu pesanan',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              return;
                            }
                            if (nameController.text.isEmpty) {
                              Fluttertoast.showToast(
                                msg: 'Masukkan nama pemesan',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              return;
                            }
                            createPayment();
                          },
                          text:
                              'Bayar (Total: ${formatHarga(totalHarga.toInt())})')),
                ],
              ))
        ]),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: cController.index,
          onItemTapped: (index) {
            cController.index.value = index;
          }),
    );
  }
}
