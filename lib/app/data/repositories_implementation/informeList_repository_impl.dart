import 'package:app_manteni_correc/app/data/services/informe_list_api.dart';
import 'package:app_manteni_correc/app/domain/models/informe/informe_list.dart';
import 'package:app_manteni_correc/app/domain/repositories/informeList_repository.dart';

class InformeListRepositoryImpl implements InformeListRepository {
  final InformeListAPI _informeListAPI;
  final idUser;

  InformeListRepositoryImpl(this._informeListAPI, this.idUser);
  

  @override
  Future<List<InformeListDetail>> getInformeListData() {
    return _informeListAPI.getInformeListData(idUser);
  }

  @override
  Future<InformeListDetail> createUpdateInforme(Map<String, dynamic> informeLike) {
    return _informeListAPI.createUpdateInforme(informeLike,idUser);
  }

  @override
  Future<InformeListDetail> getInformeById(String cid) {
    return _informeListAPI.getInformeById(cid);
  }
  
}