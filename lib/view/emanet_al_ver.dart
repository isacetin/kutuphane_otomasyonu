import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/services.dart';
import 'package:library_automation/model/book.dart';
import 'package:library_automation/model/user.dart';
import 'package:library_automation/view_model/data_services.dart';
import 'package:lottie/lottie.dart';
import 'package:library_automation/widgets/custom_listtile_widget.dart';

class EmanetAlVer extends StatefulWidget {
  const EmanetAlVer({Key? key}) : super(key: key);

  @override
  _EmanetAlVerState createState() => _EmanetAlVerState();
}

class _EmanetAlVerState extends State<EmanetAlVer> {
  late List<DropdownMenuItem<String>> menuItemList = [if (menuItemList.isEmpty) const DropdownMenuItem(child: Text("Seçiniz"), value: "Seçiniz")];
  late List<DropdownMenuItem<String>> menuBookList = [];
  String _secilenKategori = "Seçiniz";
  String _secilenKitap = "Seçiniz";
  String tc = "";
  bool isSearched = false, bulundumu = true;
  final _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  User? searchedUser;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _secilenKategori = "Seçiniz";
    _secilenKitap = "Seçiniz";
    super.dispose();
  }

  @override
  void initState() {
    searchBook();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            Card(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                color: const Color(0xFFF2F3F7),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  maxLength: 11,
                  focusNode: _focusNode,
                  controller: _controller,
                  onFieldSubmitted: (String value) {
                    setState(() {
                      tc = _controller.text;
                    });
                    searcUser(tc);
                  },
                  decoration: InputDecoration(
                    errorText: bulundumu ? null : 'Kullanıcı Bulunamadı',
                    prefixIcon: const Icon(EvaIcons.personOutline),
                    prefixText: "TC ",
                    suffixIcon: IconButton(
                      icon: const Icon(EvaIcons.searchOutline),
                      onPressed: () {
                        setState(() {
                          tc = _controller.text;
                        });
                        searcUser(tc);
                      },
                    ),
                  ),
                ),
              ),
            ),
            searchedUser != null || isSearched
                ? Column(
                    children: [
                      MyCustomListTile(icon: EvaIcons.archive, text1: "TC", text2: searchedUser!.tcno),
                      MyCustomListTile(icon: EvaIcons.text, text1: "Ad Soyad", text2: searchedUser!.adsoyad),
                      MyCustomListTile(icon: EvaIcons.emailOutline, text1: "E-posta", text2: searchedUser!.eposta),
                      MyCustomListTile(icon: EvaIcons.phoneCallOutline, text1: "Telefon", text2: searchedUser!.telefon),
                      MyCustomListTile(icon: EvaIcons.mapOutline, text1: "Adres", text2: searchedUser!.adres),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          color: const Color(0xFFF2F3F7),
                          child: ListTile(
                            leading: const Icon(EvaIcons.bookOpenOutline),
                            title: Row(
                              children: [
                                const Text("Aldığı Kitaplar    : ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                DropdownButton(
                                  hint: Text(_secilenKategori),
                                  onChanged: (secilen) {
                                    setState(() {
                                      _secilenKategori = secilen.toString();
                                    });
                                  },
                                  items: menuItemList,
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                OutlinedButton(
                                    onPressed: () {
                                      _secilenKategori != "Seçiniz"
                                          ? showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text('Bu kitabı geri almak istediğinizden emin misiniz?'),
                                                  // ignore: sized_box_for_whitespace
                                                  content: Container(
                                                    width: MediaQuery.of(context).size.width / 2,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text("Emanet Alınacak Kitap : [ $_secilenKategori ]"),
                                                        const SizedBox(height: 7),
                                                        Text("Emanet Alınacak Tarih : [ ${DateTime.now().toString().substring(0, 16)} ]"),
                                                        Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [const Text("Not : "), Container(width: 250, child: TextFormField())],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text('Hayır'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: const Text('Evet'),
                                                      onPressed: () {
                                                        emanetAl(tc, _secilenKategori);
                                                        setState(() {
                                                          _secilenKategori = "Seçiniz";
                                                          searcUser(tc);
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            )
                                          : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content: Text(
                                                'Lütfen Bir Kitap Seçiniz!',
                                                style: TextStyle(color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                              backgroundColor: Colors.deepOrange));
                                    },
                                    child: const Text(
                                      "Emanet Al",
                                      style: TextStyle(fontSize: 20),
                                    )),
                                SizedBox(width: 15),
                                OutlinedButton(
                                    onPressed: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                            return AlertDialog(
                                              title: const Text('Bu kitabı emanet vermek istediğinizden emin misiniz?'),
                                              // ignore: sized_box_for_whitespace
                                              content: Container(
                                                width: MediaQuery.of(context).size.width / 2,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text("Emanet Verilecek Kitap : "),
                                                        DropdownButton(
                                                          hint: Text(_secilenKitap),
                                                          onChanged: (secilen) {
                                                            setState(() {
                                                              _secilenKitap = secilen.toString();
                                                            });
                                                          },
                                                          items: menuBookList,
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 7),
                                                    Text("Emanet Verilecek Tarih : [ ${DateTime.now().toString().substring(0, 16)} ]"),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      // ignore: sized_box_for_whitespace
                                                      children: [const Text("Not : "), Container(width: 250, child: TextFormField())],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: const Text('Hayır'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text('Evet'),
                                                  onPressed: () {
                                                    emanetVer(tc, _secilenKitap);
                                                    setState(() {
                                                      _secilenKategori = "Seçiniz";
                                                      searcUser(tc);
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                        },
                                      );
                                    },
                                    child: const Text("Emanet Ver", style: TextStyle(fontSize: 20)))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            isSearched || !bulundumu
                ? const SizedBox()
                : Lottie.asset(
                    'assets/search.json',
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.7,
                  ),
          ],
        ),
      ),
      onTap: () {
        _focusNode.unfocus();
      },
    );
  }

  searcUser(String tc) async {
    User? user = await DataServices().searchUser(tc);
    if (user == null) {
      setState(() {
        isSearched = false;
        bulundumu = false;
        _controller.clear();
        _focusNode.unfocus();
      });
    } else {
      setState(() {
        menuItemList = user.aldigikitaplar.map((val) => DropdownMenuItem<String>(value: val, child: Text(val))).toList();
        searchedUser = user;
        bulundumu = true;
        isSearched = true;
        _controller.clear();
        _focusNode.unfocus();
      });
    }
  }

  searchBook() async {
    List<Book>? book = await DataServices().getBook();
    setState(() {
      menuBookList = book!.map((val) => DropdownMenuItem<String>(value: val.kitapadi, child: Text(val.kitapadi))).toList();
    });
  }

  emanetAl(String tc, String kitapadi) async {
    bool updateded = await DataServices().emanetAl(tc, kitapadi);
    if (updateded) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Kitabınız Geri Alındı.',
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

  emanetVer(String tc, String kitapadi) async {
    bool updateded = await DataServices().emanetVer(tc, kitapadi);
    if (updateded) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Kitap Emanet Olarak Verildi.',
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
