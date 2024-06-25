import 'dart:math';


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MqttServerClient client;
  String temperature = "N/A";
  String humidity = "N/A";


  String _generateClientId() {
    final random = Random();
    final clientId = 'flutter_client_${random.nextInt(1000)}';
    return clientId;
  }

  @override
  void initState() {
    super.initState();
    connect();
    
  }

   

  Future<void> connect() async {
    final clientId = _generateClientId();
    client = MqttServerClient('broker.emqx.io', 'Simple-iot');
    client.port = 1883;
    client.keepAlivePeriod = 20;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.logging(on: true);
    final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final recMess = c[0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      setState(() {
        if (c[0].topic == 'esp32/sensor/temperature') {
          temperature = pt;
          if (double.tryParse(temperature) != null && double.parse(temperature) > 10.00) {
            // Replace with your actual device token and tripId
           // PushNotification.notificationSend(_deviceToken!, context, 'Your Temperatur is $temperature');
          }
        } else if (c[0].topic == 'esp32/sensor/humidity') {
          humidity = pt;
        }
      });
    });

    client.subscribe('esp32/sensor/humidity', MqttQos.atLeastOnce);
    client.subscribe('esp32/sensor/temperature', MqttQos.atLeastOnce);
  }

  void onConnected() {
    //in conected
  }

  void onDisconnected() {
    //if disconected
  }

  void onSubscribed(String topic) {
    //on subscribed
  }

  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.04),
              child: Text(
                'Home Sweet Home',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white), 
              ),
            ),
          ),
          SizedBox(
            height: 320,
            width: size.width * 0.9,
            child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    mainAxisExtent: size.height * 0.15),
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.05),
                          child: Text(
                            '$temperature °C',
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        // ignore: prefer_const_constructors
                        SizedBox(height: 10),
                        Text(
                          'Avg house tempt',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.05),
                          child: Text(
                            '$humidity °F',
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Outside Tempt',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.05),
                          child: Text(
                            '$humidity %',
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'PPP',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.05),
                          child: Text(
                            '3',
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Devices',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black),
                        )
                      ],
                    ),
                  )
                ]),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.2,),
                child: Text(
                  'Room',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 21,
                      color: Colors.amber),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 60,
                width: 150,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Colors.white,
                    Color.fromARGB(255, 248, 234, 108),
                    Colors.yellow
                  ]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text('Master Bedroom'),
                ),
              ),
              Container(
                height: 60,
                width: 150,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Colors.white,
                    Color.fromARGB(255, 248, 234, 108),
                    Colors.yellow
                  ]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text('Bedroom'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 60,
                width: 150,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Colors.white,
                    Color.fromARGB(255, 248, 234, 108),
                    Colors.yellow
                  ]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text('Kids Room'),
                ),
              ),
              Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Colors.white,
                      Color.fromARGB(255, 248, 234, 108),
                      Colors.yellow
                    ]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text('Kitchen Room'),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
