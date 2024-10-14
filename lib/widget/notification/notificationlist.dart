import 'package:cnattendance/provider/notificationprovider.dart';
import 'package:cnattendance/widget/notification/notificationcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationListState();
}

class NotificationListState extends State<NotificationList> {
  late ScrollController _controller;
  var isLoading = false;

  void _loadMore() async{
    if(!isLoading) {
      if (_controller.position.maxScrollExtent == _controller.position.pixels) {
        isLoading = true;
        await Provider.of<NotificationProvider>(context, listen: false)
            .getNotification();
        isLoading = false;
      }
    }
  }

  @override
  void initState() {
    _controller = ScrollController()..addListener(_loadMore);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<NotificationProvider>(context).notificationList;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView.builder(
          primary: false,
          controller: _controller,
          itemCount: items.length,
          itemBuilder: (ctx, index) {
            return NotificationCard(
                id: items[index].id,
                name: items[index].title,
                month: items[index].month,
                day: items[index].day.toString(),
                desc: items[index].description,
                date: items[index].date.toString());
          }),
    );
  }
}
