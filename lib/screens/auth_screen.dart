import 'package:flutter/material.dart';
import 'package:tak_gg/screens/home_screen.dart';
import 'package:tak_gg/services/api_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String token = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/takgg_icon_rdbox.png'),
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 32),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Token',
                hintText: 'Enter your token',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 1, color: Colors.redAccent),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  token = value;
                });
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                onPressed: token == ''
                    ? null
                    : () async {
                        try {
                          await ApiService.postAuthRequest(token);

                          if (!mounted) return;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        } catch (e) {
                          print('error:$e');
                        }
                      },
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
