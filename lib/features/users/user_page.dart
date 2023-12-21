import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rugram/features/home/bloc/posts_cubit.dart';
import 'package:rugram/features/text_utils.dart';
import 'package:rugram/data/remote_data_sources/user/user_data_source.dart';
import 'package:rugram/features/users/widgets/user_info.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/models/user_preview.dart';



class MyUserPage extends StatefulWidget {
  MyUserPage({Key? key}) : super(key: key);

  @override
  _MyUserPageState createState() => _MyUserPageState();
}

class _MyUserPageState extends State<MyUserPage> with TickerProviderStateMixin {
  final TextUtils _textUtils = TextUtils();
  late TabController tabController;
  ScrollController scrollController = ScrollController();
  late final UserDataSource userDataSource;
  late final PostsCubit postsCubit;
  TextEditingController nameController = TextEditingController();
  String username = "...";
  late UserPreview user;
  List<String> imageUrls = [];
  final picker = ImagePicker();
  String Photo = "...";
  XFile? image;

  XFile? get imageProfile => image;


 /* @override
  void initState() {
    //scrollController = ScrollController()..addListener(listenScroll);
    //postsCubit = PostsCubit(context.read())..init();
    super.initState();

    tabController = TabController(length: 2, vsync: this);
  } */

  @override
  void dispose() {
    //scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: scrollController,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: UserInfo(
                        imageUrls: imageUrls,
                        username: username,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
              margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _editProfile(),
                    child: Container(
                      height: 40,
                      //decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: _textUtils.normal16("Edite username", Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //pickImage(context);
                      pickGalleryImage();
                      //context.read<UserDataSource>().createPost();
                    },
                    child:Container(
                      height: 40,
                      //decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: _textUtils.normal16("Edit profile picture", Colors.black),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 0.8,
              indicatorPadding: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              controller: tabController,
              tabs: const [
                Tab(icon: Icon(Icons.grid_on_rounded)),
                Tab(icon: Icon(Icons.person_pin_outlined)),
              ],
            ),
        Expanded(
                child: TabBarView(
                    controller: tabController,
                    children: [
                      GridView.count(
                        controller: scrollController,
                        crossAxisCount: 3,
                        children: [
                          for (int i = 0; i < 12; i++)
                            Container(
                              margin: const EdgeInsets.only(right: 3, top: 3),
                              child: Image.network(
                                "https://petitespaws.com/cdn/shop/products/IMG_4847.jpg?v=1677187232",
                                fit: BoxFit.cover,
                              ),
                            )
                        ],
                      ),
                      Center(
                        child: Column(
                          children: const [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Photos where you were marked",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    postsCubit = PostsCubit(context.read())..initWithTag(tag: "person");
    userDataSource = context.read<UserDataSource>();
    init();
    // loadImages();
  }

  Future<void> init() async {
    final usersInfo = await userDataSource.getProfiles();
    user = usersInfo.data[10];
    username = user.firstName;
    setState(() {});
  }

  Future<void> update({required String name}) async {
    final updatedUser = await userDataSource.updateProfile(profileId: user.id, name: name);
    username = updatedUser.firstName;
    setState(() {});
  }

  Future<void> updateUserPhoto({required String photo}) async {
    final updatedUser = await userDataSource.updateProfileUserPhoto(
        profileId: user.id, userPicture: photo);
    Photo = updatedUser.picture;
    setState(() {});
  }

  void _editProfile() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New username'),
          content: TextFormField(
            controller: nameController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: ()
              {
                update(name: nameController.text);
                Navigator.pop(context);
              },
              child: const Text('Save', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  Future pickGalleryImage() async {
    TextEditingController imageUrlController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Link to the image', style: TextStyle(color: Colors.black)),
          content: TextFormField(
            controller: imageUrlController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                if (imageUrlController.text.isNotEmpty) {
                  Navigator.pop(context, imageUrlController.text);
                }
              },
              child: const Text('Save', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    ).then((imageUrl) {
      if (imageUrl != null && imageUrl.isNotEmpty) {
        setState(() {
          updateUserPhoto(photo: imageUrl);
        });
      }
    });
  }

  void showFullScreenImage(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image.network(
              imageUrl,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
