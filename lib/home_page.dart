import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_demo/user_gallery_page.dart';
import 'package:flutter_demo/widget/circular_loading.dart';
import './model/user.dart';
import './data/user_api.dart';
import 'package:get/get.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<User> _userList = [];
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    getUsersFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue[100],
        child: Column(
          children: [
            Container(
              height: 80,
              padding: const EdgeInsets.only(
                  top: 40, left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.yellow.shade300,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4.0,
                    )
                  ]),
              child: Row(
                children: const [
                  SizedBox(width: 10),
                  Text(
                    "Flutter Demo",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height - 140,
              child: ListView.builder(
                itemCount: _userList.length,
                itemBuilder: (context, index) {
                  if (_userList.isEmpty && !_isLoading) {
                    return const CircularLoading();
                  } else if (_userList.length <= 0) {
                    return Text("There is no list");
                  } else {
                    return InkWell(
                      onTap: () {
                        Get.to(() => UserGalleryPage(
                              userId: _userList[index].id,
                              user: _userList[index],
                            ));
                      },
                      child: Card(
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        child: ListTile(
                          leading: ProfilePicture(
                            name: _userList[index].name,
                            radius: 16,
                            fontsize: 12,
                          ),
                          title: Text(
                            _userList[index].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            _userList[index].email,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
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
    _isLoading = true;
    UserApi.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        _userList = list.map((model) => User.fromJson(model)).toList();
      });
    });
    _isLoading = false;
  }
}
