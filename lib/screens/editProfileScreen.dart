import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/widgets/inputWidgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _email;
  final _phone = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    _name = TextEditingController(text: user?.displayName ?? '');
    _email = TextEditingController(text: user?.email ?? '');
    _loadPhone();
  }

  Future<void> _loadPhone() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final doc =
    await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final phone = doc.data()?['phone'] as String?;
    if (mounted && phone != null) _phone.text = phone;
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => _saving = true);
    try {
      await user.updateDisplayName(_name.text.trim());
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': _name.text.trim(),
        'email': user.email ?? '',
        'phone': _phone.text.trim(),
      }, SetOptions(merge: true));

      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not update profile')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Edit Profile', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputWidgets(
                label: 'Email',
                controller: _email,
                readOnly: true,
                prefixIcon: Icons.email,
              ),
              InputWidgets(
                label: 'Full Name',
                controller: _name,
                prefixIcon: Icons.person,
                validator: (v) =>
                v == null || v.trim().isEmpty ? 'Enter your name' : null,
              ),
              InputWidgets(
                label: 'Phone',
                controller: _phone,
                keyboardType: TextInputType.phone,
                prefixIcon: Icons.phone,
                validator: (v) => v == null || v.trim().length < 8
                    ? 'Enter a valid phone number'
                    : null,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue
                  ),
                  onPressed: _saving ? null : _save,
                  child: _saving
                      ? const CircularProgressIndicator(color: Colors.blue)
                      : const Text('Save Changes',
                    style: TextStyle(
                      color: Colors.white
                    ),

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}