import 'package:flutter/material.dart';
import 'package:library_automation/model/user.dart';
import 'package:library_automation/view_model/data_services.dart';
import 'package:library_automation/widgets/custom_button_widget.dart';

// ignore: must_be_immutable
class OkuyucuGuncelle extends StatefulWidget {
  User data;

  OkuyucuGuncelle({Key? key, required this.data}) : super(key: key);

  @override
  _OkuyucuGuncelleState createState() => _OkuyucuGuncelleState();
}

class _OkuyucuGuncelleState extends State<OkuyucuGuncelle> {
  @override
  Widget build(BuildContext context) {
    late String _tcno, _adsoyad, _telefon, _eposta, _adres;
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(70.0),
        child: Column(
          children: [
            Card(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                color: const Color(0xFFF2F3F7),
                child: TextFormField(
                  initialValue: widget.data.tcno,
                  decoration: const InputDecoration(
                    labelText: "TC Numarası",
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Lütfen Boş Bırakmayınız.";
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      _tcno = value!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),
            Card(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                color: const Color(0xFFF2F3F7),
                child: TextFormField(
                  initialValue: widget.data.adsoyad,
                  decoration: const InputDecoration(
                    labelText: "Adı ve Soyadı",
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Lütfen Boş Bırakmayınız.";
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      _adsoyad = value!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),
            Card(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                color: const Color(0xFFF2F3F7),
                child: TextFormField(
                  initialValue: widget.data.telefon,
                  decoration: const InputDecoration(
                    labelText: "Telefon Numarası",
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Lütfen Boş Bırakmayınız.";
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      _telefon = value!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),
            Card(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                color: const Color(0xFFF2F3F7),
                child: TextFormField(
                  initialValue: widget.data.eposta,
                  decoration: const InputDecoration(
                    labelText: "E-posta",
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Lütfen Boş Bırakmayınız.";
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      _eposta = value!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),
            Card(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                color: const Color(0xFFF2F3F7),
                child: TextFormField(
                  initialValue: widget.data.adres,
                  decoration: const InputDecoration(
                    labelText: "Adresi",
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Lütfen Boş Bırakmayınız.";
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      _adres = value!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyCostumButton(
                    voidCallback: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        User newUser = User(
                            id: widget.data.id,
                            tcno: _tcno,
                            adsoyad: _adsoyad,
                            telefon: _telefon,
                            eposta: _eposta,
                            adres: _adres,
                            aldigikitaplar: [],
                            v: 0);
                        updateUser(newUser);
                        widget.data = newUser;
                      }
                    },
                    color1: Colors.cyan,
                    color2: Colors.greenAccent,
                    text: "Güncelle",
                    iconData: Icons.update_outlined),
                const SizedBox(width: 15),
                MyCostumButton(
                    voidCallback: () {
                      setState(() {
                        deleteUser(widget.data.id);
                        setState(() {});
                      });
                    },
                    color1: Colors.orange,
                    color2: Colors.red,
                    text: "Sil",
                    iconData: Icons.delete_outline),
              ],
            )
          ],
        ),
      ),
    );
  }

  void updateUser(User data) async {
    bool basariliMi = await DataServices().updateUser(data);
    if (basariliMi) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Kullanıcı Güncellendi',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Bir Sorun Oluştu Tekrar Deneyiniz!',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red));
    }
  }

  void deleteUser(String id) async {
    bool basariliMi = await DataServices().deleteUser(id);
    if (basariliMi) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Okuyucu Başarıyla Silindi',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Bir Sorun Oluştu Tekrar Deneyiniz!',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red));
    }
  }
}
