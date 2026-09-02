import 'package:http/http.dart';
import 'dart:convert';

void main () {
  //print("Olá mundo!");
  //requestData();
  RequestDataAsync();
}

void requestData() {
  String url ="https://gist.githubusercontent.com/IanS04/fa71625296d41b610050fd507d760187/raw/b58ada841ad0e2061a29714673a332b18fd75bb2/accounts.json";
  Future<Response> futureResponse = get(Uri.parse(url));
  print(futureResponse);
  futureResponse.then(
    (Response response) {
    print(response);
    print(response.body);
      json.decode(response.body);
      List<dynamic> listAccounts = json.decode(response.body);
      Map<String, dynamic> mapCarla = listAccounts.firstWhere(
        (element) => element["name"] == "Carla",
      );
      print(mapCarla["balance"]);
    },
  );

  print("final da função");
}

Future<void> RequestDataAsync() async {
  String url = 
      "https://gist.githubusercontent.com/IanS04/fa71625296d41b610050fd507d760187/raw/b58ada841ad0e2061a29714673a332b18fd75bb2/accounts.json";
  Response response = await get(Uri.parse(url));
  print(json.decode(response.body)[0]);
  print("ultima coisa a acontecer de verdade");
}
