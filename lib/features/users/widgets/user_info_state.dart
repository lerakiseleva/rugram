import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rugram/data/remote_data_sources/user/user_data_source.dart';
import 'package:rugram/domain/models/user_preview.dart';
import 'package:rugram/features/users/widgets/user_info.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rugram/features/text_utils.dart';

class UserInfoState extends State<UserInfo> {
  final TextUtils _textUtils = TextUtils();
  late final UserDataSource userDataSource;
  late UserPreview user;
  final picker = ImagePicker();
  String Photo = "...";
  XFile? image;

  XFile? get imageProfile => image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                //onTap: () {
                  //pickImage(context);
                //},
                child: ClipOval(
                    child: Image.network(
                      Photo,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                )
            ),
            Expanded(
              flex: 2,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    _textUtils.bold20("12", Colors.black),
                    const SizedBox(height: 5),
                    _textUtils.normal14("Posts", Colors.black),
                  ],
                ),
                Column(
                  children: [
                    _textUtils.bold20("454", Colors.black),
                    const SizedBox(height: 5),
                    _textUtils.normal14("Followers", Colors.black)
                  ],
                ),
                Column(
                  children: [
                    _textUtils.bold20("512", Colors.black),
                    const SizedBox(height: 5),
                    _textUtils.normal14("Following", Colors.black)
                  ],
                )
              ],
            ),
            ),
          ],
        ),
        Row(
          children: [

            Padding(
              padding: EdgeInsets.only(left: 12),
              child: _textUtils.normal16(widget.username, Colors.black),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    userDataSource = context.read<UserDataSource>();
    init();
  }

  Future<void> init() async {
    final usersInfo = await userDataSource.getProfiles();
    user = usersInfo.data[10];
    Photo = user.picture;
    setState(() {});
  }


}
