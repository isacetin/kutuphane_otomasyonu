import 'package:flutter/material.dart';
import 'package:library_automation/model/user.dart';
import 'package:library_automation/view_model/data_services.dart';

import 'okuyucu_guncelle.dart';

class OkuyuculariListele extends StatefulWidget {
  const OkuyuculariListele({Key? key}) : super(key: key);

  @override
  _OkuyuculariListeleState createState() => _OkuyuculariListeleState();
}

class _OkuyuculariListeleState extends State<OkuyuculariListele> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DataServices().getUsers(),
      builder: (BuildContext context, AsyncSnapshot<List<User>?> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return DataTable(
            headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade300),
            headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            columns: const [
              DataColumn(label: Text("ID"), tooltip: "ID"),
              DataColumn(label: Text("TC Numarası"), tooltip: "TC Numarası"),
              DataColumn(label: Text("Ad Soyad"), tooltip: "Ad Soyad"),
              DataColumn(label: Text("Telefon No"), tooltip: "Telefon No"),
              DataColumn(label: Text("E-posta"), tooltip: "E-posta"),
              DataColumn(label: Text("Adres"), tooltip: "Adres"),
            ],
            rows: snapshot.data!
                .map(
                  (data) => DataRow(
                    cells: [
                      DataCell(
                        Text(data.id),
                        showEditIcon: true,
                        onTap: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Okuyucuyu Güncelle'),
                              // ignore: sized_box_for_whitespace
                              content: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: OkuyucuGuncelle(data: data),
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
                            ),
                          );
                        },
                      ),
                      DataCell(Text(data.tcno)),
                      DataCell(Text(data.adsoyad)),
                      DataCell(Text(data.telefon)),
                      DataCell(Text(data.eposta)),
                      DataCell(Text(data.adres)),
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
