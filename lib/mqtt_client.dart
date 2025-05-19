import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

// connection states for easy identification
enum MqttCurrentConnectionState {
  idle,
  connecting,
  connected,
  disconnected,
  errorWhenConnecting
}

enum MqttSubscriptionState {
  idle,
  subscribed
}

class MQTTClientWrapper {

  static late MqttServerClient client;

  static MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.idle;
  static MqttSubscriptionState subscriptionState = MqttSubscriptionState.idle;

  // using async tasks, so the connection won't hinder the code flow
  static void init(onStatus, onAiPark) async {
    _setupMqttClient();
    await _connectClient();
    String statusTopic = const String.fromEnvironment("MQTT_STATUS_TOPIC");
    String aiParkTopic = const String.fromEnvironment("MQTT_AI_PARK_TOPIC");
    _subscribeToTopic(statusTopic, onStatus);
    _subscribeToTopic(aiParkTopic, onAiPark);
  }

  static void dispose(){
    client.disconnect();
  }

  // waiting for the connection, if an error occurs, debugPrint it and disconnect
  static Future<void> _connectClient() async {
    try {
      debugPrint('client connecting....');
      connectionState = MqttCurrentConnectionState.connecting;
      String username = const String.fromEnvironment("MQTT_USER");
      String password = const String.fromEnvironment("PASSWORD");

      await client.connect(username, password);
    } on Exception catch (e) {
      debugPrint('client exception - $e');
      connectionState = MqttCurrentConnectionState.errorWhenConnecting;
      client.disconnect();
    }

    // when connected, debugPrint a confirmation, else debugPrint an error
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      connectionState = MqttCurrentConnectionState.connected;
      debugPrint('client connected');
    } else {
      debugPrint(
          'ERROR client connection failed - disconnecting, status is ${client.connectionStatus}');
      connectionState = MqttCurrentConnectionState.errorWhenConnecting;
      client.disconnect();
    }
  }

  static void _setupMqttClient() {
    String server = const String.fromEnvironment("MQTT_SERVER");
    String name = const String.fromEnvironment("MQTT_NAME");
    String port = const String.fromEnvironment("MQTT_PORT");
    client = MqttServerClient.withPort(server, name, int.parse(port));
    // the next 2 lines are necessary to connect with tls, which is used by HiveMQ Cloud
    client.secure = true;
    client.securityContext = SecurityContext.defaultContext;
    client.keepAlivePeriod = 20;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
  }

  static void _subscribeToTopic(String topicName, void Function(String staus) onStatus) {
    debugPrint('Subscribing to the $topicName topic');
    client.subscribe(topicName, MqttQos.atMostOnce);

    // debugPrint the message when it is received
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttReceivedMessage recMess = c[0];
      final MqttPublishMessage message = recMess.payload as MqttPublishMessage;
      var strMessage =  MqttPublishPayload.bytesToStringAsString(message.payload.message);

      debugPrint('YOU GOT A NEW MESSAGE:');
      debugPrint(strMessage);
      onStatus(strMessage);
    });
  }

  static String addCommand(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    String commandTopic = const String.fromEnvironment("MQTT_COMMANDS_TOPIC");
    debugPrint('Publishing message "$message" to topic $commandTopic');
    return client.publishMessage(commandTopic, MqttQos.exactlyOnce, builder.payload!).toString();
  }

  // callbacks for different events
  static void _onSubscribed(String topic) {
    debugPrint('Subscription confirmed for topic $topic');
    subscriptionState = MqttSubscriptionState.subscribed;
  }

  static void _onDisconnected() {
    debugPrint('OnDisconnected client callback - Client disconnection');
    connectionState = MqttCurrentConnectionState.disconnected;
  }

  static void _onConnected() {
    connectionState = MqttCurrentConnectionState.connected;
    debugPrint('OnConnected client callback - Client connection was sucessful');
  }

}