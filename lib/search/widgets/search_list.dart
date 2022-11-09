import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/models/job.dart';
import 'package:job_finder_app/screens/home/widgets/job_item.dart';
import 'package:job_finder_app/screens/home/widgets/job_list.dart';

class SearchList extends StatelessWidget {
  final JobList = Job.generateJobs();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 25,
      ),
      child: ListView.separated(
          padding: EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 25,
          ),
          itemBuilder: (context, index) => JobItem(
                JobList[index],
                showTime: true,
              ),
          separatorBuilder: (_, index) => SizedBox(
                height: 20,
              ),
          itemCount: JobList.length),
    );
  }
}
