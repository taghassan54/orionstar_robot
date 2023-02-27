import 'package:flutter/material.dart';

class ModelDataWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const ModelDataWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: data.entries.map((entry) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(entry.key),
            Text(entry.value.toString()),
          ],
        );
      }).toList(),
    );
  }
}
