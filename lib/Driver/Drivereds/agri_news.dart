import 'package:adobe_xd/page_link.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kisan/Driver/Drivereds/d_search.dart';
import 'package:kisan/Driver/Drivereds/news_details.dart';
import 'package:kisan/Driver/screens/d_drawer.dart';
import 'package:kisan/owner/loading.dart';

class Agri_news extends StatefulWidget {
  _Agri_news createState() => _Agri_news();
}

class _Agri_news extends State<Agri_news> {
  CollectionReference agri_ref =
      FirebaseFirestore.instance.collection("news_agri");
  // CollectionReference tractor_ref =
  // FirebaseFirestore.instance.collection("1_vehicle");

  bool enabled = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          height: 790,
          width: 340,
          decoration: BoxDecoration(
            color: const Color(0xff3B9412),
          ),
        ),
        title: Container(
          padding: const EdgeInsets.only(right: 40),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1.5, color: const Color(0xff3B9412)),
            // color: Colors.white,

            image: DecorationImage(
              image: const AssetImage('assets/KC.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        actions: [
          MaterialButton(
              child: Container(
                padding: const EdgeInsets.only(left: 40),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1.5, color: const Color(0xff3B9412)),
                  // color: Colors.white,

                  //image: Icon(Icons.search),
                  //   DecorationImage(image:
                  //const AssetImage('assets/share.png'),fit: BoxFit.cover,
                  //  ),
                ),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) =>
                         Satelite_GoogleMapPage() //GoogleMapPage()
                        //d_search()
                        ));
              }),
          MaterialButton(
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1.5, color: const Color(0xff3B9412)),
                  // color: Colors.white,

                  image: DecorationImage(
                    image: const AssetImage('assets/notification.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, left: 0),
                  child: null,
                ),
              ),
              onPressed: null),
        ],
        centerTitle: true,
        leading: Transform.translate(
          offset: Offset(10.0, 3.0),
          child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.SlideRight,
                  ease: Curves.easeOut,
                  duration: 0.6,
                  pageBuilder: () => d_drawer(),
                ),
              ],
              child: IconButton(
                icon: Icon(
                  Icons.menu_open,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: null,
                //() {
                //Navigator.of(context).push(
                //  MaterialPageRoute(builder: (context) => d_drawer()));
                // },
              )
              //Image.asset('asets/manu.png'),
              ),
        ),

        //IconButton(
        //icon: Icon(Icons.menu_open_sharp, color: Colors.white, size: 37),
        //onPressed: () {
        //Navigator.of(context).push(MaterialPageRoute(
        //settings: SlideRight,
        //  builder: (context) => d_drawer()));
        // },
        //),
      ),
      body: Container(
        child: Row(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: agri_ref.snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      // Vehicle ve_Ref = Vehicle.fromDocument(snapshot.data.);
                      List rev = snapshot.data.docs.toList();
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 10, right: 5),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            //    Vehicle veh = Vehicle.fromDocument(snapshot.data);
                            return Card(
                              // color: Color(0xffefd1a0),
                              child: Container(
                                  height: 100,
                                  width: 220,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 100,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: rev[index]['n_url'] !=
                                                          null
                                                      ? NetworkImage(
                                                          rev[index]['n_url'])
                                                      : Image.asset(
                                                          'assets/TC.png'))),
                                        ),
                                      ),
                                      // Text(rev[index]['n_agri']),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [Flexible(

                                            flex:20,
                                              child: MaterialButton(
                                                focusColor: Colors.green,
                                                onPressed: () {
                                                  setState() {
                                                    enabled = true;
                                                  }

                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  News_DetailPage(
                                                                    n_hadline: rev[
                                                                            index]
                                                                        [
                                                                        'n_hadline'],
                                                                    n_date: rev[
                                                                            index]
                                                                        [
                                                                        'n_date'],
                                                                    n_agri: rev[
                                                                            index]
                                                                        [
                                                                        'n_agri'],
                                                                    n_url: rev[
                                                                            index]
                                                                        [
                                                                        'n_url'],
                                                                  )));
                                                },
                                                child: Text(
                                                    "${rev[index]['n_hadline']}",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                    )),
                                              ),
                                            ),
                                            SizedBox(height: 32),
                                          Flexible(
                                            flex:10,
                                                child: Text(
                                              "Posted: ${rev[index]['n_date']}",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11,
                                              ),
                                            )),
                                            SizedBox(
                                              height: 0,
                                            ),

                                            //  Text('${rev[index]['n_agri']}'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            );
                          },
                          itemCount: snapshot.data.docs.length,
                          // controller: null,
                        ),
                      );
                    }

                    return Loading();
                    //Text(" no Data");
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
