import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:backend_api/provider/token_provider.dart';
import 'package:backend_api/provider/user_provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  final String currentName;

  const UpdateProfileScreen({super.key, required this.currentName});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late TextEditingController _nameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleUpdate() async {
    if (_formKey.currentState!.validate()) {
      final token = Provider.of<TokenProvider>(context, listen: false).getToken();
      if (token == null) return;

      final success = await Provider.of<UserProvider>(context, listen: false).updateProfile(
        token: token,
        name: _nameController.text.trim(),
      );

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profile updated successfully!")),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to update profile.")),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return "Name cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: userProvider.isLoading ? null : _handleUpdate,
                      child: userProvider.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Save Changes"),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}