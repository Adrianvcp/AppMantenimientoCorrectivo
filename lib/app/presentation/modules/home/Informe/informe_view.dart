import 'package:app_manteni_correc/app/presentation/global/app_default.dart';
import 'package:app_manteni_correc/app/presentation/global/app_icons.dart';
import 'package:app_manteni_correc/app/presentation/modules/home/Informe/components/informe_card.dart';
import 'package:app_manteni_correc/app/presentation/providers/home/informes_providers.dart';
import 'package:app_manteni_correc/app/presentation/providers/image/imageDescripcion_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class InformeView extends ConsumerStatefulWidget {
  const InformeView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InformeViewState createState() => _InformeViewState();
}

class _InformeViewState extends ConsumerState<InformeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowHomeProvider.notifier).loadNextPage();

    ref.read( nowImgDescripcionProvider.notifier ).load();

  }

  @override
  Widget build(BuildContext context) {
    final nowinforme = ref.watch(nowHomeProvider);
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: ElevatedButton(
              onPressed: () {
                context.push('/drawer');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF2F6F3),
                shape: const CircleBorder(),
              ),
              child: SvgPicture.asset(AppIcons.sidebarIcon),
            ),
          ),
          title: const Text("Informe"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Buscar',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(AppDefaults.padding),
                    child: SvgPicture.asset(AppIcons.search),
                  ),
                  suffixIconConstraints: const BoxConstraints(),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: nowinforme.informes.length,
                itemBuilder: (context, index) {
                  return InformeCard(
                    data: nowinforme.informes[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push('/register/new');
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ));
  }
}
