import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisan/Driver/Auth/user.dart';
import 'package:kisan/Driver/screens/d_navigation.dart';
import 'package:kisan/owner/configMap.dart';

class DetailPage extends StatelessWidget {
  String v_name;
  String v_rate;
  String v_url;
  String v_use;

  String review;
  String description;
  final Vehicle vehicle;
  DetailPage(
      {Key key,
      this.review,
      this.vehicle,
      this.description,
      this.v_use,
      this.v_url,
      this.v_rate,
      this.v_name});

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
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: Row(
        children: [
          Container(
            height: 15,
            width: 15,
            child: Image.asset('assets/rupees-symbol-png-27187 (1).png'),
          ),
          new Text(
            ": $v_rate",
            style: TextStyle(color: Colors.white60),
          ),
        ],
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 140.0),
        Icon(
          Icons.directions_car,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.white),
        ),
        SizedBox(height: 0.0),
        Text(
          "$v_name",
          style: TextStyle(color: Colors.white, fontSize: 24.0),
        ),
        SizedBox(height: 0.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            Expanded(
                flex: 5,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 15,
                                height: 15,
                                child: Image.asset("assets/star.png")),
                            Container(
                                width: 15,
                                height: 15,
                                child: Image.asset("assets/star.png")),
                            Container(
                                width: 15,
                                height: 15,
                                child: Image.asset("assets/star.png")),
                            Container(
                                width: 15,
                                height: 15,
                                child: Image.asset("assets/star.png")),
                            Container(
                                width: 15,
                                height: 15,
                                child: Image.asset("assets/star.png")),
                          ],
                        ),
                        Text(
                          'Review: $review',
                          //  data['description'] != null
                          //    ? '${data["description"]}'
                          //  : "No data found",
                          //vehicle.v_review,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ))),
            Expanded(
              flex: 2,
              child: Text(
                "Rate",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Expanded(flex: 4, child: coursePrice),
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: NetworkImage('$v_url'),
                // '${UserList[index]['thumbnailUrl']}',

                //  image: AssetImage('assets/TC.png'),
                //image: new AssetImage('$v_url'),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color(0xa3296f0a)
              // Color(0xc9299a0c)
              ), //Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Home()));
              // Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      ' $description',
      style: TextStyle(fontSize: 16.0),
    );
    final readButton = MaterialButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => D_sr(
                  v_name: v_name,
                  v_rate: v_rate,
                  v_review: review,
                )
            //Satelite_GoogleMapPage()
            // GoogleMapPage() //BookEquipment()
            ));
      },
      // color: Color(0xff5b8e0d),
      child: Container(
        height: 45,
        width: 160,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: Color(0xff3B9412)),
        padding: EdgeInsets.only(top: 12, left: 15),
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
          Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0),
            child: Text(
              "Description:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 10,
            width: 90,
            child: Divider(
              thickness: 3,
              color: Color(0xfffa8b17),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          bottomContentText,
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10, left: 0),
            child: Text(
              "Use:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 0,
            width: 60,
            child: Divider(
              thickness: 3,
              color: Color(0xfffa8b17),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            ' $v_use.',
            style: TextStyle(fontSize: 16.0),
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
          SizedBox(
              height: 40,
              //   width: 90,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 50),
                height: 20,
                child: Row(
                  children: [
                    IconButton(
                        iconSize: 15,
                        onPressed: () {
                          bottomContent;
                        },
                        color: Colors.white,
                        icon: Icon(
                          Icons.info_outline,
                          size: 30,
                        )),
                    SizedBox(
                      width: 70,
                    ),
                    IconButton(
                        onPressed: () {
                          readButton;
                        },
                        color: Colors.white,
                        icon: Icon(
                          Icons.work_sharp,
                          size: 30,
                        )),
                    SizedBox(
                      width: 70,
                    ),
                    IconButton(
                        onPressed: () {

                        },
                        color: Colors.white,
                        icon: Icon(
                          Icons.video_collection_rounded,
                          size: 30,
                        ))
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0xffea9103),
                ),
              )),
          bottomContent,
        ],
      ),
    );
  }
}
