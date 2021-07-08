import 'package:flutter/material.dart';
import 'package:library_automation/view/emanet_al_ver.dart';
import 'package:library_automation/view/kitap_ekle.dart';
import 'package:library_automation/view/kitaplari_listele.dart';
import 'package:library_automation/view/login.dart';
import 'package:library_automation/view/okuyucu_ekle.dart';
import 'package:library_automation/view/okuyuculari_listele.dart';
import 'package:library_automation/widgets/custom_card_widget.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int secilenIndex = 0;
  late String _mesaj = "Veritabanına yeni bir kitap ekleyebilirsiz.";

  @override
  Widget build(BuildContext context) {
    var _pageController = PageController(initialPage: 0);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Erdemli Uygulamalı Teknoloji ve İşletmecilik Yüksekokulu",
          style: TextStyle(color: Colors.black),
        ),
        //elevation: 0,
        backgroundColor: Colors.grey.shade100,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Tooltip(
              message: "Çıkış",
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage()));
                },
                icon: const Icon(
                  Icons.exit_to_app_rounded,
                  color: Colors.black,
                  size: 40,
                ),
              ),
            ),
          )
        ],
      ),
      body: Row(
        //mainAxisSize: MainAxisSize.min,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                MyCustomCard(
                  color: secilenIndex == 0 ? Colors.blueGrey.shade100 : Color(0xFFF0F2F5),
                  iconColor: Colors.purple,
                  icon: EvaIcons.bookOutline,
                  text: "Kitap Ekle",
                  voidCallback: () {
                    _pageController.jumpToPage(0);
                  },
                ),
                MyCustomCard(
                  color: secilenIndex == 1 ? Colors.blueGrey.shade100 : Color(0xFFF0F2F5),
                  iconColor: Colors.cyan,
                  icon: EvaIcons.listOutline,
                  text: "Kitapları Listele",
                  voidCallback: () {
                    _pageController.jumpToPage(1);
                  },
                ),
                MyCustomCard(
                  color: secilenIndex == 2 ? Colors.blueGrey.shade100 : Color(0xFFF0F2F5),
                  iconColor: Colors.pink,
                  icon: EvaIcons.personAddOutline,
                  text: "Okuyucu Ekle",
                  voidCallback: () {
                    _pageController.jumpToPage(2);
                  },
                ),
                MyCustomCard(
                  color: secilenIndex == 3 ? Colors.blueGrey.shade100 : Color(0xFFF0F2F5),
                  iconColor: Colors.deepOrange,
                  icon: EvaIcons.listOutline,
                  text: "Okuyucuyu Listele",
                  voidCallback: () {
                    _pageController.jumpToPage(3);
                  },
                ),
                MyCustomCard(
                  color: secilenIndex == 4 ? Colors.blueGrey.shade100 : Color(0xFFF0F2F5),
                  iconColor: Colors.blueAccent,
                  icon: EvaIcons.swapOutline,
                  text: "Emanet Al - Ver",
                  voidCallback: () {
                    _pageController.jumpToPage(4);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 13,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                setState(() {
                  secilenIndex = value;
                  switch (secilenIndex) {
                    case 0:
                      _mesaj = "Veritabanına yeni bir kitap ekleyebilirsiz.";
                      break;
                    case 1:
                      _mesaj = "Veritabanınızda bulunun kitaplar listelenir.";
                      break;
                    case 2:
                      _mesaj = "Veritabanına yeni bir okuyucu ekleyebilirsiz.";
                      break;
                    case 3:
                      _mesaj = "Veritabanınızda bulunun okuyucular listelenir.";
                      break;
                    case 4:
                      _mesaj = "Veritabanınızda bulunun okuyuculara emanet olarak kitap verebilir veya verdiğiniz kitabı geri alabilirsiniz.";
                      break;
                  }
                });
              },
              controller: _pageController,
              scrollDirection: Axis.vertical,
              children: const [
                KitapEkle(),
                KitaplariListele(),
                OkuyucuEkle(),
                OkuyuculariListele(),
                EmanetAlVer(),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: Tooltip(
        child: const Icon(Icons.help_outline, size: 50),
        message: _mesaj,
        textStyle: const TextStyle(fontSize: 15, color: Colors.white),
      ),
    );
  }
}
