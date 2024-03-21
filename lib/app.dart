import 'package:flutter/material.dart';
import 'package:notes_app_prototype/src/note/note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Teste de notas'), backgroundColor: Colors.green),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotePage(),
                ),
              );
            },
            child: const Text('Acessar Notas'),
          ),
        ),
      ),
    );
  }
}
