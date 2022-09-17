import 'package:flutter/material.dart';

class DealOfTheDay extends StatelessWidget {
  const DealOfTheDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: const Text(
          "Deal Of The Day",
          style: TextStyle(fontSize: 20),
        ),
      ),
      Image.network(
        'https://images.unsplash.com/photo-1659536540434-fabeb68f6fa9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=600&q=60',
        height: 235,
        fit: BoxFit.fitHeight,
      ),
      Container(
        padding: const EdgeInsets.only(left: 15),
        alignment: Alignment.topLeft,
        child: const Text(
          "\$100",
          style: TextStyle(fontSize: 18),
        ),
      ),
      Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
        child:
            const Text('Rivaan ', maxLines: 2, overflow: TextOverflow.ellipsis),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1662556224725-48a9d346ffca?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=600&q=60',
              fit: BoxFit.fitWidth,
              width: 100,
              height: 100,
            ),
            Image.network(
              'https://images.unsplash.com/photo-1662556224725-48a9d346ffca?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=600&q=60',
              fit: BoxFit.fitWidth,
              width: 100,
              height: 100,
            ),
            Image.network(
              'https://images.unsplash.com/photo-1662556224725-48a9d346ffca?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=600&q=60',
              fit: BoxFit.fitWidth,
              width: 100,
              height: 100,
            ),
            Image.network(
              'https://images.unsplash.com/photo-1662556224725-48a9d346ffca?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=600&q=60',
              fit: BoxFit.fitWidth,
              width: 100,
              height: 100,
            ),
            Image.network(
              'https://images.unsplash.com/photo-1662556224725-48a9d346ffca?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=600&q=60',
              fit: BoxFit.fitWidth,
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
      Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
        child: Text(
          "See all deals",
          style: TextStyle(color: Colors.cyan[800]),
        ),
      ),
    ]);
  }
}
