import 'package:flutter/material.dart';

void main() => runApp(MainRoute());

class MainRoute extends StatefulWidget {
  MainRoute({Key key}) : super(key: key);

  @override
  _MainRoute createState() => _MainRoute();
}

class _MainRoute extends State {
  var _currentPage = 0;
  var _pages = [
    Text("Page 1 - Поиск"),
    Text("Page 2 - Задачи"),
    Text("Page 3 - Создать"),
    Text("Page 4 - Процессы"),
    Text("Page 5 - Профиль"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Flutter Test Project",
        home: Scaffold(
            body: Center(
              child: _pages.elementAt(_currentPage),
            ),
            bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search), title: Text("Поиск")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_today_outlined),
                      title: Text("Задачи")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add_circle_outline),
                      title: Text("Создать")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.article_outlined),
                      title: Text("Процессы")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), title: Text("Профиль")),
                ],
                currentIndex: _currentPage,
                fixedColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                onTap: (int inIndex) {
                  setState(() {
                    _currentPage = inIndex;
                  });
                })));
  }
}
