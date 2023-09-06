import 'dart:convert';

import 'package:app_manteni_correc/app/data/services/errors/informe_list_error.dart';
import 'package:app_manteni_correc/app/domain/models/informe/informe_list.dart';
import 'package:http/http.dart';

class InformeListAPI{
  InformeListAPI(this._client);

  final Client _client;
  final _baseUrl ='https://invulnerable-bastille-39566-a52ccd510b57.herokuapp.com/api';
  
  Future<List<InformeListDetail>> getInformeListData(int iduser) async{
    final response = await _client.post(
      Uri.parse('$_baseUrl/generalData/list'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({'idUser': iduser})
      );
    if(response.statusCode==200){
      jsonDecode(response.body);
      final informe = informeListFromJson(response.body);
      final informelistDetails = informe.informeListDetails;
      return informelistDetails;
    }else {
      throw InformeListApiError();
    }

  }

  Future<InformeListDetail> createUpdateInforme(Map<String, dynamic> informeLike,idUser) async{
    informeLike.update("idUser", (value) => idUser);

    final data=InformeListDetail.fromJson(informeLike);
    final response = await _client.post(
      Uri.parse('$_baseUrl/generalData/create'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data.toJson()));
    if(response.statusCode==200){
      Map<String, dynamic> informeLike2=jsonDecode(response.body);
      informeLike2;
      final informe = informeLike2["data"];
      final informelistDetails = InformeListDetail.fromJson(informe);
      return informelistDetails;
    }else {
      throw InformeListApiError();
    }

  }

  Future<InformeListDetail> getInformeById(String cid) async{
    final response = await _client.post(
      Uri.parse('$_baseUrl/generalData/list'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({'CID': cid}));
    if(response.statusCode==200){
      jsonDecode(response.body);
      final informe = informeListFromJson(response.body);
      final informelistDetails = informe.informeListDetails.first;
      return informelistDetails;
    }else {
      throw InformeListApiError();
    }

  }


}