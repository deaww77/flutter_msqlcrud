import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Flutter PHP CRUD',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(title: const Text('Home'), onTap: () {}),
          ListTile(title: const Text('Menu'), onTap: () {}),
        ],
      ),
    );
  }
}
