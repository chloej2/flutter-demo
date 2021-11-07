import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import './model/user.dart';
import './data/user_api.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<User> _userList = [];
  @override
  void initState() {
    super.initState();
    getUsersfromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(100),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  itemCount: _userList.length,
                  itemBuilder: (context, index) {
                    if (_userList == null) {
                      return Text("Loading..");
                    } else {
                      return Text(_userList[index].name);
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void getUsersfromApi() async {
    UserApi.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        _userList = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }
}
