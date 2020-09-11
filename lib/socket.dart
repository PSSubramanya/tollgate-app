import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper{
  NetworkHelper (this.url);
final String url;

  Future<dynamic> getData() async {
    print("reached here");
    //http.Response response = await http.get(url);
    http.Request response = await http.Request("GET", Uri.parse(url));
    
    print("reached here1");
    http.StreamedResponse result = await response.send();
    
    print("reached here3");
    if(result.statusCode==200){
      String data =await utf8.decodeStream(result.stream);
      print(data);
      return data.toString();
    }
//  return response.body;
  }
}