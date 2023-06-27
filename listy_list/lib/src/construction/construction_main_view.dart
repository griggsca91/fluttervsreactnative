import 'package:flutter/material.dart';

import 'construction_list_view.dart';

class ConstructionViewer extends StatelessWidget {
  const ConstructionViewer({super.key});

  static const routeName = '/construction';

  @override
  Widget build(BuildContext context) {
    return const ConstructionListView();
  }
}
