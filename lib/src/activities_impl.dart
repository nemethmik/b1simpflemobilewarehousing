import "package:meta/meta.dart";
import 'package:b1simpflemobilewarehousing/b1simpflemobilewarehousing.dart';

mixin ActivitiesImpl on B1Services implements IActivities {  
  @override
  Future<Activity> getActivityAsync(int activityCode,{bool errorWhenNotFound = false}) async {
    String activityJSONString = await sl.queryAsync("Activities(${activityCode})",errorWhenNotFound: errorWhenNotFound);
    return activityJSONString != null ? Activity.fromJson(activityJSONString) : null;
  }
  @override
  Future<List<Activity>> queryOpenActivitiesAsync({int handledBy,String fields}) async {
    String activitiesJSONString = await sl.queryAsync("Activities?\$filter=Closed eq '${BoYesNoEnum.tNO.value}'" 
      + (handledBy != null ? " and HandledBy eq ${handledBy}" : "")
      + (fields != null ? "&\$select=ActivityCode,$fields" : "")
    );//ActivityCode is always included
    return Activity.fromValue(activitiesJSONString);
  }
  @override
  Future<Activity> createActivityAsync(Activity activityData) async {
    String activityJSONString = await sl.createAsync(entityName: "Activities", entityJSON: activityData.toJson());
    return Activity.fromJson(activityJSONString);
  }
  @override
  Future updateActivityAsync(int activityCode, Activity activityData) async {
    if(activityData.activityCode != null && activityData.activityCode != activityCode) {
      throw Exception("The activityCode ($activityCode) parameter is different from the activityData.ActivityCode (${activityData.activityCode}. Set activityData.activityCode to null before calling update.");
    }
    await sl.updateAsync(entityName: "Activities($activityCode)", entityJSON: activityData.toJson());
  }
  @override
  Future<Activity> updateAndFetchActivityAsync(int activityCode, Activity activityData) async {
    await updateActivityAsync(activityCode, activityData);
    return await getActivityAsync(activityCode);
  }
  @override
  Future deletActivityAsync(int activityCode,{bool errorWhenDoesntExist = false}) async {
    await sl.deleteAsync(entityName: "Activities($activityCode)",errorWhenDoesntExist: errorWhenDoesntExist);
    return null;
  }
}
class B1ActivitiesServicesImpl extends B1Services with ActivitiesImpl {
  B1ActivitiesServicesImpl(B1ServiceLayer sl) : super(sl);
}
