import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class d_Calcultor extends StatefulWidget {
  d_Calcultor({
    Key key,
  }) : super(key: key);
  @override
  d_sevices createState() => d_sevices();
}

class d_sevices extends State<d_Calcultor> {
  TextEditingController Rate = TextEditingController();
  TextEditingController km = TextEditingController();
  TextEditingController Start = TextEditingController();
  TextEditingController End = TextEditingController();
  final timeFormat_s = DateFormat("h:mm a");
  final timeFormat_e = DateFormat("h:mm a");
  String s_a = "00";
  double total = 1.0;
  var s_time = "00";
  var e_time = "00";
//String s_string_time;
  //String e_string_time;

  int diff = 0;

  DateTime date;
  // TimeOfDay time;
  bool _Valid = false;

  int def = 0;
  // = d2.difference(d1);

  int HoursBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return to.difference(from).inMinutes;
  }

  Hours(_) {
    return showDialog(
        context: context,
        builder: (_) {
          return SimpleDialog(
            title: Text("kilo meter"),
            children: [
              TextField(
                controller: km,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.merge_type_outlined,
                    size: 40,
                    color: const Color(0xffe39b1e),
                  ),
                  hintText: "Enter Kilo meter",
                  labelText: "Kilo Meter",
                  // hintText: S.of(context).Enter_name,
                  //labelText: S.of(context).Name,

                  focusColor: Colors.green,
                ),
              ),
              Container(
                width: 300,
                height: 62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  //  color: Colors.purpleAccent.withOpacity(.4)
                ),
                child: TextField(
                  controller: Rate,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter rate",
                    icon: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          // color: const Color(0xff1e9e2a),
                          //  borderRadius: BorderRadius.circular(30)
                          ),
                      child: Image.asset('assets/rupees-symbol-png-27204.png'),
                    ),
                    //Icon(
                    //Icons.monetization_on_sharp,
                    //size: 25,
                    //color: Colors.green.withOpacity(.9),
                    // ),
                    labelText: "Rate",
                    //   errorText: _mobileValid ? null : "Please Enter rate",
                    focusColor: Color(0xff3B9412),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              MaterialButton(
                  child: Container(
                    // margin: const EdgeInsets.only(top: 10, left: 20),
                    width: 130,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xffe78a35),
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Text("Submit",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                  onPressed: () {
                    var Km = double.parse(km.text);
                    var rate = double.parse(Rate.text);
                    setState(() {
                      total = Km * rate;
                      _Valid = true;
                    });
                    Navigator.of(context).pop();
                  }),
              Text("Total : ${total}")
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var diffrence_time;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff3B9412),
        title: Text('Farm Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 5, top: 20, right: 5),
        child: ListView(
          //  mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Choose  Calculator type",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff062a0a),
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      color: _Valid == true
                          ? Color(0xffe78100)
                          : Color(0xff3B9412)),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        _Valid = true;
                      });
                      //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => d_Calcultor()));
                    },
                    child: Text(
                      "Hour",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                ),
                MaterialButton(
                  onPressed: () {
                    Hours(context);
                    setState(() {
                      _Valid = false;
                    });
                  },
                  child: Container(
                    width: 150,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        color: _Valid == false
                            ? Color(0xffe78100)
                            : Color(0xff3B9412)),
                    child: Text(
                      "KM",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              width: 20,
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 200,
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      //   color: Color(0xffc8e5a5)
                    ),
                    child: DateTimeField(
                      controller: Start,
                      format: timeFormat_s,

                      onChanged: (value) {
                        setState(() {
                          s_time = (timeFormat_s.format(value));
                        });
                      },
                      autocorrect: true,
                      //  validator: (val) => val.difference(4)<s_s_time ? "Please select time": null,

                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.access_time,
                            color: Color(0xffe78100),
                            size: 25,
                          ),
                          hintText: 'Start time'),
                      onShowPicker: (context, currentValue) async {
                        final time = await showTimePicker(
                            context: (context),
                            builder: (BuildContext context, Widget child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.light().copyWith(
                                      primary: Color(0xff219628),
                                      onSecondary: Colors.orange),
                                  // primaryColor: Colors.green,
                                ),
                                child: child,
                              );
                            },
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()));

                        return DateTimeField.convert(time);
                      },
                    ),
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: DateTimeField(
                    controller: End,
                    format: timeFormat_e,
                    autocorrect: true,
                    //  validator: (val) => val.difference(4)<s_s_time ? "Please select time": null,

                    onChanged: (value) {
                      setState(() {
                        e_time = (timeFormat_e.format(value));
                      });
                    },
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.access_time,
                          color: Color(0xffe78100),
                          size: 25,
                        ),
                        hintText: 'End time'),
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                          context: (context),
                          builder: (BuildContext context, Widget child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.light().copyWith(
                                    primary: Color(0xff219628),
                                    onSecondary: Colors.orange),
                                // primaryColor: Colors.green,
                              ),
                              child: child,
                            );
                          },
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()));
                      return DateTimeField.convert(time);
                    },
                  ),
                ),
              ],
            ),

            ///  MaterialButton(
            //   child: Text("Difference time"),
            // onPressed: () {
            // setState(() {
            //  if (s_time.isNotEmpty && e_time.isNotEmpty) {
            // DateTime parsedstartDateTime =
            //   timeFormat_e.parse("${s_time}");
            //    var parsedendDateTime=   timeFormat_e;
            //         DateTime parsedendDateTime =
            //           timeFormat_e.parse("${e_time}");

            // HoursBetween(parsedstartDateTime, parsedendDateTime);
            //   int diffrence =
            //         HoursBetween(parsedstartDateTime, parsedendDateTime);

            // diff = diffrence.toString();
            // diff
            // int r = parsedendDateTime
            //   .difference(parsedstartDateTime)
            // .inSeconds;
            //      double m = r / (60);

            //        double g = m / 60;
            //     m = m % 60;
            //   int s = r % 60;

            //     .toString();
            //   def = diffrence as Duration;
            //    }

            // diff = g.toInt();
            //           def = m.toInt();
            //         s_a = s.toString();
            //       });
            //     }),
            SizedBox(
              height: 20,
            ),

            Container(
              width: 300,
              height: 62,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                //  color: Colors.purpleAccent.withOpacity(.4)
              ),
              child: TextField(
                controller: Rate,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter rate",
                  icon: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        // color: const Color(0xff1e9e2a),
                        //  borderRadius: BorderRadius.circular(30)
                        ),
                    child: Image.asset('assets/rupees-symbol-png-27204.png'),
                  ),
                  //Icon(
                  //Icons.monetization_on_sharp,
                  //size: 25,
                  //color: Colors.green.withOpacity(.9),
                  // ),
                  labelText: "Rate",
                  //   errorText: _mobileValid ? null : "Please Enter rate",
                  focusColor: Color(0xff3B9412),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            MaterialButton(
                child: Container(
                  // margin: const EdgeInsets.only(top: 10, left: 20),
                  width: 130,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xffe78100),
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Text("Submit",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    DateTime parsedstartDateTime =
                        timeFormat_e.parse("${s_time}");
                    //    var parsedendDateTime=   timeFormat_e;
                    DateTime parsedendDateTime =
                        timeFormat_e.parse("${e_time}");

                    int r = parsedendDateTime
                        .difference(parsedstartDateTime)
                        .inSeconds;
                    double m = r / (60);

                    double g = m / 60;
                    m = m % 60;
                    int s = r % 60;
                    diff = g.toInt();
                    def = m.toInt();
                    s_a = s.toString();
                    double R = double.parse(Rate.text);

                    total = R * diff + ((R * def) / 60);
                  });
                  //  Navigator.of(context).pop();
                }),
            SizedBox(height: 20),
            Text("Total Rupay:  ${total}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            SizedBox(
              height: 20,
            ),
            Text("Total Time:  ${diff}: ${def}: ${s_a} ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
