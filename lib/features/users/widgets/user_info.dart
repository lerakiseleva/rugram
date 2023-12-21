import 'package:flutter/cupertino.dart';
import 'package:rugram/features/users/widgets/user_info_state.dart';


class UserInfo extends StatefulWidget {
  const UserInfo({
    super.key,
    required this.imageUrls,
    required this.username,
  });

  final List<String> imageUrls;
  final String username;

  @override
  UserInfoState createState() => UserInfoState();
}