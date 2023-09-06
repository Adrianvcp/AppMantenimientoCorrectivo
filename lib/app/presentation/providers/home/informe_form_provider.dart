import 'package:app_manteni_correc/app/domain/models/informe/informe_list.dart';
import 'package:app_manteni_correc/app/presentation/global/validators/addresssede.dart';
import 'package:app_manteni_correc/app/presentation/global/validators/cid.dart';
import 'package:app_manteni_correc/app/presentation/global/validators/clientename.dart';
import 'package:app_manteni_correc/app/presentation/global/validators/clientephone.dart';
import 'package:app_manteni_correc/app/presentation/global/validators/name.dart';
import 'package:app_manteni_correc/app/presentation/global/validators/phonenumber.dart';
import 'package:app_manteni_correc/app/presentation/global/validators/sede.dart';
import 'package:app_manteni_correc/app/presentation/global/validators/ticket.dart';
import 'package:app_manteni_correc/app/presentation/providers/home/informes_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';


final informeFormProvider = StateNotifierProvider.autoDispose.family<InformeFormNotifier, InformeFormState, InformeListDetail>(
  (ref, informe) {

    // final createUpdateCallback = ref.watch( productsRepositoryProvider ).createUpdateProduct;
    final createUpdateCallback = ref.watch( nowHomeProvider.notifier ).createOrUpdateInforme;

    return InformeFormNotifier(
      informe: informe,
      onSubmitCallback: createUpdateCallback,
    );
  }
);

class InformeFormNotifier extends StateNotifier<InformeFormState> {

  final Future<bool> Function( Map<String,dynamic> informeLike )? onSubmitCallback;

  InformeFormNotifier({
    this.onSubmitCallback,
    required InformeListDetail informe,
  }): super(
    InformeFormState(
      cid: Cid.dirty(informe.cid),
      name: Name.dirty(informe.name),
      phonenumber: PhoneNumber.dirty(informe.phonenumber),
      ticket: Ticket.dirty(informe.ticket),
      backupequipment: informe.backupequipment.split('|'),
      addresssede: Addresssede.dirty(informe.addresssede),
      sede: Sede.dirty(informe.sede),
      datetime: informe.datetime,
      clientname: ClienteName.dirty(informe.clientname),
      clientphonenumber: ClientePhone.dirty(informe.clientphonenumber),
      observation: informe.observation,
      sctrcontrata: informe.requirement.sctr.contrata,
      sctrsupervisor: informe.requirement.sctr.supervisor,
      pruebacontrata: informe.requirement.pruebacovid19.contrata,
      pruebasupervisor: informe.requirement.pruebacovid19.supervisor,
      iduser: informe.idUser,
    )
  );

  Future<bool> onFormSubmit() async {
    _touchedEverything();
    if ( !state.isFormValid ) return false;

    if ( onSubmitCallback == null ) return false;

    print(state);
    print(state.cid);
    print(state.cid.value);
    print(state.phonenumber.value);
    print(state.ticket.value);
    print(state.backupequipment.join('|'));
    print(state.addresssede.value);

    final productLike = {
      'CID' : (state.cid == 'new') ? null : state.cid.value,
      'Name': state.name.value,
      'PhoneNumber': state.phonenumber.value,
      'Ticket': state.ticket.value,
      'BackupEquipment': state.backupequipment.join('|'),
      'AddressSede': state.addresssede.value,
      'Sede': state.sede.value,
      'DateTime': state.datetime,
      'ClientName': state.clientname.value,
      'ClientPhoneNumber': state.clientphonenumber.value,
      'Requirement': {'SCTR': {'CONTRATA': state.sctrcontrata, 'SUPERVISOR': state.sctrsupervisor},'PRUEBA COVID-19': {'CONTRATA': state.pruebacontrata, 'SUPERVISOR': state.pruebasupervisor} },
      'Observation': state.observation,
      'idUser': state.iduser
    };

    print(productLike);

    try {
      return await onSubmitCallback!( productLike );
    } catch (e) {
      return false;
    }

  }


  void _touchedEverything() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        Cid.dirty(state.cid.value),
        Name.dirty(state.name.value),
        PhoneNumber.dirty(state.phonenumber.value),
        Ticket.dirty(state.ticket.value),
        Addresssede.dirty(state.addresssede.value),
        Sede.dirty(state.sede.value),
        ClienteName.dirty(state.clientname.value),
        ClientePhone.dirty(state.clientphonenumber.value),
      ]),
    );
  }

  void onCidChanged( String value ) {
    state = state.copyWith(
      cid: Cid.dirty(value),
      isFormValid: Formz.validate([
        Cid.dirty(value),
        Name.dirty(state.name.value),
        PhoneNumber.dirty(state.phonenumber.value),
        Ticket.dirty(state.ticket.value),
        Addresssede.dirty(state.addresssede.value),
        Sede.dirty(state.sede.value),
        ClienteName.dirty(state.clientname.value),
        ClientePhone.dirty(state.clientphonenumber.value),
      ])
    );
  }
  void onNameChanged( String value ) {
    state = state.copyWith(
      name: Name.dirty(value),
      isFormValid: Formz.validate([
        Cid.dirty(state.cid.value),
        Name.dirty(value),
        PhoneNumber.dirty(state.phonenumber.value),
        Ticket.dirty(state.ticket.value),
        Addresssede.dirty(state.addresssede.value),
        Sede.dirty(state.sede.value),
        ClienteName.dirty(state.clientname.value),
        ClientePhone.dirty(state.clientphonenumber.value),
      ])
    );
  }
  void onPhoneNumberChanged( String value ) {
    state = state.copyWith(
      phonenumber: PhoneNumber.dirty(value),
      isFormValid: Formz.validate([
        Cid.dirty(state.cid.value),
        Name.dirty(state.name.value),
        PhoneNumber.dirty(value),
        Ticket.dirty(state.ticket.value),
        Addresssede.dirty(state.addresssede.value),
        Sede.dirty(state.sede.value),
        ClienteName.dirty(state.clientname.value),
        ClientePhone.dirty(state.clientphonenumber.value),
      ])
    );
  }
  void onTicketChanged( String value ) {
    state = state.copyWith(
      ticket: Ticket.dirty(value),
      isFormValid: Formz.validate([
        Cid.dirty(state.cid.value),
        Name.dirty(state.name.value),
        PhoneNumber.dirty(state.phonenumber.value),
        Ticket.dirty(value),
        Addresssede.dirty(state.addresssede.value),
        Sede.dirty(state.sede.value),
        ClienteName.dirty(state.clientname.value),
        ClientePhone.dirty(state.clientphonenumber.value),
      ])
    );
  }
  void onAddresssedeChanged( String value ) {
    state = state.copyWith(
      addresssede: Addresssede.dirty(value),
      isFormValid: Formz.validate([
        Cid.dirty(state.cid.value),
        Name.dirty(state.name.value),
        PhoneNumber.dirty(state.phonenumber.value),
        Ticket.dirty(state.ticket.value),
        Addresssede.dirty(value),
        Sede.dirty(state.sede.value),
        ClienteName.dirty(state.clientname.value),
        ClientePhone.dirty(state.clientphonenumber.value),
      ])
    );
  }
  void onSedeChanged( String value ) {
    state = state.copyWith(
      sede: Sede.dirty(value),
      isFormValid: Formz.validate([
        Cid.dirty(state.cid.value),
        Name.dirty(state.name.value),
        PhoneNumber.dirty(state.phonenumber.value),
        Ticket.dirty(state.ticket.value),
        Addresssede.dirty(state.addresssede.value),
        Sede.dirty(value),
        ClienteName.dirty(state.clientname.value),
        ClientePhone.dirty(state.clientphonenumber.value),
      ])
    );
  }
  void onClienteNameChanged( String value ) {
    state = state.copyWith(
      clientname: ClienteName.dirty(value),
      isFormValid: Formz.validate([
        Cid.dirty(state.cid.value),
        Name.dirty(state.name.value),
        PhoneNumber.dirty(state.phonenumber.value),
        Ticket.dirty(state.ticket.value),
        Addresssede.dirty(state.addresssede.value),
        Sede.dirty(state.sede.value),
        ClienteName.dirty(value),
        ClientePhone.dirty(state.clientphonenumber.value),
      ])
    );
  }
  void onClientePhoneChanged( String value ) {
    state = state.copyWith(
      clientphonenumber: ClientePhone.dirty(value),
      isFormValid: Formz.validate([
        Cid.dirty(state.cid.value),
        Name.dirty(state.name.value),
        PhoneNumber.dirty(state.phonenumber.value),
        Ticket.dirty(state.ticket.value),
        Addresssede.dirty(state.addresssede.value),
        Sede.dirty(state.sede.value),
        ClienteName.dirty(state.clientname.value),
        ClientePhone.dirty(value),
      ])
    );
  }

  void onSctrContrataChanged( bool sctrcontrata ) {
    state = state.copyWith(
      sctrcontrata: sctrcontrata
    );
  }

  void onSctrSupervisorChanged( bool sctrsupervisor ) {
    state = state.copyWith(
      sctrsupervisor: sctrsupervisor
    );
  }

  void onPruebaContrataChanged( bool pruebacontrata ) {
    state = state.copyWith(
      pruebacontrata: pruebacontrata
    );
  }

  void onPruebaSupervisorChanged( bool pruebasupervisor ) {
    state = state.copyWith(
      pruebasupervisor: pruebasupervisor
    );
  }
  void onDateTimeChanged( DateTime datetime ) {
    String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(datetime);
    state = state.copyWith(
      datetime: formattedDate
    );
  }
  void onBackupChanged( String backupequipment, int index ) {
    if(state.backupequipment.elementAt(index)!=null){
      state.backupequipment.removeAt(index);
      state.backupequipment.insert(index,backupequipment);
    }
    else{
    state.backupequipment.insert(index,backupequipment);
    }
    /*
    state = state.copyWith(
      backupequipment: backupequipment.insert(1, "element")
    );*/
  }
 /*
   void updateBackupChanged( String path ) {
    state = state.copyWith(
      backupequipment: path
   );
  }
 */
}





class InformeFormState {

  final bool isFormValid;
  final Cid cid;
  final Name name;
  final PhoneNumber phonenumber;
  final Ticket ticket;
  final List<String> backupequipment;
  final Addresssede addresssede;
  final Sede sede;
  final String datetime;
  final ClienteName clientname;
  final ClientePhone clientphonenumber;
  final String? observation;
  final bool sctrcontrata;
  final bool sctrsupervisor;
  final bool pruebacontrata;
  final bool pruebasupervisor;
  final int? iduser;

  InformeFormState({
    this.isFormValid = false, 
    this.cid=const Cid.dirty(''), 
    this.name=const Name.dirty(''), 
    this.phonenumber=const PhoneNumber.dirty(''), 
    this.ticket=const Ticket.dirty(''), 
    this.backupequipment= const ['',''], 
    this.addresssede=const Addresssede.dirty(''),
    this.sede=const Sede.dirty(''), 
    this.datetime="", 
    this.clientname=const ClienteName.dirty(''),
    this.clientphonenumber=const ClientePhone.dirty(''), 
    this.observation,
    this.sctrcontrata = false,
    this.sctrsupervisor = false,
    this.pruebacontrata = false,
    this.pruebasupervisor = false,
    this.iduser
  });

  InformeFormState copyWith({
    bool? isFormValid,
    Cid? cid,
    Name? name,
    PhoneNumber? phonenumber,
    Ticket? ticket,
    List<String>? backupequipment,
    Addresssede? addresssede,
    Sede? sede,
    String? datetime,
    ClienteName? clientname,
    ClientePhone? clientphonenumber,
    String? observation,
    bool? sctrcontrata,
    bool? sctrsupervisor,
    bool? pruebacontrata,
    bool? pruebasupervisor,
    int? iduser,
  }) => InformeFormState(
    isFormValid: isFormValid ?? this.isFormValid,
    cid: cid ?? this.cid,
    name: name ?? this.name,
    phonenumber: phonenumber ?? this.phonenumber,
    ticket: ticket ?? this.ticket,
    backupequipment: backupequipment ?? this.backupequipment,
    addresssede: addresssede ?? this.addresssede,
    sede: sede ?? this.sede,
    datetime: datetime ?? this.datetime,
    clientname: clientname ?? this.clientname,
    clientphonenumber: clientphonenumber ?? this.clientphonenumber,
    observation: observation ?? this.observation,
    sctrcontrata: sctrcontrata?? this.sctrcontrata,
    sctrsupervisor: sctrsupervisor?? this.sctrsupervisor,
    pruebacontrata: pruebacontrata?? this.pruebacontrata,
    pruebasupervisor: pruebasupervisor?? this.pruebasupervisor,
    iduser: iduser ?? this.iduser,
  );


}