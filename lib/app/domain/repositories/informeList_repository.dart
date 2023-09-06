import 'package:app_manteni_correc/app/domain/models/informe/informe_list.dart';

abstract class InformeListRepository{
   Future<List<InformeListDetail>> getInformeListData();
   Future<InformeListDetail> createUpdateInforme( Map<String,dynamic> informeLike );
   Future<InformeListDetail> getInformeById(String cid);
}