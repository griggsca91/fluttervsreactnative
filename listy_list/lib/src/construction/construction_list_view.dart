import 'package:flutter/material.dart';

class ConstructionListView extends StatelessWidget {
  const ConstructionListView({super.key});

  @override
  Widget build(Object context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int index) {
        return Card(
            child: ListTile(
          title: Text("Index $index"),
        ));
      },
      itemCount: 20,
    );
  }
}

const constructionSites = [];

class Construction {
  const Construction(
    this.displayName,
    this.location,
    this.startDate,
    this.endDate,
  );

  final String displayName;
  final String location;
  final DateTime? startDate;
  final DateTime? endDate;
}
