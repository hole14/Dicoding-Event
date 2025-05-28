import 'package:dicoding_event/component/constrains.dart';
import 'package:dicoding_event/screen/favorite.dart';
import 'package:dicoding_event/screen/home.dart';
import 'package:dicoding_event/screen/setting.dart';
import 'package:dicoding_event/viewModel/eventViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'component/theme_notifier.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appSetting = context.watch<ThemeNotifier>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: appSetting.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    FavoriteScreen(),
    SettingPage(),
  ];

  final List<String> _titles = [
    'Events',
    'Favorite Events',
    'Settings',
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: primaryColor,
        selectedItemColor: secondColor,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30.0,),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, size: 30.0,),
            label: 'Favorite'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 30.0,),
            label: 'Settings'
          ),
        ],
      ),
    );
  }
}

