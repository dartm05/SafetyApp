import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/services/auth_provider.dart';

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
                  title: const Text('Diagnosis Evaluation'),
                  onTap: () => context.go('/chat'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Form'),
                  onTap: () => context.go('/form'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () => context.go('/'),
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
                Provider.of<AuthenticationProvider>(context, listen: false).signOut();
                context.go('/login');
              },
            ),
          ),
        ],
      ),
    );
  }
}
