import 'package:flutter/material.dart';
import 'package:worknotes/src/models/workspace.dart';

class WorkspaceView extends StatelessWidget {
  static const route = '/workspace/view';

  const WorkspaceView({super.key});

  @override
  Widget build(BuildContext context) {
    final workspace = ModalRoute.of(context)!.settings.arguments as Workspace;
    return Scaffold(
      appBar: AppBar(
        title: Text(workspace.name),
      ),
    );
  }
}
