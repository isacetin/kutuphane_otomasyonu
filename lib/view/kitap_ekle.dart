import 'package:flutter/material.dart';
import 'package:library_automation/view_model/data_services.dart';
import 'package:library_automation/widgets/custom_button_widget.dart';

class KitapEkle extends StatefulWidget {
  const KitapEkle({Key? key}) : super(key: key);

  @override
  _KitapEkleState createState() => _KitapEkleState();
}

class _KitapEkleState extends State<KitapEkle> {
  @override
  Widget build(BuildContext context) {
    late String _kitapadi, _kitapyazar, _kitapturu, _sayfasayisi, _ciltno, _yayinevi;
    var _formKey = GlobalKey<FormState>();
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
                      labelText: "Kitap Adı",
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Lütfen Boş Bırakmayınız.";
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        _kitapadi = value!;
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
                      labelText: "Yazarı",
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Lütfen Boş Bırakmayınız.";
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        _kitapyazar = value!;
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
                      labelText: "Türü",
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Lütfen Boş Bırakmayınız.";
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        _kitapturu = value!;
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
                      labelText: "Sayfa Sayısı",
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Lütfen Boş Bırakmayınız.";
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        _sayfasayisi = value!;
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
                      labelText: "Cilt No",
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Lütfen Boş Bırakmayınız.";
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        _ciltno = value!;
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
                      labelText: "Yayınevi",
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Lütfen Boş Bırakmayınız.";
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        _yayinevi = value!;
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
                    iconData: Icons.clear_outlined,
                    text: "Temizle",
                  ),
                  MyCostumButton(
                    voidCallback: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setBook(_formKey, _kitapadi, _kitapyazar, _kitapturu, _sayfasayisi, _ciltno, _yayinevi);
                        _formKey.currentState!.reset();
                      }
                    },
                    color1: Colors.cyan,
                    color2: Colors.greenAccent,
                    text: "Kaydet",
                    iconData: Icons.save_outlined,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  setBook(_formKey, _kitapadi, _kitapyazar, _kitapturu, _sayfasayisi, _ciltno, _yayinevi) async {
    bool basarilimi = false;

    basarilimi = await DataServices().setBook(_kitapadi, _kitapyazar, _kitapturu, _sayfasayisi, _ciltno, _yayinevi);
    if (basarilimi) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Kitabınız Kayıt Edildi.',
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
