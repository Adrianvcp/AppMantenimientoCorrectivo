
import 'package:app_manteni_correc/app/data/repositories_implementation/image_repository_implementation.dart';
import 'package:app_manteni_correc/app/domain/models/image/image.dart';
import 'package:app_manteni_correc/app/domain/models/image/imageDescription.dart';
import 'package:app_manteni_correc/app/presentation/providers/image/image_provider_model.dart';

abstract class ImageRepository{
  
  Future<List<ImageDescripcion>> getImageDescriptionList();
  Future<void> uploadImage(List<ImageModel> imageListModel,String cid);
  Future<ImageUploadData> uploadImageFtpBD(ImageModel imageModel,String cid);
  Future<void> updateDescriptionImage(int id,String newDescription);
  Future<void> deleteImage(ImageModel imageModel,String cid);

}

