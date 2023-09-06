
import 'package:app_manteni_correc/app/data/services/image.dart';
import 'package:app_manteni_correc/app/domain/models/image/image.dart';
import 'package:app_manteni_correc/app/domain/models/image/imageDescription.dart';
import 'package:app_manteni_correc/app/domain/repositories/image_repository.dart';
import 'package:app_manteni_correc/app/presentation/providers/image/image_provider_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ImageRepositoryImpl implements ImageRepository {
  final ImageAPI _imageAPI;

  ImageRepositoryImpl(this._imageAPI);
  
  @override
  Future<List<ImageDescripcion>> getImageDescriptionList() {
    // TODO: implement getImageDescriptionList
    return _imageAPI.getImageDescripcionList();
  }
  
  @override
  Future<void> uploadImage(List<ImageModel> imgList,String cid) {
    return _imageAPI.uploadImage(imgList,cid);
  }
  

}


  // Future<Result> uploadImage({
  //   required String tGeneralDataId,
  //   required String cid,
  //   required String nivel1,
  //   required String nivel2,
  //   required String description,
  //   required Uint8List imageBytes,
  // }) 
  // async {
  //   final Uri uri = Uri.parse('URL_DEL_BACKEND_AQUI'); // Reemplaza con la URL de tu endpoint

  //   final http.MultipartRequest request = http.MultipartRequest('POST', uri);

  //   final http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
  //     'image',
  //     imageBytes,
  //     filename: 'image.png',
  //   );

  //   request.fields['t_general_data_id'] = tGeneralDataId;
  //   request.fields['CID'] = cid;
  //   request.fields['Nivel1'] = nivel1;
  //   request.fields['Nivel2'] = nivel2;
  //   request.fields['Description'] = description;

  //   request.files.add(multipartFile);

  //   try {
  //     final response = await request.send();
      
  //     if (response.statusCode == 200) {
  //       return Result(success: true, message: 'Imagen enviada exitosamente');
  //     } else {
  //       return Result(success: false, message: 'Error al enviar la imagen');
  //     }
  //   } catch (e) {
  //     return Result(success: false, message: 'Error al enviar la imagen');
  //   }
  // }



