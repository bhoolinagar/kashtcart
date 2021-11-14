import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class d_done extends StatelessWidget {
  d_done({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(0.0, 10.0),
            child: SizedBox(
              width: 402.0,
              height: 518.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 402.0, 518.0),
                    size: Size(402.0, 518.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 3.0, color: const Color(0xff707070)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 20),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(35.0, 22.0, 286.0, 44.0),
                    size: Size(402.0, 518.0),
                    pinLeft: true,
                    pinTop: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      '1. Ramchandra \nvehicle type: Tractor with cultiwator',
                      style: TextStyle(
                        fontFamily: 'Tahoma',
                        fontSize: 18,
                        color: const Color(0xff666666),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(27.0, 252.0, 266.0, 46.0),
                    size: Size(402.0, 518.0),
                    pinLeft: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'Time: 10/ 08/2020 at 12:30 AM\nAddress: bilwa,465667',
                      style: TextStyle(
                        fontFamily: 'Tahoma',
                        fontSize: 19,
                        color: const Color(0xff666666),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(34.0, 374.0, 151.0, 29.0),
                    size: Size(402.0, 518.0),
                    pinLeft: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'Amount: 1200',
                      style: TextStyle(
                        fontFamily: 'Tahoma',
                        fontSize: 24,
                        color: const Color(0xff666666),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(35.0, 334.0, 71.0, 22.0),
                    size: Size(402.0, 518.0),
                    pinLeft: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'Statuse: ',
                      style: TextStyle(
                        fontFamily: 'Tahoma',
                        fontSize: 18,
                        color: const Color(0xff666666),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(123.0, 329.0, 62.0, 33.0),
                    size: Size(402.0, 518.0),
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontFamily: 'Tahoma',
                        fontSize: 27,
                        color: const Color(0xff1e9e2a),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(27.0, 163.0, 201.0, 28.0),
                    size: Size(402.0, 518.0),
                    pinLeft: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'Service Id: T10081230',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 21,
                        color: const Color(0xff666666),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(27.0, 209.0, 127.0, 25.0),
                    size: Size(402.0, 518.0),
                    pinLeft: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'Land: 2 Acres',
                      style: TextStyle(
                        fontFamily: 'Tahoma',
                        fontSize: 21,
                        color: const Color(0xff666666),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(29.0, 129.0),
            child: Text(
              'Mobile no: + 91933390257249',
              style: TextStyle(
                fontFamily: 'Tahoma',
                fontSize: 19,
                color: const Color(0xff666666),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(29.0, 88.0),
            child: Text(
              'Email id: bhoolinagar123@gmail.com',
              style: TextStyle(
                fontFamily: 'Tahoma',
                fontSize: 17,
                color: const Color(0xff666666),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(87.0, 447.0),
            child: Container(
              width: 201.0,
              height: 44.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(27.0),
                color: const Color(0xffec4f27),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(160.0, 447.0),
            child: Text(
              'Pay',
              style: TextStyle(
                fontFamily: 'Tahoma',
                fontSize: 35,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
