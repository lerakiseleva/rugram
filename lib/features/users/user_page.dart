import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rugram/features/text_utils.dart';
import 'package:rugram/features/users/user_data_source.dart';



class MyUserPage extends StatefulWidget {
  const MyUserPage({Key? key}) : super(key: key);

  @override
  State<MyUserPage> createState() => _MyUserPageState();
}

class _MyUserPageState extends State<MyUserPage> with TickerProviderStateMixin {
  final TextUtils _textUtils = TextUtils();
  late TabController tabController;
  ScrollController scrollController = ScrollController();


  @override
  void initState() {
    //scrollController = ScrollController()..addListener(listenScroll);
    //postsCubit = PostsCubit(context.read())..init();
    super.initState();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    //scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Image.network('https://fonoteka.top/uploads/posts/2022-09/1663793807_40-phonoteka-org-p-kotik-oboi-na-telefon-instagram-43.jpg'),
                           const CircleAvatar(
                               radius: 40, backgroundImage: NetworkImage('https://i10.fotocdn.net/s129/60d775a6da0709bb/public_pin_l/2928685399.jpg')),
                          const SizedBox(height: 10),
                          _textUtils.normal16("Lera and Liza", Colors.black),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              _textUtils.bold20("0", Colors.black),
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
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  children: [
                    ElevatedButton(
                    onPressed: () {
                    //createPost();
                    },
                      child: Container(
                        height: 40,
                        //decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: _textUtils.normal16("Edite profile", Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<UserDataSource>().createPost();
                      },
                      child:Container(
                        height: 40,
                        //decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: _textUtils.normal16("Create post", Colors.black),
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
                        for (int i = 0; i < 9; i++)
                          Container(
                            margin: const EdgeInsets.only(right: 3, top: 3),
                            child: Image.network('https://uhd.name/uploads/posts/2023-03/1678889579_uhd-name-p-kotik-s-brovyami-pinterest-74.jpg'),
                          )
                      ],
                    ),
                    GridView.count(
                      controller: scrollController,
                      crossAxisCount: 3,
                      children: [
                        for (int i = 0; i < 9; i++)
                          Container(
                            margin: const EdgeInsets.only(right: 3, top: 3),
                            child: Image.network('https://uhd.name/uploads/posts/2023-03/1678889579_uhd-name-p-kotik-s-brovyami-pinterest-74.jpg'),
                          )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
