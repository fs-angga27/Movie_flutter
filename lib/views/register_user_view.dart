import 'package:flutter/material.dart';
import 'package:movie_flutter/service/user.dart';
import 'package:movie_flutter/widgets/alert.dart';

class RegisterUserView extends StatefulWidget {
  const RegisterUserView({super.key});

  @override
  State<RegisterUserView> createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView> {
  UserService user = UserService();
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  List<String> roleChoice = ["admin", "user"];
  String? role;

  @override
  void initState() {
    super.initState();
    insertUser();
  }

  Future<void> insertUser() async {
    var data = {
      "name": name.text,
      "email": email.text,
      "role": role,
      "password": password.text,
    };
    var result = await UserService().registerUser(data);
    print(result.status);
    print(result.message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register User"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              const Text(
                "Register User",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: name,
                      decoration: const InputDecoration(labelText: "Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama harus diisi';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(labelText: "Email"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email harus diisi';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: role,
                      items: roleChoice.map((r) {
                        return DropdownMenuItem(
                          value: r,
                          child: Text(r),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          role = value;
                        });
                      },
                      hint: const Text("Pilih role"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Role harus dipilih';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: password,
                      decoration: const InputDecoration(labelText: "Password"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password harus diisi';
                        }
                        return null;
                      },
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          var data = {
                            "name": name.text,
                            "email": email.text,
                            "role": role,
                            "password": password.text,
                          };
                          var result = await user.registerUser(data);
                          if (result.status == true) {
                            name.clear();
                            email.clear();
                            password.clear();
                            setState(() {
                              role = null;
                            });
                            AlertMessage()
                                .showAlert(context, result.message, true);
                          } else {
                            AlertMessage()
                                .showAlert(context, result.message, false);
                          }
                        }
                      },
                      child: Text("Register"),
                      color: Colors.lightGreen,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}