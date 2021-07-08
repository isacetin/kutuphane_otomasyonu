import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_automation/model/book.dart';
import 'package:library_automation/view_model/data_services.dart';
import 'package:library_automation/widgets/custom_button_widget.dart';

// ignore: must_be_immutable
class KitapGuncelle extends StatefulWidget {
  Book data;

  KitapGuncelle({Key? key, required this.data}) : super(key: key);

  @override
  _KitapGuncelleState createState() => _KitapGuncelleState();
}

class _KitapGuncelleState extends State<KitapGuncelle>  {
  @override
  Widget build(BuildContext context) {
    late String _kitapadi, _kitapyazar, _kitapturu, _sayfasayisi, _ciltno, _yayinevi;
    var _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              color: const Color(0xFFF2F3F7),
              child: TextFormField(
                initialValue: widget.data.kitapadi,
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
                initialValue: widget.data.kitapyazar,
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
                initialValue: widget.data.kitapturu,
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
                initialValue: widget.data.sayfasayisi,
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
                initialValue: widget.data.ciltno,
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
                initialValue: widget.data.kitapyayinevi,
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              MyCostumButton(
                  voidCallback: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Book newBook = Book(
                          id: widget.data.id,
                          kitapadi: _kitapadi,
                          kitapyazar: _kitapyazar,
                          sayfasayisi: _sayfasayisi,
                          ciltno: _ciltno,
                          kitapyayinevi: _yayinevi,
                          v: 0,
                          kitapturu: _kitapturu);
                      updateBook(newBook);
                      widget.data = newBook;
                    }
                  },
                  color1: Colors.cyan,
                  color2: Colors.greenAccent,
                  text: "Güncelle",
                  iconData: Icons.update),
              const SizedBox(width: 10),
              MyCostumButton(
                  voidCallback: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Kitap Sil'),
                        content: const Text('Bu kitabı kalıcı olarak silmek istediğinizden emin misiniz?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Hayır'),
                          ),
                          TextButton(
                            onPressed: () {
                              deleteBook(widget.data.id);
                              Navigator.pop(context);
                            },
                            child: const Text('Evet'),
                          ),
                        ],
                      ),
                    );
                    //Navigator.of(context).pop();
                  },
                  color1: Colors.orange,
                  color2: Colors.red,
                  text: "Sil",
                  iconData: Icons.delete_outline)
            ],
          )
        ],
      ),
    );
  }

  void updateBook(Book data) async {
    bool basariliMi = await DataServices().updateBook(data);
    if (basariliMi) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Kitabınız Güncellendi',
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

  void deleteBook(String id) async {
    bool basariliMi = await DataServices().deleteBook(id);
    if (basariliMi) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Kitabınız Başarıyla Silindi',
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
