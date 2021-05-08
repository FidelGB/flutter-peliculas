import 'package:peliculas/src/widgets/card_swipper_widget.dart';
import 'package:flutter/material.dart'; 


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Peliculas"),
          backgroundColor: Colors.red,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){}
            )
          ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            CardSwiper(items: [1,2,3,4,5])
          ],
        ),
      ),
    );
  }

}