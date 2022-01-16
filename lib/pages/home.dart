import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late List<TabController> _controllers;
  late List<List<Tab>> _tabGroups;
  late List<List<Widget>> _tabContents;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controllers = [];
    _tabGroups = [];
    _tabContents = [];
    for (int i = 0; i < 5; i++) {
      List<Tab> tabs = [];
      List<Widget> contents = [];

      for (int j = 0; j < 10; j++) {
        tabs.add(
          Tab(
            text: 'Tab $i-$j',
          ),
        );

        contents.add(
          Center(
            child: Text('Content $i-$j'),
          ),
        );
      }

      _tabGroups.add(tabs);
      _tabContents.add(contents);
      _controllers.add(
        TabController(
          length: tabs.length,
          vsync: this,
        ),
      );
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tab Demo'),
        bottom: TabBar(
          // key: ValueKey('TabBar-$_index'),
          isScrollable: true,
          controller: _controllers[_index],
          tabs: _tabGroups[_index],
        ),
      ),
      body: TabBarView(
        controller: _controllers[_index],
        children: _tabContents[_index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        items: [
          for (int i = 0; i < 5; i++)
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_rounded),
              label: 'Group $i',
            ),
        ],
      ),
    );
  }
}
