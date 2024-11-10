import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/auth_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Icon(
                    Icons.health_and_safety,
                    color: Colors.black,
                    size: 60,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  leading: const Icon(Icons.message),
                  title: const Text('Safety Chatbot'),
                  onTap: () {
                    Navigator.of(context).pop();
                    context.go('/chat');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  leading: const Icon(Icons.list),
                  title: const Text('Trips'),
                  onTap: () {
                    Navigator.of(context).pop();
                    context.go('/trip_list');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.of(context).pop();
                    context.go('/profile');
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              bottom: 20,
            ),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                Provider.of<AuthenticationProvider>(context, listen: false)
                    .signOut();
                Navigator.of(context).pop();
                context.go('/login');
              },
            ),
          ),
        ],
      ),
    );
  }
}
