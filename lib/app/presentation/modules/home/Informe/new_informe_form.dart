import 'package:app_manteni_correc/app/domain/models/informe/informe_list.dart';
import 'package:app_manteni_correc/app/presentation/global/app_default.dart';
import 'package:app_manteni_correc/app/presentation/modules/Image/addImage.dart';
import 'package:app_manteni_correc/app/presentation/modules/home/Informe/components/custom_product_field.dart';
import 'package:app_manteni_correc/app/presentation/modules/home/Informe/components/full_screen_loader.dart';
import 'package:app_manteni_correc/app/presentation/providers/home/informe_form_provider.dart';
import 'package:app_manteni_correc/app/presentation/providers/home/informe_providers.dart';
import 'package:app_manteni_correc/app/presentation/providers/image/imageDescripcion_provider.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class InformeScreen extends ConsumerWidget {
  final String cid;

  const InformeScreen({super.key, required this.cid});

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Informe Registrado')));
  }
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final informeState = ref.watch(informeProvider(cid));
    final _controllerList2Provider = StateNotifierProvider<ControllerList2,
            List<AutoDisposeProvider<TextEditingController>>>(
        (ref) => ControllerList2());

    final nowimgdescripcionlist = ref.watch( nowImgDescripcionProvider );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registrar Informe'),
        ),
        body: informeState.isLoading
            ? const FullScreenLoader()
            : _InformeView(
                informe: informeState.informeDetail!, _controllerList2Provider),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('click');
          
            // if (informeState.informeDetail == null) return;
            // final list = ref.watch(_controllerList2Provider);
            // list;

        Navigator.push(context,MaterialPageRoute(builder: (context) => AddImage(cid: '123')));

            // ref.read(informeFormProvider(informeState.informeDetail!).notifier)
            //     .onFormSubmit()
            //     .then((value) {
            //   if (!value) return;
            //   // showSnackbar(context);

            //   print('valor de cid en la clase new_inform_form $cid');
            //   print('informacion : ${informeState.informeDetail!.cid.toString()}');
            //   print(informeState.informeDetail!.cid.toString());
            //   print(informeFormProvider(informeState.informeDetail!));
            //               Navigator.push(context,MaterialPageRoute(builder: (context) => AddImage(cid: cid)));

              
            // });
          },
          child: const Icon(Icons.save_as_outlined),
        ),
      ),
    );
  }
}

class _InformeView extends ConsumerWidget {
  final InformeListDetail informe;
  final _controllerList2Provider;
  const _InformeView(this._controllerList2Provider, {required this.informe});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        _InformeInformation(informe: informe, _controllerList2Provider),

      ],
    );
  }
}

class ControllerList2
    extends StateNotifier<List<AutoDisposeProvider<TextEditingController>>> {
  ControllerList2({String? text}) : super([]);

  AutoDisposeProvider<TextEditingController> _createControllerProvider() {
    return Provider.autoDispose((ref) => TextEditingController());
  }

  void add() {
    state = [...state, _createControllerProvider()];
  }

  void remove(int index) {
    if (index < 0 || index >= state.length) {
      return;
    }
    final target = state[index];
    state.remove(target);
    state = [...state];
  }
}

class _InformeInformation extends ConsumerWidget {
  final _controllerList2Provider;
  final InformeListDetail informe;
  _InformeInformation(this._controllerList2Provider, {required this.informe});

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(_controllerList2Provider);
    final informeForm = ref.watch(informeFormProvider(informe));
    List<String> data = [];
    data.insert(0, "");
    data.insert(1, "");
    data.insert(2, "");
    data.insert(3, "");
    data.insert(4, "");

    return Form(
      child: Container(
        padding: const EdgeInsets.all(AppDefaults.padding),
        margin: const EdgeInsets.all(AppDefaults.margin),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: AppDefaults.borderRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('CID'),
            const SizedBox(height: 8),
            CustomProductField(
              isTopField: true,
              initialValue: informeForm.cid.value,
              onChanged:
                  ref.read(informeFormProvider(informe).notifier).onCidChanged,
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text('Personal de Campo'),
            const SizedBox(height: 8),
            CustomProductField(
              isTopField: true,
              initialValue: informeForm.name.value,
              onChanged:
                  ref.read(informeFormProvider(informe).notifier).onNameChanged,
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text('Celular'),
            const SizedBox(height: 8),
            CustomProductField(
              isTopField: true,
              initialValue: informeForm.phonenumber.value,
              onChanged: ref
                  .read(informeFormProvider(informe).notifier)
                  .onPhoneNumberChanged,
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text('Ticket'),
            const SizedBox(height: 8),
            CustomProductField(
              isTopField: true,
              initialValue: informeForm.ticket.value,
              onChanged: ref
                  .read(informeFormProvider(informe).notifier)
                  .onTicketChanged,
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text('Dirección Sede'),
            const SizedBox(height: 8),
            CustomProductField(
              isTopField: true,
              initialValue: informeForm.addresssede.value,
              onChanged: ref
                  .read(informeFormProvider(informe).notifier)
                  .onAddresssedeChanged,
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text('Sede'),
            const SizedBox(height: 8),
            CustomProductField(
              isTopField: true,
              initialValue: informeForm.sede.value,
              onChanged:
                  ref.read(informeFormProvider(informe).notifier).onSedeChanged,
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text("Fecha y Hora"),
            const SizedBox(height: 8),
            DateTimeFormField(
              dateFormat: DateFormat("dd/MM/yyyy HH:mm"),
              initialValue:
                  DateFormat("dd/MM/yyyy").parse(informeForm.datetime),
              onDateSelected: ref
                  .read(informeFormProvider(informe).notifier)
                  .onDateTimeChanged,
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text('Nombre Cliente'),
            const SizedBox(height: 8),
            CustomProductField(
              isTopField: true,
              initialValue: informeForm.clientname.value,
              onChanged: ref
                  .read(informeFormProvider(informe).notifier)
                  .onClienteNameChanged,
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text('Celular Cliente'),
            const SizedBox(height: 8),
            CustomProductField(
              isTopField: true,
              initialValue: informeForm.clientphonenumber.value,
              onChanged: ref
                  .read(informeFormProvider(informe).notifier)
                  .onClientePhoneChanged,
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text("Requisitos Acceso - CONTRATA"),
            customSwitch(
                'Prueba Covid-19',
                informeForm.pruebacontrata,
                ref
                    .read(informeFormProvider(informe).notifier)
                    .onPruebaContrataChanged),
            customSwitch(
                'SCRT',
                informeForm.sctrcontrata,
                ref
                    .read(informeFormProvider(informe).notifier)
                    .onSctrContrataChanged),
            const SizedBox(height: AppDefaults.padding),
            const Text("Requisitos Acceso - SUPERVISOR"),
            customSwitch(
                'Prueba Covid-19',
                informeForm.pruebasupervisor,
                ref
                    .read(informeFormProvider(informe).notifier)
                    .onPruebaSupervisorChanged),
            customSwitch(
                'SCRT',
                informeForm.sctrsupervisor,
                ref
                    .read(informeFormProvider(informe).notifier)
                    .onSctrSupervisorChanged),
            Center(
              child: Row(
                children: [
                  const Text("Equipos Backup"),
                  IconButton(
                    onPressed: () {
                      final list = ref.read(_controllerList2Provider.notifier);
                      list.add();
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: list.length < 4 ? list.length : 4,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: IconButton(
                    onPressed: () {
                      ref.read(_controllerList2Provider.notifier).remove(index);
                    },
                    icon: Icon(Icons.remove_from_queue),
                  ),
                  title: TextFormField(
                    onChanged: (newvalue) {
                      ref
                          .read(informeFormProvider(informe).notifier)
                          .onBackupChanged(newvalue, index);
                    },
                    controller: ref.watch(list[index]),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 100),

            
          ],
        ),
      ),
    );
  }

  Widget customSwitch(String text, bool val, Function(bool) onChangeMethod) {
    return Padding(
      padding: const EdgeInsets.only(top: 22.0, right: 16.0, left: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
                fontSize: 20.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          const Spacer(),
          CupertinoSwitch(
            trackColor: Colors.grey,
            activeColor: Colors.blue,
            value: val,
            onChanged: onChangeMethod,
          )
        ],
      ),
    );
  }
}
