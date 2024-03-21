import 'package:flutter/material.dart';
import 'package:notes_app_prototype/src/note/note_details_page.dart';
import 'package:notes_app_prototype/src/note/note_model.dart';
import 'package:notes_app_prototype/src/note/note_service.dart';

enum NoteActions { edit, delete, clone }

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late Future<List<NoteModel>> futureNotes = NoteService.getNotes();
  bool canPush = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notas usuário XXXX'),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (canPush) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NoteDetailsPage(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      'A API ainda não acordou, volte mais tarde! 😴'), //little humor for the user
                ));
              }
            },
            child: const Icon(Icons.add),
          ),
          ElevatedButton(
            onPressed: () {
              if (canPush) {
                setState(() {});
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      'A API ainda não acordou, volte mais tarde! 😴'), //little humor for the user
                ));
              }
            },
            child: const Icon(Icons.refresh),
          )
        ],
      ),
      body: FutureBuilder(
          future: futureNotes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<NoteModel> data = snapshot.data as List<NoteModel>;
              canPush = true;
              return NotesWidget(items: data);
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Carregando dados...',
                      style: TextStyle(fontSize: 24),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}

class NotesWidget extends StatelessWidget {
  final List<NoteModel> items;
  //if initialized like items = [], couldn't be final.
  const NotesWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return SizedBox(
          //TODO make SizedBox adjust to content size
          height: MediaQuery.of(context).size.height * 0.30,
          width: MediaQuery.of(context).size.width * 0.20,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Criado em: ${items[index].createdAt.day}/${items[index].createdAt.month}/${items[index].createdAt.year} às ${items[index].createdAt.hour}h${items[index].createdAt.minute}min',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Última edição: ${items[index].lastEdited.day}/${items[index].lastEdited.month}/${items[index].lastEdited.year} às ${items[index].createdAt.hour}h${items[index].createdAt.minute}min',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: PopupMenuButton<NoteActions>(
                            onSelected: (NoteActions action) {
                              switch (action) {
                                case NoteActions.edit:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NoteDetailsPage(note: items[index]),
                                    ),
                                  );
                                  break;
                                case NoteActions.delete:
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext builder) =>
                                        AlertDialog(
                                      title: const Text('Confirmar exclusão'),
                                      content: const Text(
                                          'Deseja realmente  excluir a nota? \n(Essa ação não pode ser desfeita)'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Não'),
                                          onPressed: () =>
                                              Navigator.pop(context, 'Não'),
                                        ),
                                        TextButton(
                                            child: const Text('Sim'),
                                            onPressed: () {
                                              NoteService.removeNote(
                                                  items[index].id!);
                                              Navigator.pop(context, 'Sim');
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text('Nota excluída'),
                                              ));
                                            }),
                                      ],
                                    ),
                                  );
                                  break;
                                case NoteActions.clone:
                                  NoteService.addNote(
                                      NoteModel(content: items[index].content));
                                  break;
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuItem<NoteActions>>[
                                  PopupMenuItem(
                                    value: NoteActions.edit,
                                    child: Row(
                                      children: [
                                        IconButton(
                                            icon:
                                                const Icon(Icons.edit_outlined),
                                            onPressed: () {}),
                                        const SizedBox(width: 4),
                                        const Text(
                                          'Editar',
                                          style: TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: NoteActions.delete,
                                    child: Row(
                                      children: [
                                        IconButton(
                                            icon: const Icon(
                                                Icons.delete_outline),
                                            onPressed: () {}),
                                        const SizedBox(width: 4),
                                        const Text(
                                          'Excluir',
                                          style: TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: NoteActions.clone,
                                    child: Row(
                                      children: [
                                        IconButton(
                                            icon: const Icon(
                                                Icons.content_copy_outlined),
                                            onPressed: () {}),
                                        const SizedBox(width: 4),
                                        const Text(
                                          "Duplicar",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      items[index].content.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'ID: ${items[index].id}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
