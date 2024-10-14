import 'package:cnattendance/provider/dashboardprovider.dart';
import 'package:cnattendance/screen/awards/awardsscreen.dart';
import 'package:cnattendance/screen/dashboard/projectscreen.dart';
import 'package:cnattendance/screen/profile/holidayscreen.dart';
import 'package:flutter/material.dart';
import 'package:cnattendance/widget/homescreen/cardoverview.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

class OverviewDashboard extends StatelessWidget {
  PersistentTabController controller;

  OverviewDashboard(this.controller);

  @override
  Widget build(BuildContext context) {
    final _overview = Provider.of<DashboardProvider>(context).overviewList;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            translate('home_screen.overview'),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardOverView(
                type: translate('home_screen.present'),
                value: _overview['present']!,
                icon: "assets/icons/present_icon.png",
                callback: () {
                  controller.jumpToTab(2);
                },
              ),
              CardOverView(
                type: translate('home_screen.holidays'),
                value: _overview['holiday']!,
                icon: Icons.celebration,
                callback: () {
                  pushScreen(context,
                      screen: HolidayScreen(),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.fade);
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardOverView(
                type: translate('home_screen.leave'),
                value: _overview['leave']!,
                icon: Icons.sick,
                callback: () {
                  controller.jumpToTab(1);
                },
              ),
              CardOverView(
                type: translate('home_screen.request'),
                value: _overview['request']!,
                icon: Icons.pending,
                callback: () {
                  controller.jumpToTab(1);
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardOverView(
                type: translate('home_screen.projects'),
                value: _overview['total_project']!,
                icon: Icons.work_history_outlined,
                callback: () {
                  pushScreen(context,
                      screen: ProjectScreen(),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.fade);
                },
              ),
              CardOverView(
                type: translate('home_screen.task'),
                value: _overview['total_task']!,
                icon: Icons.outlined_flag_sharp,
                callback: () {
                  pushScreen(context,
                      screen: ProjectScreen(),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.fade);
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardOverView(
                type: translate('home_screen.awards'),
                value: _overview['total_awards']!,
                icon: Icons.workspace_premium_outlined,
                callback: () {
                  pushScreen(context,
                      screen: AwardsScreen(),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.fade);
                },
              ),
              Spacer()
              /*CardOverView(
                type: translate('home_screen.training'),
                value: _overview['active_training']!,
                icon: Icons.model_training_rounded,
                callback: () {
                  pushNewScreen(context,
                      screen: TrainingScreen(),
                      withNavBar: true,
                      pageTransitionAnimation: PageTransitionAnimation.fade);
                },
              )*/
            ],
          ),
        ],
      ),
    );
  }
}
