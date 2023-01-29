import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {  // Running the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(  // Creating initial app and setting theme color
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
  State<StatefulWidget> createState() => _HomeState();  // creating state since it will be dynamic
}

class _HomeState extends State<Home> {
  String input = "";  // declare variables for the state

  List notes = [];

  @override
  void initState() {
    // notes.add('value');
    // notes.add('value');
    // notes.add('value');
    super.initState();
  }

  deleteNote(index) {  // deleting notes and changing state
    setState(() {
      notes.removeAt(index);
    });
  }

  clearNotes() { // deleting all notes and changing state
    setState(() {
      notes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(  // safe area to prevent overflow with device features
        child: Scaffold(
      appBar: AppBar(  // App bar and styles
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
      drawer: Drawer(  // drawer menu with delete all option
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
            ListTile(  // delete all notes option
              title: const Text(
                "Delete all notes",
                style: TextStyle(color: Colors.red),
              ),
              trailing: const Icon(
                FontAwesomeIcons.trash,  // font awesome Icon
                color: Colors.red,
              ),
              onTap: () {
                clearNotes();
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(  // Button to open dialog box and create new note
        backgroundColor: Colors.amber,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(  // alert dialog for the inputs
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
                    SizedBox(  // sized box to determine size of child
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
        child: const Icon(  // Icon
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: notes.isEmpty // check if list is empty and display message
          ? SizedBox(
              width: double.infinity,
              child: FittedBox(  // Fitted box to prevent overflow
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
                    RotatedBox(  // rotated box to rotate to the right direction
                      quarterTurns: 2,
                      child: Padding( padding: EdgeInsets.fromLTRB(0, 0, 700, 0), child: Icon(Icons.arrow_back, size: 200, color: Colors.amber,))),
                  ],
                ),
              ),
            )
          : Container(  // show all notes created on a grid
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

class PopUpOptionMenu extends StatelessWidget {  // pop up menu for the cards
  final index;
  final deleteNote;
  const PopUpOptionMenu({super.key, this.deleteNote, this.index});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopupMenuButton<MenuOptions>(
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<MenuOptions>>[  // Options for the menu
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
          // const PopupMenuItem(
          //   child: Text('Edit'),
          //   value: MenuOptions.Edit,
          // )
        ];
      },
      onSelected: (value) { // set actions for the menu
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
