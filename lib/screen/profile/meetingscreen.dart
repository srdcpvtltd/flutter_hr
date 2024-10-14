import 'package:cnattendance/provider/meetingprovider.dart';
import 'package:cnattendance/widget/meeting/meetinglistview.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

class MeetingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MeetingState();
}

class MeetingState extends State<MeetingScreen> {
  var initial = true;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    if (initial) {
      getMeetingList();
      initial = false;
    }
    super.didChangeDependencies();
  }

  Future<String> getMeetingList() async {
    setState(() {
      isLoading = true;
      EasyLoading.show(status: translate('loader.loading'),maskType: EasyLoadingMaskType.black);
    });

    await Provider.of<MeetingProvider>(context, listen: false).getMeetingList();

    setState(() {
      isLoading = false;
      EasyLoading.dismiss(animation: true);
    });

    return "Loaded";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return !isLoading;
      },
      child: Container(
        decoration: RadialDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(translate('meeting_list_screen.meeting_detail')),
          ),
          body: RefreshIndicator(
              onRefresh: () {
                Provider.of<MeetingProvider>(context, listen: false).page = 1;
                return getMeetingList();
              },
              child: MeetingListView()),
        ),
      ),
    );
  }
}
