import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lottie/lottie.dart';
import 'package:library_automation/view/homepage.dart';
import 'package:library_automation/view_model/authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text("Mersin Üniversitesi Kütüphane ve Bilgi Merkezi", style: TextStyle(color: Colors.black)),
          bottom: _isLoading == true ? const PreferredSize(preferredSize: Size(double.infinity, 1), child: LinearProgressIndicator()) : null),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          buildLoginPage(context),
          const VerticalDivider(),
          Expanded(
            flex: 1,
            child: Lottie.asset('assets/animasyon.json'),
          ),
        ],
      ),
    );
  }

  Widget buildLoginPage(BuildContext context) {
    late String _username, _password;
    var _formKey = GlobalKey<FormState>();
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(100),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/uniLogo.png", width: 150, height: 150),
                ],
              ),
              Card(
                child: TextFormField(
                  initialValue: "admin",
                  decoration: const InputDecoration(labelText: "Kullanıcı Ad", border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Lütfen Boş Bırakmayınız.";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      _username = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 15),
              Card(
                child: TextFormField(
                  initialValue: "admin",
                  decoration: const InputDecoration(labelText: "Şifre", border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Lütfen Boş Bırakmayınız.";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      _password = value!;
                    });
                  },
                  onFieldSubmitted: (value) {
                    setState(() {
                      _formKey.currentState!.save();
                      login(_username, value);
                    });
                  },
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Card(
                    child: InkWell(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: 40,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.blue),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text("Giriş Yap", style: TextStyle(color: Colors.white, fontSize: 22)),
                            Icon(Icons.arrow_forward_ios_outlined, color: Colors.white)
                          ],
                        ),
                      ),
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          setState(() {
                            _isLoading = true;
                          });
                          login(_username, _password);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const Expanded(
                  child: SizedBox(
                height: 450,
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> login(String username, String password) async {
    bool isTrue = await Authentication().login(username: username, password: password);
    if (isTrue) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
      setState(() {
        _isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Lütfen Bilgilerinizi Kontrol Ediniz!',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red));
      setState(() {
        _isLoading = false;
      });
      debugPrint("Yanlış username/password !!");
    }
  }
}
