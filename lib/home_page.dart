import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_demo/user_gallery_page.dart';
import './model/user.dart';
import './data/user_api.dart';
import 'package:get/get.dart';

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
    getUsersFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(60),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: _userList.length,
                itemBuilder: (context, index) {
                  if (_userList == null) {
                    return Text("Loading..");
                  } else if (_userList.length < 0) {
                    return Text("There is no list");
                  } else {
                    return InkWell(
                      onTap: () {
                        Get.to(() => UserGalleryPage(
                              userId: _userList[index].id,
                              user: _userList[index],
                            ));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        color: Colors.red,
                        child: Text(_userList[index].name),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getUsersFromApi() async {
    UserApi.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        _userList = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }
}
