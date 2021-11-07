import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_demo/model/user_image.dart';
import 'package:flutter_demo/widget/circular_loading.dart';
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
        body: Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
      child: Column(
        children: [
          Row(
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
          _userImageList.isNotEmpty
              ? gallery_widget()
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
      ),
    ));
  }

  Flexible gallery_widget() {
    return Flexible(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        shrinkWrap: true,
        children: List.generate(
          20,
          (index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              columnCount: 2,
              duration: const Duration(milliseconds: 475),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: PhotoHero(
                        photo: _userImageList[index].thumbnailPath,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                            return Scaffold(
                              body: Container(
                                alignment: Alignment(0.0, 0.0),
                                color: Colors.black12,
                                child: PhotoHero(
                                  photo: _userImageList[index].imagePath,
                                  width: MediaQuery.of(context).size.width,
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            );
                          }));
                        }),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
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
