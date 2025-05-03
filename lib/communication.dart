import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
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

  static Future<String> getStatus() async{
    return getRequest(
      "get_status",
      {
        "password" : password,
      }
    ).then(
      (response){
        return response.body;
      }
    );
  }
  
}

class SmartPark{

  static String temperature = "20°C";
  static String humidity = "50%";
  static String light = "DARK";
  static String airQuality = "UNHEALTY";
  static int targetTemperature = 20;
  static Color lightColor = Colors.white;

  static List<bool> parkTaken = List.generate(6, (index) => false);

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
    int red = (color.r * 255).toInt();
    int green = (color.g * 255).toInt();
    int blue = (color.b * 255).toInt();
    return WebServer.addCommand("light;color;$red;$green;$blue");
  }

  static Future<String> setTemperature(int targetTemperature) async{
    return WebServer.addCommand("air;temperature;$targetTemperature");
  }
  static Future<String> setAirConditioningHot() async{
    return WebServer.addCommand("air;warm");
  }
  static Future<String> setAirConditioningCool() async{
    return WebServer.addCommand("air;cool");
  } 
  static Future<String> airConditioningOff() async{
    return WebServer.addCommand("air;off");
  } 


  static Future<bool> getStatus() async{
    try{
      String content = await WebServer.getStatus();

      Map<String, dynamic> json = jsonDecode(content);
      temperature = "${json["temperature"]}°C";
      targetTemperature = json["target_temperature"];
      humidity = "${json["humidity"]}%";

      int lightValue = int.parse(json["light"].toString());

      if (lightValue < 500){
        light = "DARK";
      }
      else if (lightValue < 900){
        light = "GOOD";
      }
      else{
        light = "BRIGHT";
      }

      List<int> colorsList = json["light_color"].map<int>((e) => int.parse(e.toString())).toList();
      lightColor = Color.fromARGB(255, colorsList[0], colorsList[1], colorsList[2]);


      int airValue = int.parse(json["air"].toString());

      if (airValue < 30){
        airQuality = "GOOD";
      }
      else if (airValue < 100){
        airQuality = "MODERATE";
      }
      else{
        airQuality = "UNHEALTY";
      }

      parkTaken = json["park"].map<bool>((e) => e == 1).toList();
      return true;
    }catch(e){
      debugPrint("Error: $e");
      return false;
    }    
  }
}