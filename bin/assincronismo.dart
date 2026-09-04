import 'dart:async';

import 'package:assincronismo/api_key.dart';
import 'package:http/http.dart';
import 'dart:convert';

StreamController<String> streamController = StreamController<String>();
void main () {
  StreamSubscription streamSubscription = 
      streamController.stream.listen((String info) {
        print(info);
      },
    );

  requestData();
  RequestDataAsync();
  sendDataAsync({
    "id": "NEW001",
    "name": "Carlos",
    "lastName": "Andre Santos",
    "balance": 5000,
  });
}

void requestData() {
  String url ="https://gist.githubusercontent.com/IanS04/fa71625296d41b610050fd507d760187/raw/b58ada841ad0e2061a29714673a332b18fd75bb2/accounts.json";
  Future<Response> futureResponse = get(Uri.parse(url));
  futureResponse.then(
    (Response response) {
      streamController.add("${DateTime.now()} | Requisição de leitura (usando then).");
    },
  );
}

Future<List<dynamic>> RequestDataAsync() async {
  String url = 
      "https://gist.githubusercontent.com/IanS04/fa71625296d41b610050fd507d760187/raw/b58ada841ad0e2061a29714673a332b18fd75bb2/accounts.json";
  Response response = await get(Uri.parse(url));
    streamController.add("${DateTime.now()} | Requisição de leitura.");
  return json.decode(response.body);
}

Future<void> sendDataAsync(Map<String, dynamic> mapAccount) async {
  List<dynamic> listAccounts = await RequestDataAsync();
  listAccounts.add(mapAccount);
  String content = json.encode(listAccounts);
  
  String url = 
      "https://api.github.com/gists/fa71625296d41b610050fd507d760187";

  Response response = await post(
    Uri.parse(url),
    headers: {
      "Authorization" : "Bearer $githubApiKey"
    }, 
    body: json.encode({
      "description": "account.json",
      "public": true,
      "files": {
        "accounts.json": {
          "content": content,
        }
      }
    }),
  );

  if (response.statusCode.toString()[0] == "2"){
    streamController.add("${DateTime.now()} | Requisição de adição bem sucedida (${mapAccount["name"]}).");
  }else{
    streamController.add("${DateTime.now()} | Requisição de falhou (${mapAccount["name"]}).");

  }
}
