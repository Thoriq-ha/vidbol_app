import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vidbol_app/bloc/detail/detail_bloc.dart';
import 'package:vidbol_app/bloc/detail/detail_event.dart';
import 'package:vidbol_app/bloc/detail/detail_state.dart';
import 'package:vidbol_app/models/footbal_data.dart';
import 'package:vidbol_app/screens/webview_screen.dart';

import '../const.dart';

class DetailScreen extends StatefulWidget {
  final FootballData football;

  const DetailScreen({Key? key, required this.football}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DetailBloc? _detailBloc;
  FootballData? football;

  @override
  void initState() {
    _detailBloc = DetailBloc(widget.football);
    _fetchData();
    // football =
    super.initState();
  }

  void _fetchData() {
    _detailBloc!.add(GetAll());
  }

  void _showMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: mColorOren,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Widget _createDetail() {
    if (football != null) {
      print('arre arre arre ${football!.competitionUrl}');
      return InkWell(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  decoration: new BoxDecoration(
                      color: mColorOren,
                      borderRadius: new BorderRadius.only(
                          bottomLeft: const Radius.circular(60.0),
                          bottomRight: const Radius.circular(60.0))),
                  height: 330,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 38, 16, 0),
                  child: Container(
                    color: Color.fromRGBO(0, 0, 0, 0),
                    height: 210,
                    child: Center(
                      child: WebviewScaffold(
                        url: Uri.dataFromString(
                          football!.videos.last.embed,
                          mimeType: 'text/html',
                        ).toString(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(42, 262, 42, 0),
                  child: Container(
                    width: 300,
                    height: 100,
                    decoration: BoxDecoration(
                        color: mColorGreySoft,
                        borderRadius:
                            BorderRadius.all(const Radius.circular(30.0))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            football!.title,
                            style: TextStyle(
                                color: mColorOren,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Text("Competition At ${football!.competition}"),
                        Text("${football!.date}"),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 28,
            ),
            Text(
              football!.competition,
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            // Container(
            //   height: 300,
            //   child: WebView(
            //     initialUrl: football!.matchviewUrl,
            //   ),
            //   // child: WebviewScaffold(
            //   //   // url: football!.matchviewUrl,
            //   //   // url: url,
            //   //   withJavascript: false, // run javascript
            //   //   withZoom: false, // if you want the user zoom-in and zoom-out
            //   //   hidden: true,
            //   //   url: "https://www.scorebat.com/embed/matchview/1058740/",
            //   // ),
            // ),
            SizedBox(
              height: 80,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WebviewScreen(
                            url: football!.matchviewUrl,
                          )));
                },
                child: Container(
                    decoration: new BoxDecoration(
                        color: mColorOren,
                        borderRadius: new BorderRadius.all(
                          const Radius.circular(60.0),
                        )),
                    width: 300,
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      'Match View',
                      style: TextStyle(color: Colors.white),
                    )))
          ],
          // children: [Container()],
        ),
        // onTap: () => _showMessage(footballData[index].title),
        // onTap: () => _showDetail(foo),
      );
    }
    return Center(
      child: Text('Nothing Data for Now'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<DetailBloc, DetailState>(
          bloc: _detailBloc,
          listener: (context, state) {
            if (state is ShowMessage) {
              _showMessage(state.message);
            } else if (state is DataLoaded) {
              print('Loaded');
              // footballData.clear();
              football = state.football;
              print(football!.date);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                _createDetail(),

                // _createDataList(),
                // _isLoading(state),
              ],
            );
          },
        ),
      ),
    );
  }
}
