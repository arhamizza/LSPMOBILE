import 'package:flutter/material.dart';
import 'package:test1/database/database_helper.dart';
import 'package:test1/Screens/home_screen.dart';
import 'package:test1/Users/transaksi_model.dart';
import 'package:intl/intl.dart';

class PemasukanScreen extends StatefulWidget {
  @override
  State<PemasukanScreen> createState() => _PemasukanScreenState();
}

class _PemasukanScreenState extends State<PemasukanScreen> {
  final usrTanggal = TextEditingController();
  
  final usrNominal = TextEditingController();
  final usrKet = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  List<Transaksi> listKontak = [];
  DatabaseHelper db = DatabaseHelper();

    Future<DateTime?> showDate(String dateTime) async {
    DateTime _dateTime;
    if (dateTime.isNotEmpty) {
      _dateTime = DateFormat('MM/dd/yyyy').parse(dateTime);
    } else {
      _dateTime = DateTime.now();
    }
    return await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
  }

  createUsers() {
    final db = DatabaseHelper();
    var result = db
        .createTransaksi(Transaksi(
            tanggal: usrTanggal.text,
            nominal: usrNominal.text,
            ket: usrKet.text))
        .whenComplete(() => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            )));

    if (result != -1) {
      print("Data Telah Berhasil Ditambahkan");

    } else {
      print("Tambah gagal");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                controller: usrTanggal, //editing controller of this TextField
                decoration: InputDecoration( 
                   icon: Icon(Icons.calendar_today), //icon of text field
                   labelText: "Enter Date" //label text of field
                ),
                readOnly: true,  //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                         usrTanggal.text = formattedDate; //set output date to TextField value. 
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
             ),
                SizedBox(height: 25),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: usrNominal,
                  decoration: InputDecoration(
                    labelText: "Nominal",
                    border: UnderlineInputBorder(),
                    prefixIcon: Icon(Icons.money),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: usrKet,
                  decoration: InputDecoration(
                    labelText: "Keterangan",
                    border: UnderlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                    onTap: () {
                      print("Data Added Successfully");
                      createUsers();
                      // usrName.clear();
                      // usrPass.clear();
                    
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
