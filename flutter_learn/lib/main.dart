import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '豆瓣App'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FLStarRating(rating: 5),
      ),
    );
  }
}

class FLStarRating extends StatefulWidget {
  final double rating;
  final double maxRating;
  final int count;
  final double size;
  final Color unselectedColor;
  final Color selectedColor;

  final Widget unSelectedImage;
  final Widget selectedImage;

  FLStarRating({
    @required this.rating,
    this.maxRating = 10,
    this.count = 5,
    this.size = 30,
    this.unselectedColor = const Color(0xffbbbbbb),
    this.selectedColor = Colors.red,
    Widget unSelectedImage,
    Widget selectedImage
  }): unSelectedImage = unSelectedImage ?? Icon(Icons.star_border, color: unselectedColor, size: size),
        selectedImage = selectedImage ?? Icon(Icons.star, color: selectedColor, size: size);

  @override
  _FLStarRatingState createState() => _FLStarRatingState();
}

class _FLStarRatingState extends State<FLStarRating> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: buildUnselectedStar(),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: buildSelectedStar(),
        )
      ],
    );
  }

  List<Widget> buildUnselectedStar() {
    return List.generate(widget.count, (index) {
      return widget.unSelectedImage;
    });
  }

  List<Widget> buildSelectedStar() {
    // 1、创建Stars List
    List<Widget> stars = [];
    final star = widget.selectedImage;

    // 2、创建完整的星星
    int entireCount = (widget.rating/widget.maxRating*widget.count).floor();
    for (var i = 0; i < entireCount; i++) {
      stars.add(star);
    }

    // 3、创建填充的星星
    double leftWidth = ((widget.rating/widget.maxRating*widget.count) - entireCount)*widget.size;
    final halfStar = ClipRect(
      clipper: FLStarClipper(leftWidth),
      child: star,
    );
    stars.add(halfStar);

    return stars;
  }
}

class FLStarClipper extends CustomClipper<Rect> {

  double width;
  FLStarClipper(this.width);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, width, size.height);
  }

  @override
  bool shouldReclip(FLStarClipper oldClipper) {
    return oldClipper.width != width;
  }

}
