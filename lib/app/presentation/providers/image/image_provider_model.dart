import 'package:app_manteni_correc/app/data/devices/LocationRepository.dart';
import 'package:app_manteni_correc/app/data/repositories_implementation/image_repository_implementation.dart';
import 'package:app_manteni_correc/app/data/services/image.dart';
import 'package:app_manteni_correc/app/domain/models/image/image.dart';
import 'package:app_manteni_correc/app/domain/repositories/image_repository.dart';
import 'package:app_manteni_correc/app/domain/repositories/location_repository.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart';
import 'package:http/http.dart' as http;

class ImageModel {
  final XFile image;
  final ImageUploadData imagelUploadModel;
  final String index;

  ImageModel(this.index,this.image,this.imagelUploadModel);
}

class ImageListModel {
  final String id;
  final List<ImageModel> images;

  ImageListModel(this.id,this.images);
}

class ImageProviderModel extends StateNotifier<ImageListModel> {

  ImageProviderModel(String id, List<ImageModel> images) : super(ImageListModel(id, images));

  List<ImageModel> getImages() {
    return state.images;
  }

  void addImage(String id,XFile image,ImageUploadData imgUploadData,String indexImage) {
    final updatedImageList = [...state.images, ImageModel(indexImage,image,imgUploadData)];
    state = ImageListModel(id,updatedImageList);
  }

  void removeImage(String id, int index) {
    List<ImageModel> updatedImageList = List.from(state.images)..removeAt(index);
    state = ImageListModel(id,updatedImageList);
  }

  void updateImageDescription(String newDescription, int index) {
    final updatedImages = state.images.map((imageModel) {
      if (imageModel.index == index.toString()) {
        final updatedImage = imageModel.imagelUploadModel.copyWith(description: newDescription);
        return ImageModel(imageModel.index, imageModel.image, updatedImage);
      }
      return imageModel;
    }).toList();

    state = ImageListModel(state.id, updatedImages);
  }
  
}

final imageProviderFamily = StateNotifierProvider.family<ImageProviderModel, ImageListModel,String>((ref, id) {
  print('imageProviderFamily');
  return ImageProviderModel(id, []);
});

final updateImageDescriptionProvider = Provider.family<void Function(String,int), String>((ref, id) {
  print('aaaaaa');
  return (String newDescription,int index) {
    final imageProvider = ref.read(imageProviderFamily(id));
    final imageProviderNotifier = ref.watch(imageProviderFamily(id).notifier);

    final images = imageProvider.images;

    // Encuentra la imagen que deseas actualizar (por ejemplo, la que tiene el índice 2).
    final updatedImages = images.map((imageModel) {
      print('----------------');
      print(imageModel.index);
      print(index);
      print('---------------');
      if (imageModel.index == index) {
        final updatedImage = imageModel.imagelUploadModel.copyWith(description: newDescription);
        return ImageModel(imageModel.index, imageModel.image, updatedImage);
      }
      return imageModel;
    }).toList();

    // Actualiza la lista de imágenes en el proveedor.
    imageProviderNotifier.state = ImageListModel(id, updatedImages);
  };
});


final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  return LocationRepositoryImpl(); 
});

final imageUseCaseProvider = Provider((ref) => ImageUseCase());

// final imageUploadNotifierProvider = StateNotifierProvider<ImageUploadNotifier, AsyncValue<Result>>(
//   (ref) => ImageUploadNotifier(ref.read),
// );

// class ImageUploadNotifier extends StateNotifier<AsyncValue<Result>> {
//   final Reader _read;

//   ImageUploadNotifier(this._read) : super(AsyncValue.loading()) {
//     // Inicializa cualquier otro estado necesario aquí
//   }

//   Future<void> uploadImage(ImageData data) async {
//     state = AsyncValue.loading();

//     final useCase = _read(imageUploadUseCaseProvider);
//     final result = await useCase.uploadImage(data);

//     state = AsyncValue.data(result);
//   }
// }


final httpProvider = Provider<http.Client>((ref) => http.Client());

final imageRepositoryProvider = Provider<ImageRepository>((ref) { 
  final httpClient = ref.read(httpProvider);
  final imageAPI = ImageAPI(httpClient);
  return ImageRepositoryImpl(imageAPI);
});