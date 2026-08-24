import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:backend_api/provider/token_provider.dart';
import 'package:backend_api/provider/user_provider.dart';

import 'package:backend_api/views/profile/update_profile.dart';


class GetProfileScreen extends StatefulWidget {
  const GetProfileScreen({super.key});

  @override
  State<GetProfileScreen> createState() => _GetProfileScreenState();
}

class _GetProfileScreenState extends State<GetProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = Provider.of<TokenProvider>(context, listen: false).getToken();
      if (token != null) {
        Provider.of<UserProvider>(context, listen: false).fetchProfile(token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              final user = Provider.of<UserProvider>(context, listen: false).userModel?.user;
              if (user != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UpdateProfileScreen(currentName: user.name ?? ''),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = userProvider.userModel?.user;

          if (user == null) {
            return const Center(child: Text("Failed to load profile details."));
          }

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.deepOrange,
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 2,
                  child: ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: const Text("Name"),
                    subtitle: Text(user.name ?? "N/A"),
                  ),
                ),
                Card(
                  elevation: 2,
                  child: ListTile(
                    leading: const Icon(Icons.email_outlined),
                    title: const Text("Email"),
                    subtitle: Text(user.email ?? "N/A"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}