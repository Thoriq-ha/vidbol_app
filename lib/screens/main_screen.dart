import 'package:flutter/material.dart';
import 'package:vidbol_app/bloc/home/home_bloc.dart';
import 'package:vidbol_app/bloc/home/home_event.dart';
import 'package:vidbol_app/const.dart';
import 'package:vidbol_app/repository/data_repository.dart';

import 'tabs/account_tab_page.dart';
import 'tabs/home_tab_page.dart';
import 'tabs/search_tab_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  HomeBloc? _homeBloc;
  // late List<FootballData> footballData;

  @override
  void initState() {
    _homeBloc = HomeBloc(DataRepository());
    _fetchData();
    super.initState();
  }

  void _fetchData() {
    _homeBloc!.add(GetAll());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: _buildTabBar(context),
          body: buildTabBarView(context),
        ),
      ),
    );
  }

  Widget buildTabBarView(BuildContext context) {
    return TabBarView(
      children: [
        buildHomePageTabWidget(context, _homeBloc!),
        buildAccountPageTabWidget(),
      ],
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 40,
        right: 40,
      ),
      child: TabBar(
        labelColor: mColorOren,
        unselectedLabelColor: mColorGrey,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: mColorOren,
        tabs: [
          Tab(
            icon: Image.asset('assets/img/ic_home.png'),
            text: 'Home',
          ),
          Tab(
            icon: Image.asset('assets/img/ic_about_us.png'),
            text: 'About Us',
          ),
        ],
      ),
    );
  }
}
