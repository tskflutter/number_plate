import 'package:flutter/material.dart';

class AnimatedListWidget extends StatefulWidget {
  const AnimatedListWidget({super.key});

  @override
  State<AnimatedListWidget> createState() => _AnimatedListWidgetState();
}

class _AnimatedListWidgetState extends State<AnimatedListWidget> {
  int count = 30;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
    Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AnimatedList(
      key: _listKey,
      initialItemCount: count,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index, animation) {
        return buildItem("Value ${index + 1}", animation); // Build each list item
      },
    );
  }

  Widget buildItem(String item, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: ListTile(
        title: Text(item, style: Theme.of(context).textTheme.titleLarge,), // Display the item's text
        trailing: IconButton(
          icon: const Icon(Icons.delete), onPressed: () {}, // Display a delete icon// Remove the item when pressed
        ),
      ),
    );
  }
}
