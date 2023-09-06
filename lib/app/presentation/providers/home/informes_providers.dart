import 'package:app_manteni_correc/app/domain/models/informe/informe_list.dart';
import 'package:app_manteni_correc/app/domain/repositories/informeList_repository.dart';
import 'package:app_manteni_correc/app/presentation/providers/home/informes_repository_providers.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


final nowHomeProvider = StateNotifierProvider<InformesNotifier, InformesState>((ref) {

  final informeListRepository = ref.watch( homeRepositoryProvider );

  return InformesNotifier(
    informeListRepository: informeListRepository
  );
});


class InformesNotifier extends StateNotifier<InformesState> {
  
  final InformeListRepository informeListRepository;

  InformesNotifier({
    required this.informeListRepository,
  }): super(InformesState()){
    loadNextPage();
  }

  Future<bool> createOrUpdateInforme( Map<String,dynamic> informeLike ) async {

    try {
      final informe = await informeListRepository.createUpdateInforme(informeLike);

      print('informe: ${informe.cid}');
      final isProductInList = state.informes.any((element) => element.cid == informe.cid );

      if ( !isProductInList ) {
        state = state.copyWith(
          informes: [...state.informes, informe]
        );
        return true;
      }

      state = state.copyWith(
        informes: state.informes.map(
          (element) => ( element.cid == informe.cid ) ? informe : element,
        ).toList()
      );
      return true;

    } catch (e) {
      return false;
    }


  }

  Future loadNextPage() async {

    if ( state.isLoading || state.isLastPage ) return;

    state = state.copyWith( isLoading: true );


    final informes = await informeListRepository
      .getInformeListData();

    if ( informes.isEmpty ) {
      state = state.copyWith(
        isLoading: false,
        isLastPage: true
      );
      return;
    }

    state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      offset: state.offset + 10,
      informes: [...state.informes, ...informes ]
    );


  }

}
  class InformesState {

  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<InformeListDetail> informes;

  InformesState({
    this.isLastPage = false, 
    this.limit = 10, 
    this.offset = 0, 
    this.isLoading = false, 
    this.informes = const[]
  });

  InformesState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<InformeListDetail>? informes,
  }) => InformesState(
    isLastPage: isLastPage ?? this.isLastPage,
    limit: limit ?? this.limit,
    offset: offset ?? this.offset,
    isLoading: isLoading ?? this.isLoading,
    informes: informes ?? this.informes,
  );
}