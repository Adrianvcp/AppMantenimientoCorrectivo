import 'package:app_manteni_correc/app/domain/models/informe/informe_list.dart';
import 'package:app_manteni_correc/app/presentation/global/app_colors.dart';
import 'package:app_manteni_correc/app/presentation/global/app_default.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InformeCard extends StatelessWidget {
  const InformeCard({Key? key,required this.data,}) : super(key: key);
  final InformeListDetail data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding /2),
      child: Material(
        borderRadius: AppDefaults.borderRadius,
        color: AppColors.scaffoldBackground,
        child: InkWell(
          onTap: () =>  context.push('/register/${ data.cid }'),
          borderRadius: AppDefaults.borderRadius,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            padding: const EdgeInsets.all(AppDefaults.padding),
            decoration: BoxDecoration(
              border: Border.all(width: 0.1, color: AppColors.placeholder),
              borderRadius: AppDefaults.borderRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CID: ${data.cid}',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.black),
                    ),
                    
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data.datetime,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.black),
                    ),
                    const Spacer(),
                    
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}