import 'dart:convert';

import 'package:ebookapp/my_tabs.dart';
import 'package:flutter/material.dart';
import 'package:ebookapp/app_color.dart' as appColor;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late List popularBooks;
  late List books;
  late ScrollController _scrollController;
  late TabController _tabController;
  readData() async {
    await DefaultAssetBundle.of(context).loadString("json/popularBooks.json").then((s){
      setState(() {
        popularBooks=json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context).loadString("json/books.json").then((s){
      setState(() {
        books=json.decode(s);
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    popularBooks=[];
    books=[];
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    readData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: appColor.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageIcon(AssetImage("images/menu.png"),size: 24,color: Colors.black,),
                    Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 10,),
                        Icon(Icons.notifications)
                    ],)
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text("Popular Books",style: TextStyle(fontSize: 30),),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Container(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      left: -20,
                      child: Container(
                      height: 180 ,
                      child: PageView.builder(
                          controller: PageController(viewportFraction: 0.8),
                          itemCount: popularBooks.isEmpty?0:popularBooks.length,
                          itemBuilder: (_,i){
                            return Container(
                              height: 180,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: AssetImage(popularBooks[i]["img"]),
                                      fit: BoxFit.fill
                                  )
                              ),
                            );
                          }),
                        )
                    )
                  ],
                ),
              ),
              Expanded(
                  child: NestedScrollView(
                    controller: _scrollController,
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                      return[
                        SliverAppBar(
                          backgroundColor: appColor.sliverBackground,
                          elevation: 0,
                          pinned: true,
                          bottom: PreferredSize(
                            preferredSize: Size.fromHeight(50),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20,left: 10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide.none, // Removes bottom border
                                ),
                              ),
                              child: TabBar(
                                dividerColor: Colors.transparent,
                                indicatorWeight: 0.5,
                                indicatorPadding: EdgeInsets.all(0),
                                indicatorSize: TabBarIndicatorSize.label,
                                indicatorColor: Colors.transparent,
                                labelPadding: EdgeInsets.only(right: 10),
                                controller: _tabController,
                                isScrollable: false,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 7,
                                      offset: Offset(0,0),
                                    )
                                  ]
                                ),
                                tabs: [
                                  appTabs(color: appColor.menu1Color, text: "New"),
                                  appTabs(color: appColor.menu2Color, text: "Popular"),
                                  appTabs(color: appColor.menu3Color, text: "Trending"),
                                ],
                              ),
                            ),
                          ),
                        )
                      ];
                    },
                    body: TabBarView(
                      controller: _tabController,
                      children: [
                        ListView.builder(
                            itemCount: books.isEmpty?0:books.length,
                            itemBuilder: (_,i){
                          return Container(
                            color: appColor.tabVarViewColor,
                            margin: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    offset: Offset(0,0),
                                    color: Colors.grey.withOpacity(0.2)
                                  ),
                                ],
                              ),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 90,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: AssetImage(books[i]["img"]),
                                        )
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      Row(
                                        children: [
                                          Icon(Icons.star,size: 24,color: appColor.starColor,),
                                          SizedBox(width: 5,),
                                          Text(books[i]["rating"],style: TextStyle(color: appColor.menu2Color),),
                                        ],
                                      ),
                                      Text(books[i]["title"],style: TextStyle(fontSize: 16,fontFamily: "Avenir",fontWeight:FontWeight.bold),),
                                      Text(books[i]["text"],style: TextStyle(fontSize: 16,fontFamily: "Avenir",color: appColor.subTitleText),),
                                      Container(
                                        width: 60,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: appColor.loveColor
                                        ),
                                        child: Text("Love",style: TextStyle(fontSize: 10,fontFamily: "Avenir",color: Colors.white),),
                                        alignment: Alignment.center,
                                      )
                                    ],)
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                        Material(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey,
                            ),
                            title: Text("Content"),
                          ),
                        ),
                        Material(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey,
                            ),
                            title: Text("Content"),
                          ),
                        ),
                      ],
                    ),

                  ))

            ],
          ),
        ),
      ),
    );
  }
}
