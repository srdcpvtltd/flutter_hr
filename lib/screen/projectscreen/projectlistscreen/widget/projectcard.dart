import 'package:cnattendance/model/project.dart';
import 'package:cnattendance/screen/projectscreen/projectlistscreen/projectlistscrreencontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProjectCard extends StatelessWidget {
  final Project item;

  ProjectCard(this.item);

  @override
  Widget build(BuildContext context) {
    final ProjectListScreenController model = Get.find();

    List<String> members = [];
    for (var member in item.members) {
      members.add(member.image);
    }

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
      elevation: 0,
      color: Colors.white10,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        onTap: () {
          model.onProjectClicked(item);
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  color: Colors.white12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 5),
                    child: Text(
                      item.priority,
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              SizedBox(height: 5,),
              Row(
                children: [
                  Icon(
                    Icons.work,
                    size: 20,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Text(item.name,
                        maxLines: 2,
                        style: TextStyle(
                            height: 1.5,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 15,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(item.date,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 12)),
                  Spacer(),
                  Icon(
                    Icons.flag,
                    size: 15,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(item.noOfTask.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 12)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              LinearPercentIndicator(
                  padding: EdgeInsets.zero,
                  percent: item.progress / 100,
                  width: MediaQuery.of(context).size.width - 80,
                  lineHeight: 10,
                  barRadius: Radius.circular(20),
                  backgroundColor: Colors.white12,
                  progressColor: item.progress <= 25
                      ? HexColor("#C1E1C1")
                      : item.progress <= 50
                          ? HexColor("#C9CC3F")
                          : item.progress <= 75
                              ? HexColor("#93C572")
                              : HexColor("#3cb116")),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.status,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Text(item.progress.toString() + "%",
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
