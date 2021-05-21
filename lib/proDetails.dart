import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class MyHomePages extends StatefulWidget {
  MyHomePages({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePages> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ListView(
          children: <Widget>[
            new MHeader(),
            favnprice,
            divider,
            new Mfooter(),
            bottomBtns
          ],
        ));
  }
}



var _appbar = new Align(
  heightFactor: 0.35,
  child: new Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      new Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: new IconButton(
            icon: new Icon(
              CustomIcons.menu,
              color: Colors.black87,
            ),
            onPressed: () {
              print("menu Clicked");
            },
            splashColor: Colors.black,
          )),
      new Expanded(
        child: new Container(),
      ),
      new Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: new Icon(
          Icons.shopping_cart,
          color: Colors.black87,
        ),
      )
    ],
  ),
);

var content = new Container(
  margin: new EdgeInsets.only(top: 30.0),
  child: new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Image(
          width: 140.0,
          height: 140.0,
          image: new AssetImage("assets/googlehome.png"),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Container(
                width: 70.0,
                height: 30.0,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    new BorderRadius.all(new Radius.circular(30.0)),
                    boxShadow: <BoxShadow>[
                      new BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          offset: new Offset(0.0, 10.0))
                    ]),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    new Text("4.8")
                  ],
                ),
              ),
              new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text('Google Home',
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal)),
                    new Padding(
                      padding: const EdgeInsets.only(left: 28.0, top: 12.0),
                      child: new Text("Google LLC",
                          style: new TextStyle(
                            color: Colors.black87.withOpacity(.3),
                          )),
                    ),
                  ]),
              new Container(
                width: 60.0,
                height: 60.0,
                decoration: new BoxDecoration(
                    gradient: btnGradient,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      new BoxShadow(
                          blurRadius: 10.0,
                          color: Colors.black12,
                          offset: new Offset(0.0, 10.0))
                    ]),
                child: new Icon(
                  Icons.share,
                  size: 25.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )
      ]),
);



class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height / 2 + 30);

    var firstControlPoint = new Offset(size.width / 5, size.height);
    var firstPoint = new Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);
    var secondControlPoint =
    new Offset(size.width - (size.width / 5), size.height);
    var secondPoint = new Offset(size.width, size.height / 2 + 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

var favnprice = new Padding(
  padding:
  const EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0, bottom: 12.0),
  child: new Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      new Row(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
          new Text("Add to wishList")
        ],
      ),
      new Row(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(
              "\$",
              style: new TextStyle(fontSize: 20.0),
            ),
          ),
          new Text(
            "9999.00",
            style: new TextStyle(fontSize: 35.0),
          )
        ],
      )
    ],
  ),
);

var divider = new Divider();

var bottomBtns = new Padding(
  padding: const EdgeInsets.symmetric(horizontal: 30.0),
  child: new Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      new Expanded(
        child: new InkWell(
          onTap: () {},
          child: new ClipRRect(
            borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
            child: new Container(
              decoration: new BoxDecoration(
                  gradient: btnGradient,
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                        blurRadius: 10.0,
                        color: Colors.black12,
                        offset: new Offset(0.0, 10.0))
                  ]),
              height: 60.0,
              child: new Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: new Center(
                  child: new Text(
                    "Buy Now",
                    style: new TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      new Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Container(
          width: 60.0,
          height: 60.0,
          decoration: new BoxDecoration(
              gradient: btnGradient,
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                new BoxShadow(
                    blurRadius: 10.0,
                    color: Colors.black12,
                    offset: new Offset(0.0, 10.0))
              ]),
          child: new Icon(
            Icons.add_shopping_cart,
            size: 25.0,
            color: Colors.white,
          ),
        ),
      )
    ],
  ),
);

class Mfooter extends StatefulWidget {
  @override
  _MfooterState createState() => new _MfooterState();
}

class _MfooterState extends State<Mfooter> with SingleTickerProviderStateMixin {
  List<Tab> _tabs;
  List<Widget> _pages;
  static TabController _controller;
  @override
  void initState() {
    super.initState();

    _tabs = [
      new Tab(
        child: new Text(
          "Product Description",
          style: new TextStyle(color: Colors.black),
        ),
      ),
      new Tab(
        child: new Text(
          "specification",
          style: new TextStyle(color: Colors.black),
        ),
      ),
      new Tab(
        child: new Text(
          "user reviews",
          style: new TextStyle(color: Colors.black),
        ),
      ),
    ];
    _pages = [new ProductDesc(), new Specification(), new UserReview()];
    _controller = new TabController(
      length: _tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new TabBar(
          isScrollable: true,
          controller: _controller,
          tabs: _tabs,
          indicatorColor: Colors.white,
        ),
        new Divider(
          height: 1.0,
        ),
        new SizedBox.fromSize(
          size: const Size.fromHeight(220.0),
          child: new TabBarView(
            controller: _controller,
            children: _pages,
          ),
        ),
      ],
    );
  }
}


var bgGradient = new LinearGradient(
  colors: [const Color(0xFF1533e8), const Color(0xFF153285)],
  tileMode: TileMode.clamp,
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  stops: [0.0, 1.0],
);

var btnGradient = new LinearGradient(
  colors: [const Color(0xFF37ecba), const Color(0xFF72afd3)],
  tileMode: TileMode.clamp,
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  stops: [0.0, 1.0],
);


class CustomIcons {
  static const IconData menu = const IconData(0xe901, fontFamily: "CustomFont");
}



class MHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 280.0,
      child: new Stack(
        children: <Widget>[
          new ClipPath(
            clipper: new ArcClipper(),
            child: new Container(
              height: double.infinity,
              decoration: new BoxDecoration(gradient: bgGradient),
            ),
          ),
          new Align(
            alignment: FractionalOffset.center,
            heightFactor: 3.5,
            child: content,
          ),
          _appbar
        ],
      ),
    );
  }
}

class UserReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Padding(
        padding: const EdgeInsets.all(14.0),
        child: new Center(
          child: new Text("User Reviews"),
        ),
      ),
    );
  }
}
class Specification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text("Specification"),
      ),
    );
  }
}
class ProductDesc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Padding(
        padding: const EdgeInsets.all(14.0),
        child: new Text(
          "A smart Personal assistant at your beck and call, who makes doing your everyday tasks"
              "easier - isn't that the dream? whether it it managing your calendar, playing music, or "
              "controlling your home entertainment, these can all be done by the Google Home - all you have to do is say "
              "\"Ok Google\" \n\n you can know the status of real-time information such as the current weather, important news,"
              "match dates and scores of your favourite sports team and much more by using your voice.",
          style: new TextStyle(
              fontFamily: "OpenSans",
              color: Colors.black,
              fontSize: 13.0,
              fontWeight: FontWeight.w200),
        ),
      ),
    );
  }
}