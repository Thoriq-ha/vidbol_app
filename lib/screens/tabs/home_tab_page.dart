import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vidbol_app/bloc/home/home_bloc.dart';
import 'package:vidbol_app/bloc/home/home_state.dart';
import 'package:vidbol_app/const.dart';
import 'package:vidbol_app/models/footbal_data.dart';
import 'package:vidbol_app/screens/detail_screen.dart';
import 'package:vidbol_app/screens/login_screen.dart';

Widget buildHomePageTabWidget(BuildContext context, HomeBloc _homeBloc) {
  List<FootballData> footballData = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  String? displayaName = auth.currentUser!.displayName;
  String? photoProfil = auth.currentUser!.photoURL;
  String? email = auth.currentUser!.email;

  print('Cek ${auth.currentUser!.email}');

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

  _showDetail(FootballData footballData) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => DetailScreen(football: footballData),
    ));
  }

  Widget _createDataList() {
    if (footballData.isNotEmpty) {
      return ListView.builder(
          itemCount: (footballData.length > 15) ? 15 : footballData.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: Column(
                children: [
                  Image.network(
                    footballData[index].thumbnail,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, _) {
                      return Container(
                        height: 200,
                        color: Colors.amber,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Whoops!',
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(
                              'Image Cannot Load',
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(footballData[index].title),
                  ),
                  Divider(),
                ],
                // children: [Container()],
              ),
              onTap: () => _showDetail(footballData[index]),
            );
          });
    }
    return Center(
      child: Text('Nothing Data for Now'),
    );
  }

  Widget _isLoading(state) {
    if (state is Loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container();
  }

  //RETURN WIDGET HOME TAB PAGE
  return SingleChildScrollView(
    child: Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(children: [
            Container(
              decoration: new BoxDecoration(
                  color: mColorOren,
                  borderRadius: new BorderRadius.only(
                      bottomLeft: const Radius.circular(30.0),
                      bottomRight: const Radius.circular(30.0))),
              height: 146,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hello',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14)),
                            Text(
                              displayaName != null ? displayaName : 'People',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 28),
                            )
                          ],
                        ),
                        InkWell(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/img/ic_logout.png',
                              ),
                              Text(
                                'Log Out',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          onTap: () {
                            auth.signOut().then((value) => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => LoginScreen())));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 112, 24, 0),
              child: Container(
                child: CircleAvatar(
                  child: (photoProfil != null)
                      ? Text('')
                      : Text(
                          email![0],
                          style: TextStyle(
                              color: mColorOren,
                              fontSize: 36,
                              fontWeight: FontWeight.w500),
                        ),
                  backgroundImage: photoProfil != null
                      ? NetworkImage(photoProfil)
                      : NetworkImage(''),
                ),
                height: 79,
                width: 79,
              ),
            )
          ]),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Container(
                height: 450,
                child: BlocConsumer<HomeBloc, HomeState>(
                  bloc: _homeBloc,
                  listener: (context, state) {
                    if (state is ShowMessage) {
                      _showMessage(state.message);
                    } else if (state is DataLoaded) {
                      print('Loaded');
                      footballData.clear();
                      footballData.addAll(state.footballData);
                    }
                  },
                  builder: (context, state) {
                    return Stack(
                      children: [
                        _createDataList(),
                        _isLoading(state),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
