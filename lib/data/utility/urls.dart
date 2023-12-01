class Urls {
  static const String _baseUrl = "https://task.teamrabbil.com/api/v1";
  static const String registration = "$_baseUrl/registration";
  static const String login = "$_baseUrl/login";
  static const String createNewTask = "$_baseUrl/createTask";
  static const String getTaskStatusCount = "$_baseUrl/taskStatusCount";
  static const String getNewTask = "$_baseUrl/listTaskByStatus/New";
  static const String getInProgressTask = "$_baseUrl/listTaskByStatus/Progress";
  static const String getCompletedTask = "$_baseUrl/listTaskByStatus/Completed";
  static const String getCancelledTask = "$_baseUrl/listTaskByStatus/Cancelled";
  static String getUpdateTaskStatus(String taskId, String status) =>
      "$_baseUrl/updateTaskStatus/$taskId/$status";
  static String getDeleteTask(String taskId) => "$_baseUrl/deleteTask/$taskId";
  static String getRecoveryEmail(String emailId) => "$_baseUrl/RecoverVerifyEmail/$emailId";
  static String getOTP(String emailId, String OTP) => "$_baseUrl/RecoverVerifyOTP/$emailId/$OTP";
  static const String setNewPassword = "$_baseUrl/RecoverResetPass";
}
