import 'dart:convert';
import 'package:covid_19_app/Model/WorldStatesModel.dart';
import 'package:covid_19_app/Services/Utilities/app_uri.dart';
import 'package:http/http.dart' as http;


class StatesServices {


    Future<WorldStatesModel> fetchWorldStatesRecords ()  async{
      final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

      if(response.statusCode==200){
        var data=jsonDecode(response.body);
        return WorldStatesModel.fromJson(data);
      }else{
        throw Exception('Error');

      }
    }


    Future<List<dynamic>> countriesListtApi ()  async{
      var data;
      final response = await http.get(Uri.parse(AppUrl.countriesList));

      if(response.statusCode==200){
        data=jsonDecode(response.body);
        return data;
      }else{
        throw Exception('Error');

      }
    }

}