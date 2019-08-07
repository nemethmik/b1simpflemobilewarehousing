// import 'dart:collection';
import 'dart:convert';
import 'package:b1serviceflayer/b1serviceflayer.dart';
import 'entitybase.dart';

class BoActivities extends BoEnums {
  static final Map<String,BoActivities> enums = {
    cn_Conversation.value:cn_Conversation,
    cn_Meeting.value:cn_Meeting,
    cn_Task.value:cn_Task,
    cn_Other.value:cn_Other,
    cn_Note.value:cn_Note,
    cn_Campaign.value:cn_Campaign,
  };
  static const cn_Conversation = BoActivities("cn_Conversation");
  static const cn_Meeting = BoActivities("cn_Meeting");
  static const cn_Task = BoActivities("cn_Task");
  static const cn_Other = BoActivities("cn_Other");
  static const cn_Note = BoActivities("cn_Note");
  static const cn_Campaign = BoActivities("cn_Campaign");
  const BoActivities(String value) : super(value);
}

class BoMsgPriorities extends BoEnums {
  static final Map<String,BoMsgPriorities> enums = {
    pr_Low.value: pr_Low,
    pr_High.value: pr_High,
    pr_Normal.value: pr_Normal,
  };
  static const pr_Low = BoMsgPriorities("pr_Low");
  static const pr_Normal = BoMsgPriorities("pr_Normal");
  static const pr_High = BoMsgPriorities("pr_High");
  const  BoMsgPriorities(String value) : super(value);
}

class BoDurations extends BoEnums {
  static final Map<String,BoDurations> enums = {
    du_Seconds.value: du_Seconds,
    du_Minuts.value: du_Minuts,
    du_Hours.value: du_Hours,
    du_Days.value: du_Days,
  };
  static const du_Seconds = BoDurations("du_Seconds");
  static const du_Minuts = BoDurations("du_Minuts");
  static const du_Hours = BoDurations("du_Hours");
  static const du_Days = BoDurations("du_Days");
  const BoDurations(String value) : super(value);
}

class Activity extends EntityBase {
  static const ActivityCode = "ActivityCode";
  static const Status = "Status";
  static const StartDate = "StartDate";
  static const Notes = "Notes";
  static const Closed = "Closed";
  static const Activity_ = "Activity";
  static const ActivityDate = "ActivityDate";
  static const ActivityTime = "ActivityTime";
  static const StartTime = "StartTime";
  static const Details = "Details";
  static const ActivityType = "ActivityType";
  static const Priority = "Priority";
  static const PersonalFlag = "PersonalFlag";
  static const DurationType = "DurationType";
  static const Duration = "Duration";
  static const HandledBy = "HandledBy";

  Activity({int activityCode,DateTime startDate, String notes, 
    DateTime activityDate, String startTime, String details, int activityType, 
    BoActivities activity,BoMsgPriorities priority, bool personalFlag, BoDurations durationType, 
    double duration, int handledBy,String activityTime,int status}){
    if(activityCode != null) this.activityCode = activityCode;
    if(status != null) this.status = status;
    if(startDate != null) this.startDate = startDate;
    if(notes != null) this.notes = notes; 
    if(activityDate != null) this.activityDate = activityDate; 
    if(startTime != null) this.startTime = startTime; 
    if(details != null) this.details = details;
    if(activityType != null) this.activityType = activityType; 
    if(activity != null) this.activity = activity;
    if(priority != null) this.priority = priority;
    if(personalFlag != null) this.personalFlag = personalFlag;
    if(durationType != null) this.durationType = durationType; 
    if(duration != null) this.duration = duration;
    if(handledBy != null) this.handledBy = handledBy;
    if(activityTime != null) this.activityTime = activityTime;
  }
  Activity.fromJson(String jsonString) : super.fromJson(jsonString);
  Activity.fromMap(Map<String,dynamic> jsonMap) : super.fromMap(jsonMap);
  static List<Activity> fromValue(String jsonString) {
    Map<String,dynamic> jsonMap = json.decode(jsonString);
    return List<Activity>.from(jsonMap["value"].map((x) => Activity.fromMap(x)));
  }  
  int get activityCode {return this[ActivityCode];}
  set activityCode(int v) {this[ActivityCode] = v;}
  int get status {return this[Status];}
  set status(int v) {this[Status] = v;}
  DateTime get startDate => EntityBase.dateParse(this[StartDate]);
  set startDate(DateTime d) {this[StartDate] = EntityBase.dateToString(d);}
  String get notes => this[Notes];
  set notes(String s) {this[Notes] = s;}
  String get activityTime => this[ActivityTime];
  set activityTime(String s) {this[ActivityTime] = s;}
  bool get closed => EntityBase.isYes(this[Closed]);
  set closed(bool b) {this[Closed] = EntityBase.yesNo(b);}
  BoActivities get activity => BoActivities.enums[this[Activity_]];
  set activity(BoActivities b) {this[Activity_] = EntityBase.enumValue(b);}
  DateTime get activityDate => EntityBase.dateParse(this[ActivityDate]);  
  String get startTime => this[StartTime]; 
  String get details => this[Details]; 
  int get activityType => this[ActivityType]; 
  BoMsgPriorities get priority => BoMsgPriorities.enums[this[Priority]]; 
  bool get personalFlag => EntityBase.isYes(this[PersonalFlag]); 
  BoDurations get durationType => BoDurations.enums[this[DurationType]]; 
  double get duration => this[Duration]; 
  int get handledBy => this[HandledBy];
  set activityDate(DateTime v) => this[ActivityDate] = EntityBase.dateToString(v);  
  set startTime(String v) => this[StartTime] = v; 
  set details(String v) => this[Details] = v; 
  set activityType(int v) => this[ActivityType] = v; 
  set priority(BoMsgPriorities v) => this[Priority] = EntityBase.enumValue(v); 
  set personalFlag(bool v) => this[PersonalFlag] = EntityBase.yesNo(v); 
  set durationType(BoDurations v) => this[DurationType] = EntityBase.enumValue(v); 
  set duration(double v) => this[Duration] = v; 
  set handledBy(int v) => this[HandledBy] = v;
} 
