import 'dart:ui';

import 'package:http/http.dart' as http;

class WebServer {

  static String get serverName
  {    
    return const String.fromEnvironment("SERVER_NAME");
  }

  static String get password
  {    
    return const String.fromEnvironment("PASSWORD");
  }

  static String get backend
  {    
    return const String.fromEnvironment("BACKEND");
  }
  
  static Uri geBackendUri(String phpFile, Map<String, String>? parameters)
  {
    Uri uri;

    uri = Uri.https(serverName,'$backend/$phpFile.php', parameters);
    
    return uri;
  }

  static Future<http.Response> getRequest(String phpFile, [Map<String, String>? parameters]) async {
      http.Response response = await http.get(geBackendUri(phpFile, parameters));
      return response;    
  }

  static Future<http.Response> postRequest(
    String phpFile, 
    {Map<String, String>? getParameters, Map<String, String>? body}
  ) async{    
    http.Response response = await http.post(geBackendUri(phpFile, getParameters ?? {}), body: body);
    return response;
  }

  static Future<String> getStatus() async{
    return getRequest(
      "get_status",
      {
        "password" : password
      }
    ).then(
      (response){
        return response.body;
      }
    );
  }

  static Future<String> addCommand(String command) async{
    return getRequest(
      "add_command",
      {
        "password" : password,
        "command" : command,
        "timestamp" : DateTime.now().toString()
      }
    ).then(
      (response){
        print(response.body);
        return response.body;
      }
    );
  }

  
}

class SmartPark{
  static Future<String> lightsOn() async{
    return WebServer.addCommand("light;on");
  }
  static Future<String> lightsOff() async{
    return WebServer.addCommand("light;off");
  }
  static Future<String> lightsAuto() async{
    return WebServer.addCommand("light;auto");
  }
  static Future<String> lightsColor(Color color) async{
    return WebServer.addCommand("light;color;${color.r};${color.g};${color.b}");
  }
}