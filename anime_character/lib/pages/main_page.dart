import 'package:anime_character/models/action_figure_model.dart';
import 'package:anime_character/models/category_model.dart';
import 'package:anime_character/pages/detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';
import '../widgets/app_bar_button.dart';
import '../widgets/category_item.dart';
import '../widgets/figure_item.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedCategory = 0;
  int currentMenu = 0 ;
  ScrollController scrollController = ScrollController();
  List<ActionFigureModel> datas = actionModel.where((element) => element.category.contains(categories[0].category)).toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leadingWidth: 75,
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Row(
          children: [
            SizedBox(
              width: 30,
            ),
            AppBarButton(
              icon: Icons.menu_rounded,
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              AppBarButton(icon: Icons.search),
              SizedBox(
                width: 10,
              ),
              Stack(
                children: [
                  const AppBarButton(icon: Icons.shopping_cart_outlined),
                  Positioned(
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: Text(
                        '3',
                        style: poppins.copyWith(color: white, fontSize: 10),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 30,
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: RichText(
                text: TextSpan(
                    style: poppins.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: black),
                    children: const [
                  TextSpan(text: 'Find Your Favourite\nAction Figure'),
                  WidgetSpan(
                      child: SizedBox(
                    width: 10,
                  )),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(
                      Icons.favorite_rounded,
                      color: Colors.red,
                      size: 28,
                    ),
                  ),
                ])),
          ),
          const SizedBox(
            height: 30.0,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(
                    categories.length,
                    (index) => Padding(
                          padding: index == 0
                              ? const EdgeInsets.only(left: 40.0, right: 12.0)
                              : index == categories.length - 1
                                  ? const EdgeInsets.only(right: 12.0)
                                  : EdgeInsets.only(right: 12.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = index;
                                datas = actionModel.where((element) => element.category.contains(categories[index].category)).toList();
                                scrollController.animateTo(0.0, duration: Duration(milliseconds: 250), curve: Curves.easeIn);
                              });
                            },
                            child: CategoryItem(
                              category: categories[index],
                              selected: selectedCategory == index,
                            ),
                          ),
                        ))
              ],
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(bottom: 10.0),
            clipBehavior: Clip.none,
            controller: scrollController,
            physics: ClampingScrollPhysics(),
            child: Row(
              children: [
                ...List.generate(
                    datas.length,
                    (index) => Padding(
                          padding: index == 0
                              ? EdgeInsets.only(left: 30.0)
                              : index == actionModel.length - 1
                                  ? EdgeInsets.only(right: 30.0, left: 20.0)
                                  : EdgeInsets.only(left: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, PageRouteBuilder(
                                  transitionDuration: Duration(milliseconds: 500),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return child;
                              },
                              pageBuilder: (context, animation, secondaryAnimation) {
                              return DetailPage(figure: datas[index]);
                              } ));
                            },
                            child: FigureItem(
                              figure: datas[index],
                            ),
                          ),
                        ))
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: green,
        unselectedItemColor: black.withOpacity(0.7),
        type: BottomNavigationBarType.fixed,
        currentIndex: currentMenu,
        onTap: (value){
          setState(() {
            currentMenu = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded), label: ''),
          BottomNavigationBarItem(icon: Stack(
            children: [
              Icon(Icons.notifications_rounded),
              Positioned(
                right: 5,
                child: Container(
                  width: 7.5,
                  height: 7.5,
                  decoration: const BoxDecoration(
                    color: Colors.red, shape: BoxShape.circle
                  ),
                ),
              ),
            ],
          ),
              label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: ''),
        ],
      ),
    );
  }
}






