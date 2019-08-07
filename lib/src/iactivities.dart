import 'activity.dart';
abstract class IActivities {//for task management
  Future<List<Activity>> queryOpenActivitiesAsync({int handledBy,String fields});
  Future<Activity> getActivityAsync(int activityCode,{bool errorWhenNotFound = false});
  Future<Activity> createActivityAsync(Activity activityData);
  Future updateActivityAsync(int activityCode, Activity activityData);
  Future<Activity> updateAndFetchActivityAsync(int activityCode, Activity activityData);
  Future deletActivityAsync(int activityCode,{bool errorWhenDoesntExist = false});
}
