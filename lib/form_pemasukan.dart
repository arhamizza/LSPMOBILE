// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_tanggals

import 'package:flutter/material.dart';
import 'package:test1/Screens/home_screen.dart';
import 'package:test1/list_detail.dart';
import 'database/db_helper.dart';
import 'Users/transaksi_model.dart';
import 'package:intl/intl.dart';

class form_pemasukan extends StatefulWidget {
  final Transaksi? transaksi;

  form_pemasukan({this.transaksi});

  @override
  _form_pemasukanState createState() => _form_pemasukanState();
}

class _form_pemasukanState extends State<form_pemasukan> {
  DbHelper db = DbHelper();

  DateTime selectedDate = DateTime.now();

  TextEditingController? tanggal;
  TextEditingController? lastName;
  TextEditingController? nominal;
  TextEditingController? ket;
  final panah = TextEditingController(text: "1");

  @override
  void initState() {
    tanggal = TextEditingController(
        text: widget.transaksi == null ? '' : widget.transaksi!.tanggal);

    nominal = TextEditingController(
        text: widget.transaksi == null ? '' : widget.transaksi!.nominal);

    ket = TextEditingController(
        text: widget.transaksi == null ? '' : widget.transaksi!.ket);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Transaksi'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextFormField(
            controller: tanggal, //editing controller of this TextField
            decoration: InputDecoration(
                icon: Icon(Icons.calendar_today), //icon of text field
                labelText: "Enter Date" //label text of field
                ),
            readOnly:
                true, //set it true, so that user will not able to edit text
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(
                      2000), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101));

              if (pickedDate != null) {
                print(
                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                print(
                    formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                setState(() {
                  tanggal?.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: nominal,
              decoration: InputDecoration(
                  labelText: 'Nominal',
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: ket,
              decoration: InputDecoration(
                  labelText: 'keterangan',
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              child: (widget.transaksi == null)
                  ? Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                upsertTransaksi();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              child: (widget.transaksi == null)
                  ? Text(
                      'BACK',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
          ),
          InkWell(
            onTap: () {
              tanggal?.clear();
              nominal?.clear();
              ket?.clear();
            },
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  "Reset",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> upsertTransaksi() async {
    await db.saveTransaksi(Transaksi(
      tanggal: tanggal!.text,
      nominal: nominal!.text,
      ket: ket!.text,
      panah: panah.text,
    ));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
