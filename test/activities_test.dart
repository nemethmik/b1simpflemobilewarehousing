import 'dart:convert';
import 'package:b1simpflemobilewarehousing/b1simpflemobilewarehousing.dart';
import 'package:test/test.dart';
import 'defaultconnection.dart' as conf;
void main() {
  group("B1SL_ActivityTests", () {
    final IActivities b1s = B1ActivitiesServicesImpl(B1ServiceLayer(conf.connection));
    int newlyCreatedActivityCode;
    test("AddNewActivityToUser12", () async {
      try {
        final activityData = Activity(
            //Subject:-1, ActivityType: -1 /*General*/, Status: -2 /*NotStarted, -3=Completed*/,
            notes:"A longer description of the preparation job for experimenting",
            activityDate: DateTime.now(), 
            activityTime: "08:08", //Activity creation date/time
            startDate : DateTime(2019,9,7), //Automatically convert Dates and Times to strings in POST/PUT/PATCH
            startTime : "10:10", //UTC 0 offset, not the local time :(
            details : "${DateTime.now()}: A short description of the goal of the experiment",
            activityType: -1,
            activity: BoActivities.cn_Task,
            priority: BoMsgPriorities.pr_High,
            personalFlag: false,
            durationType: BoDurations.du_Hours, 
            duration:48.0,
            //handledByEmployee : 3, //OCLG.AttendEmpl
            handledBy: 12, //A user number
        );
        final activityCreated = await b1s.createActivityAsync(activityData);
        //print("Activity with number ${activityCreated.activityCode}");
        newlyCreatedActivityCode = activityCreated.activityCode;
        expect(activityCreated.activityCode,isNotNull);
      } catch (e) {
        if(e is B1Error) {
          print("Exception is B1Error (${e.statusCode}) ${e.error.message.value} (${e.error.code}) for Query ${e.queryUrl} Payload ${e.postBody}");
        }
        expect(e,isNull);
      }
    });
    test("SetActivityCompleted", () async {
      try {
        //const activityCode = 7;
        final activityCode = newlyCreatedActivityCode;
        var activityToComplete = await b1s.getActivityAsync(activityCode,errorWhenNotFound: true);
        //Set activity status to -3 to complete
        activityToComplete.notes += " Completed on ${DateTime.now()}";
        activityToComplete.status = -3; // Completed
        var activityUpdated = await b1s.updateAndFetchActivityAsync(activityCode, activityToComplete);
        print("Activity Completed ${activityUpdated?.status}");
      } catch(e) {
        if(e is B1Error) {
          print("Exception is B1Error (${e.statusCode}) ${e.error.message.value} (${e.error.code}) for Query ${e.queryUrl} Payload ${e.postBody}");
        }
        expect(e,isNull);
      }
    });
    test("DeleteActivity", () async {
      try {
        final activityCodeToDelete = newlyCreatedActivityCode;
        await b1s.deletActivityAsync(activityCodeToDelete);
        var deletedActivity = await b1s.getActivityAsync(activityCodeToDelete);
        expect(deletedActivity?.activityCode,isNull);
      } catch(e) {
        if(e is B1Error) {
          print("Exception is B1Error (${e.statusCode}) ${e.error.message.value} (${e.error.code}) for Query ${e.queryUrl} Payload ${e.postBody}");
        }
        expect(e,isNull);
      }
    });
  });
}