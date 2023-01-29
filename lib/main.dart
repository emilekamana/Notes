import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: Colors.amberAccent.shade200.withOpacity(0.5),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String input = "";

  List notes = [];

  @override
  void initState() {
    // notes.add('value');
    // notes.add('value');
    // notes.add('value');
    super.initState();
  }

  deleteNote(index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  clearNotes() {
    setState(() {
      notes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.amber,
          title: const Text(
            'NOTESBOOK',
            style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w700,
                letterSpacing: 2),
          )),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 248, 221, 125),
        child: ListView(
          children: [
            const ListTile(
              tileColor: Colors.amber,
              title: Text(
                'Menu',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700),
              ),
            ),
            ListTile(
              title: const Text(
                "Delete all notes",
                style: TextStyle(color: Colors.red),
              ),
              trailing: const Icon(
                FontAwesomeIcons.trash,
                color: Colors.red,
              ),
              onTap: () {
                clearNotes();
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 248, 221, 125),
                  title: const Text('New note'),
                  titleTextStyle: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 24),
                  content: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Write here',
                    ),
                    onChanged: (value) {
                      input = value;
                    },
                  ),
                  actions: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            padding: const EdgeInsets.all(20),
                          ),
                          onPressed: () {
                            setState(() {
                              notes.add(input);
                            });
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Create note',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                                fontSize: 24),
                          )),
                    ),
                  ],
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: notes.isEmpty
          ? Container(
              // padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              width: double.infinity,
              // color: Colors.red,
              child: FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Image(image: AssetImage('assets/blind.png')),
                    Text(
                      "No notes added yet!",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 32),
                    ),
                    RotatedBox(
                      quarterTurns: 2,
                      child: Padding( padding: EdgeInsets.fromLTRB(0, 0, 200, 0), child: Icon(Icons.arrow_back, size: 200, color: Colors.amber,))),
                  ],
                ),
              ),
            )
          : Container(
              // color: Colors.green,
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: GridView.builder(
                  itemCount: notes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return ConstrainedBox(
                        constraints: const BoxConstraints(
                            maxHeight: 200,
                            maxWidth: 200,
                            minHeight: 100,
                            minWidth: 100),
                        child: Card(
                          elevation: 4,
                          color: const Color.fromARGB(255, 248, 221, 125),
                          child: Stack(
                            children: [
                              Positioned(
                                  top: 2.0,
                                  right: 2.0,
                                  child: PopUpOptionMenu(
                                      deleteNote: deleteNote, index: index)),
                              Center(child: Text(notes[index])),
                            ],
                          ),
                        ));
                  }),
            ),
    ));
  }
}

enum MenuOptions { Delete, Edit }

class PopUpOptionMenu extends StatelessWidget {
  final index;
  final deleteNote;
  const PopUpOptionMenu({super.key, this.deleteNote, this.index});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopupMenuButton<MenuOptions>(
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<MenuOptions>>[
          PopupMenuItem(
            value: MenuOptions.Delete,
            child: FittedBox(
                child: Row(
              children: const [
                Icon(FontAwesomeIcons.trash),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Text('Delete'),
                ),
              ],
            )),
          ),
          const PopupMenuItem(
            child: Text('Edit'),
            value: MenuOptions.Edit,
          )
        ];
      },
      onSelected: (value) {
        switch (value) {
          case MenuOptions.Delete:
            // TODO: Handle this case.
            deleteNote(index);
            break;
          case MenuOptions.Edit:
            // TODO: Handle this case.
            break;
        }
      },
    );
  }
}
