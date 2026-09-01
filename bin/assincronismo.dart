import 'package:http/http.dart';

void main () {
  print("Olá mundo!");
  requestData();
}

void requestData() {
  String url ="https://gist.githubusercontent.com/IanS04/fa71625296d41b610050fd507d760187/raw/b58ada841ad0e2061a29714673a332b18fd75bb2/accounts.json";
  Future<Response> futureResponse = get(Uri.parse(url));
  print(futureResponse);
  futureResponse.then(
    (Response response) {
    print(response);
    print(response.body);
    
    },
  );
}