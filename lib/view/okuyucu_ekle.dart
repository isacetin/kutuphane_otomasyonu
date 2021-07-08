import 'package:flutter/material.dart';
import 'package:library_automation/view_model/data_services.dart';
import 'package:library_automation/widgets/custom_button_widget.dart';

class OkuyucuEkle extends StatefulWidget {
  const OkuyucuEkle({Key? key}) : super(key: key);

  @override
  _OkuyucuEkleState createState() => _OkuyucuEkleState();
}

class _OkuyucuEkleState extends State<OkuyucuEkle> {
  late String _tcno, _adsoyad, _telefon, _eposta, _adres;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyCostumButton(
                      voidCallback: () {
                        setState(() {
                          _formKey.currentState!.reset();
                        });
                      },
                      color1: Colors.orange,
                      color2: Colors.red,
                      text: "Temizle",
                      iconData: Icons.save_outlined),
                  MyCostumButton(
                      voidCallback: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          setBook(_formKey, _tcno, _adsoyad, _telefon, _eposta, _adres);
                          _formKey.currentState!.reset();
                        }
                      },
                      color1: Colors.cyan,
                      color2: Colors.greenAccent,
                      text: "Kaydet",
                      iconData: Icons.save_outlined),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  setBook(_formKey, _tcno, _adsoyad, _telefon, _eposta, _adres) async {
    bool basarilimi = false;

    basarilimi = await DataServices().setUser(_tcno, _adsoyad, _telefon, _eposta, _adres);
    if (basarilimi) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Kullanıcı Kayıt Edildi.', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
          backgroundColor: Colors.green));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Bir Sorun Oluştu Tekrar Deneyiniz!',
              style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
          backgroundColor: Colors.red));
    }
  }
}
