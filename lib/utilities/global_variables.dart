bool variable = false;
int groupValue = -1;
int warmDuration = 90;
int coldDuration = 90;
int plungeDuration = 90;
List<String> months = [
  "",
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];
final List<String> weekStartList = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"];
String baseUrl = "http://showertracking.test/api/";

enum Themes { device, light, dark }

enum DayType { clear, check, fail, skip }

var notificationAppLaunchDetails;
