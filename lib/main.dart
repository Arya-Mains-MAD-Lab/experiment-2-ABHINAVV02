import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class UserData {
  static String username = "admin";
  static String password = "123";
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passController = TextEditingController();
  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  void _login() {
    if (userController.text == UserData.username &&
        passController.text == UserData.password) {
      userController.clear();
      passController.clear();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid Credentials")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: userController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: const Text("Login")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // This is where the magic happens
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangePassPage(),
                  ),
                );
              },
              child: const Text("Forgot Password?"),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Login Successful")));
  }
}

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  final user = TextEditingController();
  final newPass = TextEditingController();
  final newPass2 = TextEditingController();

  @override
  void dispose() {
    user.dispose();
    newPass.dispose();
    newPass2.dispose();
    super.dispose();
  }

  void update() {
    // 1. Check Username FIRST
    if (user.text != UserData.username) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Username does not exist")));
      return;
    }
    // 2. Check if Passwords match SECOND
    if (newPass.text == newPass2.text) {
      UserData.password = newPass2.text;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Password updated!")));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: user,
              decoration: const InputDecoration(labelText: "Enter Username"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: newPass,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Enter New Password",
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: newPass2,
              decoration: const InputDecoration(labelText: "Confirm Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: update,
              child: const Text("Save and Return"),
            ),
          ],
        ),
      ),
    );
  }
}
