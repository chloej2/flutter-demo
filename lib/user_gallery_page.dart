import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_demo/model/user_image.dart';
import 'package:flutter_demo/widget/circular_loading.dart';
import 'package:flutter_demo/widget/gallery_animation.dart';
import 'package:flutter_demo/widget/photo_hero.dart';
import 'package:get/get.dart';
import 'data/user_image_api.dart';
import 'model/user.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class UserGalleryPage extends StatefulWidget {
  final int userId;
  final User user;
  const UserGalleryPage({Key? key, required this.userId, required this.user})
      : super(key: key);

  @override
  _UserGalleryPageState createState() => _UserGalleryPageState();
}

class _UserGalleryPageState extends State<UserGalleryPage> {
  List<UserImage> _userImageList = [];
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    getUsersFromApi(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 80,
          padding:
              const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(color: Colors.lightBlue[100], boxShadow: [
            BoxShadow(
              blurRadius: 4.0,
              color: Colors.blueGrey.withOpacity(0.8),
            )
          ]),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Text(
                widget.user.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(child: Container()),
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back),
              ),
            ],
          ),
        ),
        _userImageList.isNotEmpty
            ? galleryWidget()
            : _userImageList.isEmpty && _isLoading
                ? const CircularLoading()
                : const Center(
                    child: Text(
                    "There is no image to display",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
      ],
    ));
  }

  Flexible galleryWidget() {
    return Flexible(
        child: Container(
      padding: const EdgeInsets.all(10),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        shrinkWrap: true,
        children: List.generate(20, (index) {
          return GalleryAnimation(
            index: index,
            galleryWidget: PhotoHero(
                photo: _userImageList[index].thumbnailPath,
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return Scaffold(
                      body: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 80,
                            padding: const EdgeInsets.only(
                              top: 40,
                              left: 10,
                              right: 10,
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.lightBlue[100],
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4.0,
                                    color: Colors.blueGrey.withOpacity(0.8),
                                  )
                                ]),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height - 80,
                            alignment: const Alignment(0.0, 0.0),
                            color: Colors.black12,
                            child: PhotoHero(
                              photo: _userImageList[index].imagePath,
                              width: MediaQuery.of(context).size.width,
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }));
                }),
          );
        }),
      ),
    ));
  }

  void getUsersFromApi(int userId) async {
    _isLoading = true;
    UserImageApi.getUserImages(userId).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        _userImageList =
            list.map((model) => UserImage.fromJson(model)).toList();
      });
      _isLoading = false;
    });
  }
}
