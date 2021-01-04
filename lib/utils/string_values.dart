abstract class StringValue {
  //App Name
  static const String appTitle = "Task Manager";

  static const String noteTable = 'Note_Table';
  static const String colID = 'id';
  static const String colTitle = 'Title';
  static const String colDescription = 'description';
  static const String colPriority = 'priority';
  static const String colDate = 'date';

  static const String noteDB = 'notes.db';
  static const String countRows = 'SELECT COUNT(*) FROM $noteTable';
  static const String addtask = 'Add Your ToDo Task';

  // one word variables
  static const String statusWord = 'Status';
  static const String clearWord = 'Clear';
  static const String saveWord = 'Save';
  static const String deleteWord = 'Delete';
  static const String detailWord = 'Details';
}
