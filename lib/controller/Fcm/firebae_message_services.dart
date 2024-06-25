/*import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class PushNotification {
  static Future<String> accesToken() async {
    final jsonFile = {
      {
        "type": "service_account",
        "project_id": "simpleiot-8934f",
        "private_key_id": "f96bb1b660deebdf10a322453173c40958d75bc7",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDrlyGl1XF3Htqd\nK1VmHD2dkUpyW+9kq7S0u4d9XT7fcDl14mtZmY/jNGSTGDE9fXeiiDy/FzTOPrMQ\nJDBiIl4QjEb6fIRZ9TrJ9cC1RBSsEpu/Ex0DVCCeksL6Tu/zBdy6S/ych6ziURNK\nRbuV4jvZ61G6UN8/MYNhsX9FjFYjhwlemBJUrqQYua5uF3UGfeQcm5zFYclEZjJ1\n41xy7lSleJOwhSr3CtCnFmLvpnTKPoNANQV1kybHMvSCfe+aEfzLx+xzRpOsfujC\nRtFMEP3Jtv3oIrxwlh7z8ejQ7zAdPL2sUh+KOaHyqhZCUhoeycFORN9hRV48Ezqs\nDqIeco5dAgMBAAECggEAN90VLzna5zRzgc/P9v/M04NrfA0VSdGWbsHGCcHV4g0+\nLtgi/PLXJfjbPW7/5BUPjISSJPzXem1vL+1o5KhCFlnxDb3/c0Zda5zg1oq/fSMH\nd+pMF6k39+oUnl6f8shJ1AonKyXX5q1zbcn1xn+IEi9E6LF7EoTG4uBALeluVote\n7VPnwmYJ/YGW4HPeCyXKq0kIFql50g/03ivAGrNN07wcqoohzfLx+EjnbpgdRvC2\nR6A9hYqKutd4NSOEhy0IzZDA1hwlgx6f5MBEPrBpxb11bEhh3hMiehUUAJUZG0Te\nyWBSXy+St5mjS0USi6/PWbiFfjmlqmfte0XfmuQ7mQKBgQD/My4DA1CfJMgCbLpj\n8Ly0Ev8uVE0y64AyeyFrf1FpIfhhdlD7gD4wuYR1plxJ5J3vGJJFZCY0EVBWueYb\nLf6Vg7Jk7KzMkuZUo34QNoCWiJ1iDjOtVI2xtd9C3OUEY+m6c1rtxPwdiTAyD4Y3\nI5X5OOLqyjs5gMkvljr8HHpppQKBgQDsVDabpjmNpNeAdROamJWn3QoClmZVHLZt\nEF9vLORvOLqurlgkHNJmZBsproajpU+1GZ7mvBBRbhheOkOEM7YQ1xNzhWo2ia68\nK0SzJgSylZvPvQa7nXKRW1IEBpydo6uhS/dAieiHWHUagA8DtJZnHeOdGJE4/z+e\nFgXP1EREWQKBgQC/8zDylzW23iWKnVl8/oAROhCyOjpuyG/+iFrUzkjfuOtn82Rq\nJ0WfxIp7K4xTECAyzNqIUxHhK/yvntgTLX9F2m7+Nn6qyPtyQh759uS1VUB7lo8M\nGoMRXej2E8w2hygwU7/bA8VWOfAEV2TuaFfPwxf63e26DMJGhssLAiiY+QKBgQCb\nn0jmbitwDqCqQm5KWzgRdgjlc0ynt2SZpTJy70jtxJmJ9dysyx3xtvH8HKUklfNK\n+jgdELJeLPV29z8Gi1bU+AwjAjPS/g9GceenYN2vC72yqnMIkMGk3lG/vOrdE64t\nZOzIXwf0OFfEv5cjhYOVG6WLCWZ39f1aiH4DQXBC4QKBgEeusEAWlXENPEZ+aSl7\niA91c7PUapV5wW5MmQIXogDhyC2fLL7+jafXxms1x+8339Y6mFuitJxjBsFQHR8K\ncNlL60U5FGAFhoU1GLWh2RA/vjQABiDjw2KFnLIdFfsUEwsUtl8pg1615495++/q\nm3MAGKs1znVaNoMNATnhaFi/\n-----END PRIVATE KEY-----\n",
        "client_email": "simple-iot@simpleiot-8934f.iam.gserviceaccount.com",
        "client_id": "116022710160585603999",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/simple-iot%40simpleiot-8934f.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      },
    };

    List<String> scopesUrl = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
    ];

    // client credential
    http.Client clients = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(jsonFile), scopesUrl);

    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(jsonFile),
            scopesUrl,
            clients);

    clients.close();

    return credentials.accessToken.data;
  }

  //token acces

  static notificationSend(
      String tokenDevice, BuildContext context, String messages) async {
    final String tokenAccesKey = await accesToken();
    String endpointAcces =
        'https://fcm.googleapis.com/v1/projects/simpleiot-8934f/messages:send'; //endpoint to use the fcm

    final Map<String, dynamic> message = {
      'message': {
        'token': tokenDevice,
        'notification': {
          'title': 'Simple IOT',
          'body': 'Your temperature is being too high',
        },
        'data': {
          'message': messages,
        }
      }
    };

    final http.Response response = await http.post(Uri.parse(endpointAcces),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $tokenAccesKey',
        },
        body: jsonEncode(message));

    if (response.statusCode == 200) {
      print('BERHHASIL');
    } else {
      print('GAGAL ');
    }
  }
}*/



