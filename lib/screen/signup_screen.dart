import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoe_box_client/const/colors.dart';
import 'package:shoe_box_client/screen/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController genderController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController idController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final List<bool> _selectedGender = <bool>[true, false];
  final List<Widget> icons = <Widget>[
    const Icon(Icons.male_rounded),
    const Icon(Icons.female_rounded),
  ];
  bool vertical = false;

  List<int?> shoeSizeList = [
    null,
    210,
    215,
    220,
    225,
    230,
    235,
    240,
    245,
    250,
    255,
    260,
    265,
    270,
    275,
    280,
    285,
    290,
    295,
    300,
    310,
    320
  ];
  int? userNikeSize;
  int? userAdidasSize;
  int? userNewBalanceSize;
  int? userVansSize;
  int? userConverseSize;

  void signup(BuildContext context) async {
    final name = nameController.text;
    final age = ageController.text;
    final email = emailController.text;
    final id = idController.text;
    final password = passwordController.text;
    var gender = "male";
    if (_selectedGender[0]) {
      gender = "male";
    } else {
      gender = "female";
    }

    Map signupData = {
      "userName": name,
      "age": int.parse(age),
      "gender": gender,
      "email": email,
      "id": id,
      "password": password,
      "shoesSizes": {
        "nike": userNikeSize,
        "adidas": userAdidasSize,
        "newBalance": userNewBalanceSize,
        "vans": userVansSize,
        "converse": userConverseSize
      }
    };

    final success = await apiService.signupPost(signupData);
    // Perform signup logic here
    if (success == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('환영합니다!'),
            content: const Text('이제 브랜드 별 신발 사이즈를 추천 받아보세요.'),
            actions: <Widget>[
              Center(
                child: ElevatedButton(
                  child: const Text('로그인하러 가기'),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const LoginScreen();
                    }));
                  },
                ),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ID 중복'),
            content: const Text('사용하실 ID를 다시 입력해주세요.'),
            actions: <Widget>[
              Center(
                child: ElevatedButton(
                  child: const Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        },
      );
    }
    // Redirect to another screen after signup
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      '회원가입',
                      style: TextStyle(fontSize: 28),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: '이름'),
                ),
                TextField(
                  controller: ageController,
                  decoration: const InputDecoration(labelText: '나이'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Text(
                      '성별',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ToggleButtons(
                      direction: vertical ? Axis.vertical : Axis.horizontal,
                      onPressed: (int index) {
                        setState(
                          () {
                            // The button that is tapped is set to true, and the others to false.
                            for (int i = 0; i < _selectedGender.length; i++) {
                              _selectedGender[i] = i == index;
                            }
                          },
                        );
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      selectedBorderColor: primaryColor,
                      selectedColor: Colors.white,
                      fillColor: selectedColor,
                      color: selectedColor,
                      isSelected: _selectedGender,
                      children: icons,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(labelText: 'ID'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '브랜드 별 보유하고 계신 신발 사이즈를 선택해주세요',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text('Nike'),
                        ),
                        Expanded(
                          flex: 3,
                          child: DropdownButton(
                            isExpanded: true,
                            value: userNikeSize,
                            items: shoeSizeList
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child:
                                          Text(e != null ? e.toString() : '없음'),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              userNikeSize = value;
                              setState(() {});
                              log(userNikeSize.toString());
                              log(value.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text('Adidas'),
                        ),
                        Expanded(
                          flex: 3,
                          child: DropdownButton(
                            isExpanded: true,
                            value: userAdidasSize,
                            items: shoeSizeList
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child:
                                          Text(e != null ? e.toString() : '없음'),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              userAdidasSize = value;
                              setState(() {});
                              log(userAdidasSize.toString());
                              log(value.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text('NewBalance'),
                        ),
                        Expanded(
                          flex: 3,
                          child: DropdownButton(
                            isExpanded: true,
                            value: userNewBalanceSize,
                            items: shoeSizeList
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child:
                                          Text(e != null ? e.toString() : '없음'),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              userNewBalanceSize = value;
                              setState(() {});
                              log(userNewBalanceSize.toString());
                              log(value.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text('Vans'),
                        ),
                        Expanded(
                          flex: 3,
                          child: DropdownButton(
                            isExpanded: true,
                            value: userVansSize,
                            items: shoeSizeList
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child:
                                          Text(e != null ? e.toString() : '없음'),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              userVansSize = value;
                              setState(() {});
                              log(userVansSize.toString());
                              log(value.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text('Converse'),
                        ),
                        Expanded(
                          flex: 3,
                          child: DropdownButton(
                            isExpanded: true,
                            value: userConverseSize,
                            items: shoeSizeList
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child:
                                          Text(e != null ? e.toString() : '없음'),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              userConverseSize = value;
                              setState(() {});
                              log(userConverseSize.toString());
                              log(value.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[400],
                        ),
                        child: const Text('돌아가기'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedColor,
                        ),
                        child: const Text('가입하기'),
                        onPressed: () {
                          signup(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sizeDropdown(int? brandValue) {
    return DropdownButton(
      value: brandValue,
      items: shoeSizeList
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e != 0 ? e.toString() : '없음'),
              ))
          .toList(),
      onChanged: (value) {
        brandValue = value;
        setState(() {});
        log(brandValue.toString());
        log(value.toString());
      },
    );
  }
}
