import 'dart:convert';
import 'package:app_manteni_correc/app/data/services/errors/image_erros.dart';
import 'package:app_manteni_correc/app/domain/models/image/image.dart';
import 'package:app_manteni_correc/app/domain/models/image/imageDescription.dart';
import 'package:app_manteni_correc/app/presentation/providers/image/image_provider_model.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart';

class ImageAPI{

  ImageAPI(this._client);

  final Client _client;
  final _baseUrl ='https://invulnerable-bastille-39566-a52ccd510b57.herokuapp.com/api';
  
  Future<List<ImageDescripcion>> getImageDescripcionList() async{
    final response = await _client.post(Uri.parse('$_baseUrl/descripcion/list'));
    if(response.statusCode==200){
      jsonDecode(response.body);
      final imageDescripcion = imageDescripcionFromJson(response.body);
      final informelistDetails = imageDescripcion.imageDescripcionList;
      return informelistDetails;
    }else {
      throw ImageApiError();
    }
  }

  Future<void> uploadImage(List<ImageModel> _imageListModel,String cid) async {
    
    print(_imageListModel.length);
  
    if (_imageListModel.isNotEmpty) {
      for (var element in _imageListModel) {

          print(element.image.path);      
          var request = MultipartRequest(
            'POST',
            Uri.parse('https://invulnerable-bastille-39566-a52ccd510b57.herokuapp.com/api/imagen/saveImage'),
          );
          request.files.add(await MultipartFile.fromPath('image', element.image.path));
          request.fields['t_general_data_id'] = '7';
          request.fields['CID'] = '19763313';
          request.fields['Nivel1'] = element.imagelUploadModel.nivel1;
          request.fields['Nivel2'] = element.imagelUploadModel.nivel2;
          request.fields['Description'] = element.imagelUploadModel.description;
          request.fields['nro_imagen'] = element.imagelUploadModel.nro_imagen;
          request.fields['createdAd'] = element.imagelUploadModel.registro;
          request.fields['eliminacion_logica'] = element.imagelUploadModel.eliminacion_logica;

          print(request.fields);
          var response = await request.send();

          if (response.statusCode == 200) {
            print('Image uploaded successfully');
          } else {
            print('Image upload failed');
          }
      }
    }


  }




    // final serverUrl = 'http://192.168.215.215:3001/api/imagen/saveImages'; // Cambia esto a la URL de tu servidor

    // var request = MultipartRequest('POST', Uri.parse(serverUrl));

    // ImageUploadData a1 = ImageUploadData(tGeneralDataId: '7', cid: '19763313', nivel1: 'test from app 1', nivel2: 'test from app 1', description: 'description',nro_imagen: '7',eliminacion_logica: '1');

    // for (var imageData in _imageListModel) {
    //   request.files.add(await MultipartFile.fromPath('imagess', imageData.image.path));
    //   request.fields['t_general_data_id'] = a1.tGeneralDataId;
    //   request.fields['CID'] = a1.cid;
    //   request.fields['Nivel1'] = a1.nivel1;
    //   request.fields['Nivel2'] = a1.nivel2;
    //   request.fields['Description'] = a1.description;
    // }

    // var response = await request.send();

    // if (response.statusCode == 200) {
    //   print('Images uploaded successfully');
    // } else {
    //   print('Images upload failed');
    // }
    
}




