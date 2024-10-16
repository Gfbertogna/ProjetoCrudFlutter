import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projetocrud/firebase_options.dart';
import 'package:projetocrud/menu.dart';
import 'cadProduto.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(), // Nova tela HomeScreen
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícone
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset(
                'assets/livro.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 10),

            // Botão para navegar para a tela CadProduto
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
              child: Text('ENTRAR'),
            ),

            SizedBox(height: 10),

            // Botão de SAIR
            ElevatedButton(
              onPressed: () {
                 Navigator.of(context).pop();
              },
              child: Text('SAIR'),
            ),
          ],
        ),
      ),
    );
  }
}
