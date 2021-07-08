import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:library_automation/model/book.dart';
import 'package:library_automation/view/kitap_guncelle.dart';
import 'package:library_automation/view_model/data_services.dart';

class KitaplariListele extends StatefulWidget {
  const KitaplariListele({Key? key}) : super(key: key);

  @override
  _KitaplariListeleState createState() => _KitaplariListeleState();
}

class _KitaplariListeleState extends State<KitaplariListele> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DataServices().getBook(),
      builder: (BuildContext context, AsyncSnapshot<List<Book>?> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return DataTable(
            headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade300),
            headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            columns: const [
              DataColumn(label: Text("Kitap Adı"), tooltip: "Kitap adı"),
              DataColumn(label: Text("Yazar"), tooltip: "Kitap Yazarı"),
              DataColumn(label: Text("Türü"), tooltip: "Kitap Türü"),
              DataColumn(label: Text("Sayfa Sayısı"), tooltip: "Sayfa Sayısı"),
              DataColumn(label: Text("Cilt No"), tooltip: "Cilt No"),
              DataColumn(label: Text("Yayınevi"), tooltip: "Yayınevi"),
            ],
            rows: snapshot.data!
                .map(
                  (data) => DataRow(
                    cells: [
                      DataCell(
                        Text(data.kitapadi),
                        showEditIcon: true,
                        onTap: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Kitap Güncelle'),
                                // ignore: sized_box_for_whitespace
                                content: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: KitapGuncelle(data: data),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('İptal'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {});
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Tamam'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {});
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      DataCell(Text(data.kitapyazar)),
                      DataCell(Text(data.kitapturu)),
                      DataCell(Text(data.sayfasayisi)),
                      DataCell(Text(data.ciltno)),
                      DataCell(Text(data.kitapyayinevi)),
                    ],
                  ),
                )
                .toList(),
          );
        }
      },
    );
  }
}
