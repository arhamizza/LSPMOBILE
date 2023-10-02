import 'package:flutter/material.dart';
import 'package:test1/Screens/detail.dart';
import 'package:test1/Screens/pemasukan.dart';
import 'package:test1/form_pemasukan.dart';
import 'package:test1/form_pengeluaran.dart';
import 'package:test1/list_detail.dart';
import 'package:test1/pengaturan.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Rangkuman Bulan Ini",
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Pengeluaran Rp.500,000",
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Pengeluaran Rp.1,500,000",
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  SizedBox(height: 15),
                  Image.asset(
                    'assets/grafik.JPG',
                    height: 300,
                    width: 500,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Image.asset('assets/pemasukan.JPG'),
                        iconSize: 150,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => form_pemasukan()));
                        },
                      ),
                      SizedBox(width: 15),
                      IconButton(
                        icon: Image.asset('assets/pengeluaran.JPG'),
                        iconSize: 150,
                        onPressed: () {
                                                    Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FormPengeluaran()));
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Image.asset('assets/detail.JPG'),
                        iconSize: 150,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListTransaksiPage()));
                        },
                      ),
                      SizedBox(width: 15),
                      IconButton(
                        icon: Image.asset('assets/pengaturan.JPG'),
                        iconSize: 150,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Pengaturan()));
                        },
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
