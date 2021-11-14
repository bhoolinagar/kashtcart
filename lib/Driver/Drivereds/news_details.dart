import 'package:flutter/material.dart';
import 'package:kisan/Driver/Drivereds/agri_news.dart';
import 'package:kisan/farmer/book_vehicle.dart';

class News_DetailPage extends StatelessWidget {
  String n_hadline;
  String n_agri;
  String n_url;
  String n_date;
  //String description;

  News_DetailPage(
      {Key key, this.n_hadline, this.n_agri, this.n_url, this.n_date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final levelIndicator = Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
            // value: ,
            valueColor: AlwaysStoppedAnimation(Colors.green)),
      ),
    );

    final coursePrice = Container(
      padding: const EdgeInsets.all(5.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: Row(
        children: [
          //Container(
          //height: 15,
          //   width: 15,
          // child: Image.asset('assets/rupees-symbol-png-27187 (1).png'),
          ///),
          new Text(
            "Posted on : $n_date",
            style: TextStyle(fontSize: 12, color: Colors.white60),
          ),
        ],
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Icon(
        // Icons.directions_car,
        //color: Colors.white,
        // size: 40.0,
        //),

        SizedBox(height: 150),
        Container(
          width: 90.0,
          child: new Divider(thickness: 2, color: Colors.white),
        ),
        SizedBox(height: 0.0),
        Text(
          "$n_hadline",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17.0),
        ),
        SizedBox(height: 0.0),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: NetworkImage('$n_url'),
                // '${UserList[index]['thumbnailUrl']}',

                //  image: AssetImage('assets/TC.png'),
                //image: new AssetImage('$v_url'),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
          padding: EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color(0x7a296f0a)
              // Color(0xc9299a0c)
              ), //Color.fromRGBO(58, 66, 86, .9)),
          child: Expanded(
            flex: 4,
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Agri_news()));
              // Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      ' $n_agri',
      style: TextStyle(fontSize: 16.0),
    );
    final readButton = MaterialButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BookEquipment()));
      },
      // color: Color(0xff5b8e0d),
      child: Container(
        height: 45,
        width: 140,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: Color(0xff3B9412)),
        padding: EdgeInsets.only(top: 10, left: 15),
        // width: MediaQuery.of(context).size.width,
        child: Text("BOOK VEHICLE",
            style: TextStyle(fontSize: 14, color: Colors.white)),
      ),
    );
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          bottomContentText,
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 30,
          ),
          readButton
        ],
      ),
    );

    return Scaffold(
      body: ListView(
        children: <Widget>[
          topContent,
          Container(
            padding: const EdgeInsets.all(5.0),
            decoration: new BoxDecoration(
                border: new Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(5.0)),
            child: new Text(
              "Posted on : $n_date",
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ),
          SizedBox(height: 2
              //   width: 90,
              ),
          bottomContent,
        ],
      ),
    );
  }
}
