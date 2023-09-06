
import 'package:app_manteni_correc/app/data/repositories_implementation/image_repository_implementation.dart';
import 'package:app_manteni_correc/app/data/services/image.dart';
import 'package:app_manteni_correc/app/domain/models/image/imageDescription.dart';
import 'package:app_manteni_correc/app/domain/repositories/image_repository.dart';
import 'package:app_manteni_correc/app/presentation/providers/image/imageDescripcionList_repository_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http; 


final nowImgDescripcionProvider = StateNotifierProvider<ImageDescripcionProviderModel, ImageDescripcionList>((ref) {

  final informeListRepository = ref.watch( imageDescripcionListRepositoryProvider );

  return ImageDescripcionProviderModel(imageRepository: informeListRepository);
});

class ImageDescripcionProviderModel extends StateNotifier<ImageDescripcionList> {

  final ImageRepository imageRepository;

  ImageDescripcionProviderModel({
    required this.imageRepository,
  }): super(ImageDescripcionList(imageDescripcionList: [])){
    load();
  }

  void updateSelected(String descripcion) {

    final updatedDescripcionList = state.imageDescripcionList.map((item) {
      if (item.descripcion == descripcion) {
        return ImageDescripcion(id: item.id, titulo: item.titulo, subtitulo: item.subtitulo, descripcion: item.descripcion,imageAssigned: true);
      } else {
        return item;
      }
    }).toList();

    state = ImageDescripcionList(imageDescripcionList: []);
    state = ImageDescripcionList(imageDescripcionList: updatedDescripcionList);

  }
  
  Future load() async {

    if(state.imageDescripcionList.length == 0) {
      final imgdescription = await imageRepository.getImageDescriptionList();

      if ( imgdescription.isEmpty ) {
        state = ImageDescripcionList(imageDescripcionList: []);
        return;
      }

      state = ImageDescripcionList(imageDescripcionList: imgdescription);

    }else{
      print('tiene informacion');
    }
    

  }

}
