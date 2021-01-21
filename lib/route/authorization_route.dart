import 'package:flutter/material.dart';
import '../camera/qr_scanner.dart';
import '../route/main_route.dart';
import '../model/User.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State {
  var _currentStep = 0;
  User _user = new User();

  var maskFormatter = new MaskTextInputFormatter(
      mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PocketERP",
      home: Scaffold(
          appBar: AppBar(
            title: Text("Вход"),
          ),
          body: Builder(
            builder: (BuildContext context) => Stepper(
              controlsBuilder: (BuildContext context,
                  {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                return Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: onStepContinue,
                      child: const Text("Далее"),
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                    TextButton(
                      onPressed: onStepCancel,
                      child: const Text("Назад"),
                    ),
                  ],
                );
              },
              type: StepperType.vertical,
              currentStep: _currentStep,
              onStepContinue: _currentStep < 3
                  ? () => setState(() => _currentStep += 1)
                  : null,
              onStepCancel: _currentStep > 0
                  ? () => setState(() => _currentStep -= 1)
                  : null,
              steps: [
                Step(
                    title: Text("Авторизация ERP"),
                    isActive: true,
                    content: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (String inValue) {
                              if (inValue.length == 0) {
                                return "Пожалуйста, введите имя пользователя";
                              }
                              return null;
                            },
                            onSaved: (String inValue) {
                              this._user.usernameERP = inValue;
                            },
                            decoration: InputDecoration(
                                hintText: "Пример: ivanov_i0312",
                                labelText: "Логин к ERP"),
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (String inValue) {
                              if (inValue.length == 0) {
                                return "Пожалуйста, введите пароль";
                              }
                              return null;
                            },
                            onSaved: (String inValue) {
                              this._user.passwordERP = inValue;
                            },
                            decoration: InputDecoration(
                                hintText: "Пароль к ERP",
                                labelText: "Пароль к ERP"),
                          ),
                        ],
                      ),
                    )),
                Step(
                    title: Text("Доменная авторизация"),
                    isActive: true,
                    content: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (String inValue) {
                              if (inValue.length == 0) {
                                return "Пожалуйста, введите имя пользователя";
                              }
                              return null;
                            },
                            onSaved: (String inValue) {
                              this._user.usernameDomain = inValue;
                            },
                            decoration: InputDecoration(
                                hintText: "Пример: ivanov_i0312@core.ufanet.ru",
                                labelText: "Доменный логин"),
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (String inValue) {
                              if (inValue.length == 0) {
                                return "Пожалуйста, введите пароль";
                              }
                              return null;
                            },
                            onSaved: (String inValue) {
                              this._user.passwordDomain = inValue;
                            },
                            decoration: InputDecoration(
                                hintText: "Меняется раз в месяц",
                                labelText: "Доменный пароль"),
                          ),
                        ],
                      ),
                    )),
                Step(
                    title: Text("QR-код"),
                    isActive: true,
                    content: Container(
                        child: RaisedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QRScanner()),
                        );
                      },
                      icon: Icon(Icons.qr_code),
                      label: Text("Cканировать QR-код"),
                      color: Colors.amber,
                      textColor: Colors.white,
                    ))),
                Step(
                  title: Text("Номер телефона"),
                  isActive: true,
                  content: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        inputFormatters: [maskFormatter],
                        validator: (String inValue) {
                          if (inValue.length == 0) {
                            return "Пожалуйста, номер телефона";
                          }
                          return null;
                        },
                        onSaved: (String inValue) {
                          this._user.phoneNumber = inValue;
                        },
                        decoration: InputDecoration(
                            hintText: "+7 (999) 999-99-99",
                            labelText: "Номер телефона для СТП"),
                      ),
                      RaisedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainRoute()),
                          );
                        },
                        icon: Icon(Icons.login),
                        label: Text("Войти"),
                        color: Colors.amber,
                        textColor: Colors.white,
                      )

                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
