import 'package:flutter/material.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/screen/home_screen.dart';
import 'package:salati/screen/qibla.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          setState(() {
            _selectedIndex = tabController.index;
          });
        });
        return Scaffold(
            bottomNavigationBar: TabBar(
              labelPadding: const EdgeInsets.all(10),
              labelColor: Theme.of(context).colorScheme.primary,
              labelStyle: Theme.of(context).textTheme.bodySmall,
              unselectedLabelColor: Colors.black,
              indicator:
                  BoxDecoration(border: Border.all(color: Colors.transparent)),
              tabs: [
                _buildTab(
                    activeIcon: const Image(
                        image: AssetImage(homeIconActiveNavBar),
                        width: 20,
                        height: 18),
                    inactiveIcon: const Image(
                        image: AssetImage(homeIconNavBar),
                        width: 20,
                        height: 18),
                    iconlabel: 'Home',
                    index: 0),
                _buildTab(
                    activeIcon: Container(
                        margin: const EdgeInsets.only(top: 6),
                        child: const Image(
                            image: AssetImage(qiblaActiveNavBar),
                            width: 28,
                            height: 28)),
                    inactiveIcon: Container(
                        margin: const EdgeInsets.only(top: 6),
                        child: const Image(
                            image: AssetImage(qiblaNavBar),
                            width: 28,
                            height: 28)),
                    iconlabel: 'Qibla',
                    index: 1),
                _buildTab(
                    activeIcon: Container(
                        margin: const EdgeInsets.only(top: 6),
                        child: const Image(
                            image: AssetImage(tasbihActiveNavBar),
                            width: 28,
                            height: 28)),
                    inactiveIcon: Container(
                        margin: const EdgeInsets.only(top: 6),
                        child: const Image(
                            image: AssetImage(tasbihNavBar),
                            width: 28,
                            height: 28)),
                    iconlabel: 'Tasbih',
                    index: 2),
                _buildTab(
                    activeIcon: Icon(Icons.menu,
                        size: 28,
                        color: Theme.of(context).colorScheme.background),
                    inactiveIcon:
                        const Icon(Icons.menu, size: 28, color: Colors.black),
                    iconlabel: 'More',
                    index: 3),
              ],
            ),
            body: const TabBarView(
              children: [
                HomeScreen(),
                Qibla(),
                Text('ok'),
                Text('ok'),
              ],
            ));
      }),
    );
  }

  Widget _buildTab(
      {Widget? activeIcon,
      Widget? inactiveIcon,
      String? iconlabel,
      int? index}) {
    return Tab(
      icon: _selectedIndex == index
          ? Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).colorScheme.primary),
              child: Center(child: activeIcon))
          : Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).colorScheme.background),
              child: Center(child: inactiveIcon)),
      text: iconlabel,
    );
  }
}
