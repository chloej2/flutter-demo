import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/model/user_image.dart';
import 'package:get/get.dart';
import 'data/user_image_api.dart';
import 'model/user.dart';

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
              SizedBox(
                width: 10,
              ),
              Text(
                widget.user.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(child: Container()),
              IconButton(
                  onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
            ],
          ),
          _userImageList.isNotEmpty
              ? Flexible(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    shrinkWrap: true,
                    children: List.generate(
                      20,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    _userImageList[index].thumbnailPath),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : _userImageList.isEmpty && _isLoading
                  ? Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  : Text("Empty"),
        ],
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

// class UserGalleryPage extends StatelessWidget {
//   final int userId;
//   final List<UserImage> userImageList;

//   const UserGalleryPage({
//     Key? key,
//     required this.userId,
//     required this.userImageList,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Column(
//           children: [
//             TextButton(
//               child: Icon(Icons.arrow_back),
//               onPressed: () => Get.back(),
//             ),
//             Text('User Id $userId'),
//             Text(userImageList[0].title)
//           ],
//         ),
//       ),
//     );
//   }
// }

// class UserGallery extends StatefulWidget {
//   final int userId;
//   const UserGallery({
//     Key? key,
//     required this.userId,
//   }) : super(key: key);

//   @override
//   _UserGalleryState createState() => _UserGalleryState();
// }

// class _UserGalleryState extends State<UserGallery> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text(),
//     );
//   }
// }
