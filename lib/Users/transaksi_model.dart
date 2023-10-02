// ignore_for_file: file_names, unnecessary_this, prefer_collection_literals

class Transaksi{

   int? id;
   String? tanggal;
   String? nominal;
   String? ket;
   String? panah;
    
    Transaksi({this.id, this.tanggal, this.nominal, this.ket,this.panah});
    
    Map<String, dynamic> toMap() {
        var map = Map<String, dynamic>();
    
        if (id != null) {
          map['id'] = id;
        }
        map['tanggal'] = tanggal;
        map['nominal'] = nominal;
        map['ket'] = ket;
        map['panah'] = panah;
        
        return map;
    }
    
    Transaksi.fromMap(Map<String, dynamic> map) {
        this.id = map['id'];
        this.tanggal = map['tanggal'];
        this.nominal = map['nominal'];
        this.ket = map['ket'];
        this.panah = map['panah'];
    }
}