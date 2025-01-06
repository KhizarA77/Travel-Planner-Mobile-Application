import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelhive/services/upload_service.dart';
import 'package:travelhive/services/user_collection_service.dart';

class ProfileCard extends StatefulWidget {
  final String name;
  final String photoURL;

  const ProfileCard({Key? key, required this.name, required this.photoURL})
      : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  late String name;
  late String photoURL;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    photoURL = widget.photoURL;
  }

  void _changeName(String _name) {
    // Implement your logic to change the name
    setState(() {
      name = _name;
      UserCollectionService().updateUserName(
          uid: FirebaseAuth.instance.currentUser!.uid, name: _name);
    });
  }

  void _changePhoto() async {
    String _photoURL = await UploadService().updateImageInCollection(FirebaseAuth.instance.currentUser!.uid);
    // Implement your logic to change the photo
    setState(() {
      photoURL = _photoURL;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      height: 200.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipOval(
                child: Image.network(
                  photoURL.isEmpty ? (FirebaseAuth.instance.currentUser!.photoURL ?? 'default_photo_url') : photoURL,
                  width: 60.w,
                  height: 60.h,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: _changePhoto,
                  child: Icon(
                    Icons.camera_alt,
                    size: 20.w,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Stack(
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Positioned(
                right: -20,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        TextEditingController _controller =
                            TextEditingController(text: name);
                        return AlertDialog(
                          title: Text('Edit Name'),
                          content: TextField(
                            controller: _controller,
                            decoration:
                                InputDecoration(hintText: "Enter new name"),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                _changeName(_controller.text);
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.edit,
                    size: 20.w,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Text(
            'Guest',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
