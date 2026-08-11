import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_student_section_user/provider/user_provider.dart';
import 'package:quiz_student_section_user/views/profile/update_profile.dart';

class GetProfile extends StatelessWidget {
  const GetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.getUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 12),
            CircleAvatar(
              radius: 48,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              child: Text(
                user.name != null && user.name!.isNotEmpty ? user.name![0].toUpperCase() : "U",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              user.name ?? "N/A",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              user.email ?? "N/A",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 28),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.phone_outlined),
                      title: const Text("Phone Number"),
                      subtitle: Text(user.phone ?? "Not provided"),
                    ),
                    const Divider(indent: 16, endIndent: 16),
                    ListTile(
                      leading: const Icon(Icons.location_on_outlined),
                      title: const Text("Address"),
                      subtitle: Text(user.address ?? "Not provided"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UpdateProfile()),
                  );
                },
                icon: const Icon(Icons.edit_outlined),
                label: const Text("Edit Profile", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}