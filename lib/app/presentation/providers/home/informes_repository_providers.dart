import 'package:app_manteni_correc/app/data/repositories_implementation/informeList_repository_impl.dart';
import 'package:app_manteni_correc/app/data/services/informe_list_api.dart';
import 'package:app_manteni_correc/app/domain/repositories/informeList_repository.dart';
import 'package:app_manteni_correc/app/presentation/providers/auth/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http; 


final homeRepositoryProvider = Provider<InformeListRepository>((ref) {

  final idUser = ref.watch( authProvider ).user?.userDetails.idUser ?? '';

  return InformeListRepositoryImpl(InformeListAPI(http.Client()),idUser);
});
