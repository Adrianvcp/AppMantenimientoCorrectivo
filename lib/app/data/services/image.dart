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
  final _localUrl ='http://192.168.89.215:3001/api';

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
          // request.fields['createdAd'] = element.imagelUploadModel.registro;
          request.fields['eliminacion_logica'] = element.imagelUploadModel.eliminacion_logica!;

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

  //Carga UNA imagen al servidor FTP y la informacion en la BD
  Future<ImageUploadData> uploadImageFtpBD(ImageModel _imageModel,String cid) async {
    
      // if(_imageModel.image == null){
      //   throw Exception('Image is null');
      // }

      var request = MultipartRequest(
        'POST',
        Uri.parse('https://invulnerable-bastille-39566-a52ccd510b57.herokuapp.com/api/imagen/saveImage'),
      );

      request.files.add(await MultipartFile.fromPath('image', _imageModel.image.path));
      request.fields['t_general_data_id'] = '7';
      request.fields['CID'] = '19763313';
      request.fields['Nivel1'] = _imageModel.imagelUploadModel.nivel1;
      request.fields['Nivel2'] = _imageModel.imagelUploadModel.nivel2;
      request.fields['Description'] = _imageModel.imagelUploadModel.description;
      request.fields['nro_imagen'] = _imageModel.imagelUploadModel.nro_imagen;

      var response = await request.send();
      var respStr = await Response.fromStream(response);

      final resultjson = jsonDecode(respStr.body) as Map<String, dynamic>;
      print(resultjson['image']);

      final result =  ImageUploadData.fromJson(resultjson['image']);
      print(result);
      print(result.id);
      // final id = int.parse(result['image']['id']);

      if (response.statusCode == 200) {
        print('Image uploaded');
        return result;
      } else {
        print('Image upload failed');
        return result;
      }
      
  }

  //Carga UNA imagen al servidor FTP y la informacion en la BD
  Future<void> updateDescriptionImage(int id,String description) async {
    
    final Map<String, dynamic> bodySend = {
      'id': id,
      'Description': description,
    };

    final response = await _client.patch(
        Uri.parse('$_baseUrl/imagen/editImage'),headers: {"Content-Type": "application/json"},
        body: json.encode(bodySend));

    print(bodySend);
    print(response.body);
      if (response.statusCode == 200) {
        print('Description uploaded');
      } else {
        print('Description failed');
      }
      
  }


    // print('image: ${_imageModel.image}');

    // print('cid: ${_imageModel.imagelUploadModel.cid}');
    // print('description: ${_imageModel.imagelUploadModel.description}');
    // print('eliminacion_logica: ${_imageModel.imagelUploadModel.eliminacion_logica}');
    // print('nivel1: ${_imageModel.imagelUploadModel.nivel1}');
    // print('nivel2: ${_imageModel.imagelUploadModel.nivel2}');
    // print('nro_imagen: ${_imageModel.imagelUploadModel.nro_imagen}');
    // print('tGeneralDataId: ${_imageModel.imagelUploadModel.tGeneralDataId}');

    // print('cid: ${_imageModel.index}');

      // print('path: ${_imageModel.image.path}');




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




