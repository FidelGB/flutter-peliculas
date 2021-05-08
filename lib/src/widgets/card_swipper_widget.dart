import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {

  final List<dynamic> items;

  CardSwiper({ @required this.items });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.5,
          itemBuilder: (BuildContext context,int index){
            return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: 
              Image.network(
              "https://i1.wp.com/codigoespagueti.com/wp-content/uploads/2018/05/pikachu.jpg?resize=1080%2C608&quality=80&ssl=1",
              fit: BoxFit.cover)
            );
          },
          itemCount: items.length,
        ),
    );
  }
}