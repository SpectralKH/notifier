import 'dart:collection';
import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListModel extends Model {
  // List<NotificationItem> _notificationItems = [
  //   NotificationItem(title: 'nice', description: 'breat'),
  //   NotificationItem(title: 'cold', description: 'sheep'),
  // ];
  List<dynamic> _notificationItems = [];

  UnmodifiableListView<dynamic> get items => UnmodifiableListView(_notificationItems);

  ListModel() {
    _read();
  }

  _read() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String notificationItems = prefs.getString('notificationItems') ?? '[]';
    _notificationItems = json.decode(notificationItems);
    print(_notificationItems);
    notifyListeners();
  }

  _save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('notificationItems', json.encode(_notificationItems));
  }

  void add(dynamic notificationItem) async {
    _notificationItems.add(notificationItem);
    _save();
    print(_notificationItems);
    notifyListeners(); // tell the model to rebuild the widgets that depend on it
  }

}
