// ignore_for_file: unused_field, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tes_pitjarus/model/store_model.dart';
import 'package:tes_pitjarus/screen/store/store_view.dart';
import 'package:tes_pitjarus/service/db_store.dart';
import 'package:tes_pitjarus/utils/colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginVuewState();
}

class _LoginVuewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  void login(String username, password) async {
    try {
      Response response = await post(
          Uri.parse(
              'http://dev.pitjarus.co/api/sariroti_md/index.php/login/loginTest'),
          body: {'username': username, 'password': password});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        // print(data['stores']);
        (data['stores'] as List).map((store) {
          print('Inserting $store');
          DBStore.createStores(Store.fromJson(store));
        }).toList();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ViewStore()),
        );
        print('Login successfully');
      } else {
        print('Login gagal, periksa kembali username/password Anda');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: ColorsComponent.maincolor,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: ColorsComponent.maincolor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            maximumSize: const Size(double.infinity, 46),
            minimumSize: const Size(double.infinity, 46),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color.fromARGB(255, 250, 250, 250),
          iconColor: ColorsComponent.maincolor,
          prefixIconColor: ColorsComponent.maincolor,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 0.5, color: Colors.grey),
          ),
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: [
                              const Spacer(),
                              Expanded(
                                flex: 8,
                                child: Form(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: TextFormField(
                                          keyboardType: TextInputType.name,
                                          textInputAction: TextInputAction.next,
                                          cursorColor:
                                              ColorsComponent.maincolor,
                                          controller: emailController,
                                          onSaved: (email) {},
                                          decoration: const InputDecoration(
                                            hintText: "Username",
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Icon(Icons.person),
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextFormField(
                                        textInputAction: TextInputAction.done,
                                        obscureText: true,
                                        controller: passwordController,
                                        cursorColor: ColorsComponent.maincolor,
                                        decoration: const InputDecoration(
                                          hintText: "Password",
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Icon(Icons.lock),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: false,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _value = value!;
                                                  });
                                                },
                                              ),
                                              Text(
                                                "Keep Username",
                                                style: TextStyle(
                                                  color:
                                                      ColorsComponent.maincolor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.download,
                                                  size: 16.0,
                                                  color:
                                                      ColorsComponent.maincolor,
                                                ),
                                              ),
                                              Text(
                                                "Check Update",
                                                style: TextStyle(
                                                  color:
                                                      ColorsComponent.maincolor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 24.0),
                                      Hero(
                                        tag: "login_btn",
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Service().userLogin(
                                            //     emailController.toString(),
                                            //     passwordController.toString());
                                            login(
                                                emailController.text.toString(),
                                                passwordController.text
                                                    .toString());
                                          },
                                          child: Text(
                                            "Login".toUpperCase(),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "App Ver ${_packageInfo.version} ${_packageInfo.buildSignature}",
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
