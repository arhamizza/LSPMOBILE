// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, unused_element, unused_local_variable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:test1/form_screen.dart';
import 'form_pemasukan.dart';

import 'database/db_helper.dart';
import 'Users/transaksi_model.dart';

class ListTransaksiPage extends StatefulWidget {
  const ListTransaksiPage({Key? key}) : super(key: key);

  @override
  _ListTransaksiPageState createState() => _ListTransaksiPageState();
}

class _ListTransaksiPageState extends State<ListTransaksiPage> {
  List<Transaksi> listTransaksi = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    //menjalankan fungsi getallkontak saat pertama kali dimuat
    _getAllTransaksi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Transaksi App"),
        ),
      ),
      body: ListView.builder(
          itemCount: listTransaksi.length,
          itemBuilder: (context, index) {
            Transaksi transaksi = listTransaksi[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  size: 50,
                ),
                title: Text('Tanggal: ${transaksi.tanggal}'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Nominal: ${transaksi.nominal}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Keterangan: ${transaksi.ket}"),
                    ),
                  ],
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      // button hapus
                      if (transaksi.panah == "1") ...{
                        Image.asset(
                          'assets/masuk.JPG',
                          height: 100,
                          width: 100,
                        )
                      } else ...[
                        Image.asset(
                          'assets/keluar.JPG',
                          height: 100,
                          width: 100,
                        )
                      ],
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          //membuat dialog konfirmasi hapus
                          AlertDialog hapus = AlertDialog(
                            title: Text("Information"),
                            content: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                      "Yakin ingin Menghapus Data ${transaksi.tanggal}")
                                ],
                              ),
                            ),
                            //terdapat 2 button.
                            //jika ya maka jalankan _deleteTransaksi() dan tutup dialog
                            //jika tidak maka tutup dialog
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    _deleteTransaksi(transaksi, index);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ya")),
                              TextButton(
                                child: Text('Tidak'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(
                              context: context, builder: (context) => hapus);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      //membuat button mengapung di bagian bawah kanan layar

    );
  }

  //mengambil semua data Transaksi
  Future<void> _getAllTransaksi() async {
    //list menampung data dari database
    var list = await db.getAllTransaksi();

    //ada perubahanan state
    setState(() {
      //hapus data pada listTransaksi
      listTransaksi.clear();

      //lakukan perulangan pada variabel list
      list!.forEach((transaksi) {
        //masukan data ke listTransaksi
        listTransaksi.add(Transaksi.fromMap(transaksi));
      });
    });
  }

  //menghapus data Transaksi
  Future<void> _deleteTransaksi(Transaksi transaksi, int position) async {
    await db.deleteTransaksi(transaksi.id!);
    setState(() {
      listTransaksi.removeAt(position);
    });
  }

  // membuka halaman tambah Transaksi
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormScreen()));
    if (result == 'save') {
      await _getAllTransaksi();
    }
  }

  //membuka halaman edit Transaksi
}
