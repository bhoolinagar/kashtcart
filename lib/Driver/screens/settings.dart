import 'package:flutter/material.dart';
import 'package:kisan/Driver/Auth/assistants/langauge_change_provider.dart';
import 'package:kisan/generated/l10n.dart';
import "package:map_polyline_draw/map_polyline_draw.dart";
import 'package:provider/provider.dart';

class settings extends StatefulWidget {
  _Settings createState() => _Settings();
}

class _Settings extends State<settings> {
  bool _isRadio = false;
  bool _isEnglish = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff3B9412),
        title: Text(S.of(context).language),
      ),
      backgroundColor: const Color(0xffffffff),
      body: Container(
        padding: const EdgeInsets.only(top: 40, left: 20),
        child: Column(
          children: [
            //   Text(S.of(context).brand),
            RadioListTile(
              groupValue: _isRadio ? false : true,
              value: false,
              title: Text(
                S.of(context).hindi,
                style: TextStyle(fontSize: 16),
              ),
              activeColor: const Color(0xff179C18),
              onChanged: (val) {
                setState(() {
                  context.read<LangaugesChangeProvider>().changeLocale("hi");
                  _isEnglish = false;
                  _isRadio = !_isRadio;
                });
              },
            ),
            RadioListTile(
              groupValue: _isEnglish ? false : true,
              value: false,
              title: Text(
                S.of(context).english,
                style: TextStyle(fontSize: 16),
              ),
              activeColor: const Color(0xff179C18),
              onChanged: (val) {
                setState(() {
                  context.read<LangaugesChangeProvider>().changeLocale("en");
                  _isRadio = false;
                  _isEnglish = !_isEnglish;
                });
              },
            ),
            //     Text(S.of(context).language_choice)
          ],
        ),
      ),
    );
  }
}

class ProfileHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ProfileHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Search"), backgroundColor: Colors.green),
        body: Column(
          children: [
            Expanded(
                child: MapPolyLineDraw(
              apiKey: "AIzaSyBSSwP3xczNQ8-HxPU9--NTmvL2D13LsJc",
              firstPoint: MapPoint(23.593750, 77.0965629),
              secondPoint: MapPoint(23.5910530, 77.09652237),
            )),
            Divider(
              color: Colors.green,
              height: 2,
            ),
            Expanded(child: Text("ram"))
          ],
        ));
  }
}

const String _svg_fwtoav =
    '<svg viewBox="13.6 64.5 1.0 1.0" ><path transform="matrix(0.707107, 0.707107, -0.707107, 0.707107, 13.57, 64.46)" d="M 3.081283921346767e-07 1.037626589095453e-07 L 4.208725385979051e-06 1.688213956185791e-06 C 4.398804776428733e-06 1.765425736266479e-06 4.615485977410572e-06 1.982107278308831e-06 4.692697984864935e-06 2.172187578253215e-06 C 4.769911811308702e-06 2.36226833294495e-06 4.678412096836837e-06 2.45376531893271e-06 4.488333161134506e-06 2.376553766225697e-06 L 5.877374178453465e-07 7.921033784441533e-07 C 3.976573452746379e-07 7.148913709897897e-07 1.809745526770712e-07 4.982089194527362e-07 1.037628862832207e-07 3.08129074255703e-07 C 2.655076514201937e-08 1.180486606244813e-07 1.180485469376436e-07 2.655099251569482e-08 3.081283921346767e-07 1.037626589095453e-07 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 13.57, 64.46)" d="M 2.57139191717215e-07 2.680207217053976e-06 L 4.15773365602945e-06 1.095758307201322e-06 C 4.347813046479132e-06 1.018546186060121e-06 4.439310487214243e-06 1.11004419522942e-06 4.362099844001932e-06 1.300123471992265e-06 C 4.284888291294919e-06 1.490203544562974e-06 4.068205726071028e-06 1.706885882413189e-06 3.878124971379293e-06 1.784098230928066e-06 L -2.246985175702321e-08 3.368547822901746e-06 C -2.125497928773257e-07 3.44575983035611e-06 -3.040474041426933e-07 3.354262162247323e-06 -2.268354677426032e-07 3.164181862302939e-06 C -1.496237018727697e-07 2.974102244479582e-06 6.705916177907056e-08 2.757419451882015e-06 2.57139191717215e-07 2.680207217053976e-06 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_p9agsq =
    '<svg viewBox="13.6 50.5 1.0 1.0" ><path transform="matrix(0.707107, 0.707107, -0.707107, 0.707107, 13.57, 50.51)" d="M 3.081277100136504e-07 1.037625949606991e-07 L 4.208746304357192e-06 1.688243060016248e-06 C 4.398826604301576e-06 1.765456090652151e-06 4.61551053376752e-06 1.98214024749177e-06 4.692723905463936e-06 2.172221229557181e-06 C 4.769938641402405e-06 2.362302666369942e-06 4.678440745919943e-06 2.453800107105053e-06 4.488358626986155e-06 2.376586280661286e-06 L 5.877419084754365e-07 7.92107186953217e-07 C 3.976606706146413e-07 7.14893701569963e-07 1.809758316539956e-07 4.982090899829927e-07 1.037628152289471e-07 3.081283352912578e-07 C 2.654931741119526e-08 1.180468416350777e-07 1.18046628472257e-07 2.654922504063961e-08 3.081277100136504e-07 1.037625949606991e-07 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 13.57, 50.51)" d="M 2.57134502135159e-07 2.680263833099161e-06 L 4.157750026934082e-06 1.095785705729213e-06 C 4.347832145867869e-06 1.018571992972284e-06 4.439327767613577e-06 1.110070115828421e-06 4.362116669653915e-06 1.30015018839913e-06 C 4.284902843210148e-06 1.490231397838215e-06 4.068218458996853e-06 1.706916009425186e-06 3.878137249557767e-06 1.784129153747926e-06 L -2.247967856305877e-08 3.368608304299414e-06 C -2.1256080628973e-07 3.445822130743181e-06 -3.040581191271485e-07 3.35432469000807e-06 -2.268447332198775e-07 3.164243025821634e-06 C -1.496315320537178e-07 2.974162498503574e-06 6.705337796120148e-08 2.757477432169253e-06 2.57134502135159e-07 2.680263833099161e-06 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
