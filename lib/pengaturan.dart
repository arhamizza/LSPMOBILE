import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test1/database/database_helper.dart';
import 'package:test1/Screens/home_screen.dart';
import 'package:test1/form_screen.dart';

import 'Users/usr_model.dart';

class Pengaturan extends StatefulWidget {
  @override
  State<Pengaturan> createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  final _formfield = GlobalKey<FormState>();
  final usrName = TextEditingController();
  final usrPass = TextEditingController();
  final usrPassword = TextEditingController();
  final db = DatabaseHelper();
  final int selectedId = 1;

  GantiPass() async {
    var result = await db.authenticationPass(
        Users(usrName: usrName.text, usrPassword: usrPass.text));
    if (result) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FormScreen()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Password salah")));
    }
  }

  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengaturan"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Form(
            key: _formfield,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ganti Password",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
                SizedBox(height: 25),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: usrPass,
                  decoration: InputDecoration(
                    labelText: "Password Saat ini",
                    border: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: usrPassword,
                  // obscureText: passToggle,
                  decoration: InputDecoration(
                    labelText: "Password Baru",
                    border: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                InkWell(
                  onTap: () {
                    if (_formfield.currentState!.validate()) {
                      print("Data Added Successfully");
                      GantiPass();
                      db.updateUser(Users(
                          usrId: selectedId,
                          usrName: usrName.text,
                          usrPassword: usrPassword.text));
                      // usrName.clear();
                      // usrPass.clear();
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "Simpan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                      child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 250),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'assets/fotoku.jpg',
                              height: 170,
                              width: 170,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text("About this App",
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                            Text("Aplikasi ini dibuat oleh arham",
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                            Text("Nama: Arham izza Syany",
                                style: TextStyle(
                                  fontSize: 10,
                                )),
                            Text("NIM: 1941720127",
                                style: TextStyle(
                                  fontSize: 13,
                                )),
                          ],
                        ),
                      ],
                    ),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
