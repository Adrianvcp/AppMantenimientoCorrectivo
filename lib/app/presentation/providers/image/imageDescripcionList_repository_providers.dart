import 'package:app_manteni_correc/app/data/repositories_implementation/image_repository_implementation.dart';
import 'package:app_manteni_correc/app/data/repositories_implementation/informeList_repository_impl.dart';
import 'package:app_manteni_correc/app/data/services/image.dart';
import 'package:app_manteni_correc/app/data/services/informe_list_api.dart';
import 'package:app_manteni_correc/app/domain/repositories/image_repository.dart';
import 'package:app_manteni_correc/app/domain/repositories/informeList_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http; 


final imageDescripcionListRepositoryProvider = Provider<ImageRepository>((ref) {
  return ImageRepositoryImpl(ImageAPI(http.Client()));
});
