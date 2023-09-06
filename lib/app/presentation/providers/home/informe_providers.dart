import 'package:app_manteni_correc/app/domain/models/informe/informe_list.dart';
import 'package:app_manteni_correc/app/domain/repositories/informeList_repository.dart';
import 'package:app_manteni_correc/app/presentation/providers/home/informes_repository_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final informeProvider = StateNotifierProvider.autoDispose.family<InformeNotifier, InformeState, String>(
  (ref, informeId ) {
    
    final informeRepository = ref.watch(homeRepositoryProvider);
  
    return InformeNotifier(
      informeRepository: informeRepository, 
      informeId: informeId
    );
});



class InformeNotifier extends StateNotifier<InformeState> {

  final InformeListRepository informeRepository;
  DateTime nowDateTime = DateTime.now();

  InformeNotifier({
    required this.informeRepository,
    required String informeId,
  }): super(InformeState(id: informeId )) {
    loadInforme();
  }

  InformeListDetail newEmptyInforme() {
    return InformeListDetail(
      cid: '', 
      name: '', 
      phonenumber: '', 
      ticket: '', 
      backupequipment: '|||', 
      addresssede: '', 
      sede: '', 
      datetime: '${nowDateTime.day.toString().padLeft(2,'0')}/${nowDateTime.month.toString().padLeft(2,'0')}/${nowDateTime.year} ${nowDateTime.hour.toString().padLeft(2,'0')}:${nowDateTime.minute.toString().padLeft(2,'0')}', 
      clientname: '',
      clientphonenumber: '',
      observation: '',
      requirement:Requirement.fromJson({'SCTR': {'CONTRATA': false, 'SUPERVISOR': false},'PRUEBA COVID-19': {'CONTRATA': false, 'SUPERVISOR': false} }),
      idUser: 0,

    );
  }


  Future<void> loadInforme() async {

    try {

      if ( state.id == 'new' ) {
        state = state.copyWith(
          isLoading: false,
          informeDetail: newEmptyInforme(),
        );  
        return;
       }
      
        final informe = await informeRepository.getInformeById(state.id);

      state = state.copyWith(
        isLoading: false,
        informeDetail: informe
      );
      
    } catch (e) {
      // 404 product not found
    }

  }

}




class InformeState {

  final String id;
  final InformeListDetail? informeDetail;
  final bool isLoading;
  final bool isSaving;

  InformeState({
    required this.id, 
    this.informeDetail, 
    this.isLoading = true, 
    this.isSaving = false,
  });

  InformeState copyWith({
    String? id,
    InformeListDetail? informeDetail,
    bool? isLoading,
    bool? isSaving,
  }) => InformeState(
    id: id ?? this.id,
    informeDetail: informeDetail ?? this.informeDetail,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving,
  );
  
}