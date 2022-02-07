import 'dart:convert';

import 'package:http/http.dart' as http ;

class Data{

  Future getData(double latitude , double longitude) async{
    var response = await http.get(Uri.parse('http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=6b232833b4db8996d01dd4b30d48a522&units=metric'));


     if(response.statusCode == 200){

       var jsonData = jsonDecode(response.body);
       return jsonData;

     }
     else{
       print(response.statusCode);
     }

  }
}

