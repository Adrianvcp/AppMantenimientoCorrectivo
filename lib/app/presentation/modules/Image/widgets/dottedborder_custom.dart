import 'dart:io';

import 'package:app_manteni_correc/app/presentation/global/app_colors.dart';
import 'package:app_manteni_correc/app/presentation/modules/Image/widgets/editImage.dart';
import 'package:app_manteni_correc/app/presentation/modules/camera/preview_camera.dart';
import 'package:app_manteni_correc/app/presentation/providers/image/image_provider_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DottedBorderCustom extends ConsumerStatefulWidget {
  final String id;
  final XFile? picture;
  final String position;
  final VoidCallback onDeletePressed;
  final VoidCallback onEditPressed;
  DottedBorderCustom(
      {required this.id,
      this.picture = null,
      required this.position,
      required this.onDeletePressed,
      required this.onEditPressed});

  @override
  _DottedBorderCustomState createState() => _DottedBorderCustomState();
}

class _DottedBorderCustomState extends ConsumerState<DottedBorderCustom> {
  @override
  Widget build(BuildContext context) {
    // print('aca pes ');
    // print(widget.picture);

    //final imageProv = ref.watch(imageProviderFamily(widget.id).notifier);
    final imageProv = ref.watch(imageProviderFamily(widget.id).notifier);

    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      padding: EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          height: 130.h,
          width: 135.w,
          color: Colors.white,
          child: Stack(
            children: [
              widget.picture != null
                  ? Image.file(
                      File(widget.picture!.path),
                      fit: BoxFit.cover,
                      width: 135.w,
                    )
                  : SizedBox(),

              widget.picture != null
                  ? SizedBox()
                  : Positioned(
                      left: 35.w,
                      top: 115.h,
                      child: Align(
                        child: const Text(
                          '0 Imagenes',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ),
                    ),
              // Delete
              widget.picture != null
                  ? Positioned(
                      left: 15.w,
                      top: 75.h,
                      child: Align(
                        child: TextButton(
                          onPressed: () {
                            imageProv.removeImage(
                                widget.id, int.parse(widget.position));

                            print('Delte');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors
                                    .kColorPrimary), // Color de fondo amarillo
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              CircleBorder(), // Forma circular
                            ),
                          ),
                          child: Container(
                            width: 25.w,
                            height: 25.h,
                            child: Center(
                              child: Icon(
                                Icons.delete_forever_outlined,
                                color: Colors.black, // Color del ícono blanco
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),

              // Edit
              widget.picture != null
                  ? Positioned(
                      left: 65.w,
                      top: 75.h,
                      child: Align(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditImagePage(
                                        picture: widget.picture!,
                                        // cid: widget.cid,
                                        id: widget.id,
                                        position: widget.position,
                                        // titleSection: widget.titleSection
                                        )));

                            print('Edit');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors
                                    .kColorPrimary), // Color de fondo amarillo
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              CircleBorder(), // Forma circular
                            ),
                          ),
                          child: Container(
                            width: 25.w,
                            height: 25.h,
                            child: Center(
                              child: Icon(
                                Icons.mode_edit_outline_outlined,
                                color: Colors.black, // Color del ícono blanco
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
