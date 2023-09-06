import 'package:app_manteni_correc/app/presentation/global/app_default.dart';
import 'package:app_manteni_correc/app/presentation/global/app_icons.dart';
import 'package:app_manteni_correc/app/presentation/global/widgets/app_back_button.dart';
import 'package:app_manteni_correc/app/presentation/modules/home/navbar/components/app_settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          children: [
            AppSettingsListTile(
              label: 'Cerrar Sesión',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () => context.push(''),
            ),
          ],
        ),
      ),
    );
  }
}