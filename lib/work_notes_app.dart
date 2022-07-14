import 'package:flutter/material.dart';

import 'work_space_list.dart';

class WorkNotesApp extends StatelessWidget {
  const WorkNotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkNotes',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const WorkSpaceList(title: 'WorkNotes'),
    );
  }
}
