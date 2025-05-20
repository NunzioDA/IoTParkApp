import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:iot_park_app/mqtt_client.dart';

// class WebServer {

//   static String get serverName
//   {    
//     return const String.fromEnvironment("SERVER_NAME");
//   }

//   static String get password
//   {    
//     return const String.fromEnvironment("PASSWORD");
//   }

//   static String get backend
//   {    
//     return const String.fromEnvironment("BACKEND");
//   }
  
//   static Uri geBackendUri(String phpFile, Map<String, String>? parameters)
//   {
//     Uri uri;

//     uri = Uri.https(serverName,'$backend/$phpFile.php', parameters);
    
//     return uri;
//   }

//   static Future<http.Response> getRequest(String phpFile, [Map<String, String>? parameters]) async {
//       http.Response response = await http.get(geBackendUri(phpFile, parameters));
//       return response;    
//   }

//   static Future<http.Response> postRequest(
//     String phpFile, 
//     {Map<String, String>? getParameters, Map<String, String>? body}
//   ) async{    
//     http.Response response = await http.post(geBackendUri(phpFile, getParameters ?? {}), body: body);
//     return response;
//   }

//   static Future<String> addCommand(String command) async{
//     return getRequest(
//       "add_command",
//       {
//         "password" : password,
//         "command" : command,
//         "timestamp" : DateTime.now().toString()
//       }
//     ).then(
//       (response){
//         print(response.body);
//         return response.body;
//       }
//     );
//   }

//   static Future<String> getStatus() async{
//     return getRequest(
//       "get_status",
//       {
//         "password" : password,
//       }
//     ).then(
//       (response){
//         return response.body;
//       }
//     );
//   }
  
// }


// This static class is used to communicate with the 
// park and to get the current state
class SmartPark{

  // park state variables
  static String temperature = "20°C";
  static String humidity = "50%";
  static String light = "DARK";
  static String airQuality = "UNHEALTY";
  static int targetTemperature = 20;
  static Color lightColor = Colors.white;

  static List<bool> parkTaken = List.generate(6, (index) => false);

  // This method is used to initialize the communication
  static void init(void Function() onStateChanged){
    MQTTClientWrapper.init(
      (state){
        bool done = manageState(state);
        if(done) onStateChanged();
      },
      (aiPark){
        bool done = manageAiPark(aiPark);
        if(done) onStateChanged();
      }
    );
  }
  // This method is used to dispose
  // the client wrapper
  static void dispose(){
    MQTTClientWrapper.dispose();
  }

  // The following methods are used to send commands 
  // to the Smart Park
  static Future<String> lightsOn() async{
    return MQTTClientWrapper.addCommand("light;on");
  }
  static Future<String> lightsOff() async{
    return MQTTClientWrapper.addCommand("light;off");
  }
  static Future<String> lightsAuto() async{
    return MQTTClientWrapper.addCommand("light;auto");
  }
  static Future<String> lightsColor(Color color) async{
    int red = (color.r * 255).toInt();
    int green = (color.g * 255).toInt();
    int blue = (color.b * 255).toInt();
    return MQTTClientWrapper.addCommand("light;color;$red;$green;$blue");
  }
  static Future<String> setTemperature(int targetTemperature) async{
    return MQTTClientWrapper.addCommand("air;temperature;$targetTemperature");
  }
  static Future<String> setAirConditioningHot() async{
    return MQTTClientWrapper.addCommand("air;warm");
  }
  static Future<String> setAirConditioningCool() async{
    return MQTTClientWrapper.addCommand("air;cool");
  } 
  static Future<String> airConditioningOff() async{
    return MQTTClientWrapper.addCommand("air;off");
  } 

  // This method is used to manage the received
  // state message as a JSON string
  static bool manageState(String state){
    try{
      // updating variables
      Map<String, dynamic> json = jsonDecode(state);
      temperature = "${json["temperature"]}°C";
      targetTemperature = json["target_temperature"];
      humidity = "${json["humidity"]}%";

      int lightValue = double.parse(json["light"].toString()).toInt();
      // parsing light values
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


      int airValue = double.parse(json["air"].toString()).toInt();
      // parsing air quality values
      if (airValue < 60){
        airQuality = "GOOD";
      }
      else if (airValue < 100){
        airQuality = "MODERATE";
      }
      else{
        airQuality = "UNHEALTY";
      }

      // parsing parking spots
      for (var i = 0; i<json["park"].length; i++){
        parkTaken[3 + i] = json["park"][i] == 1;
      }
      
      return true;
    }catch(e){
      debugPrint("Error: $e");
      return false;
    }  
  }

  static bool manageAiPark(String aiPark){
    try{
      List<dynamic> json = jsonDecode(aiPark);
      for (var i = 0; i < json.length; i++){
        parkTaken[i] = json[i] == 1;
      }
      return true;
    }
    catch(e){
      debugPrint("Error: $e");
      return false;
    } 
  }


  // static Future<bool> getStatus() async{
  //   try{
  //     String content = await WebServer.getStatus();

  //     return manageState(content);
  //   }catch(e){
  //     debugPrint("Error: $e");
  //     return false;
  //   }    
  // }
}