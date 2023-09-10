import 'package:app_manteni_correc/app/presentation/global/app_colors.dart';
import 'package:app_manteni_correc/app/presentation/modules/Image/widgets/section_form.dart';
import 'package:app_manteni_correc/app/presentation/providers/image/image_provider_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class AddImage extends ConsumerStatefulWidget {
  String cid;
  AddImage({Key? key, required this.cid}) : super(key: key);

  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends ConsumerState<AddImage>
    with TickerProviderStateMixin {
  List<CameraDescription> listCamerasAvailables = [];

  @override
  void initState() {
    super.initState();
    getAvailableCamera();
  }

  @override
  Widget build(BuildContext context) {
    // final imagenProv = ref.watch( imageProvider );
    // final locationRepository = ref.watch(locationRepositoryProvider);
    final imageRepository = ref.watch(imageRepositoryProvider);

    double fem = 1;
    double ffem = 1;

    return Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        body: SafeArea(
          child: Container(
            color: AppColors.kBackgroundColor,
            // agregarimagenesXxu (35:2)
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      children: [
                        //Validar si es SUCACO O SUCAIN

                        //SUCACO
                        ProviderScope(
                            child: SectionForm(
                          cid: widget.cid,
                          listCamera: listCamerasAvailables,
                          titleSection: 'III. REGISTRO DE UBICACIÓN',
                          titleSubSection: 'Registro de Ubicacion',
                          cantImagesMax: 2,
                        )),
                        ProviderScope(
                            child: SectionForm(
                          cid: widget.cid,
                          listCamera: listCamerasAvailables,
                          titleSection: 'IV. ACTIVIDADES DURANTE MC',
                          titleSubSection: 'Antes de ingresar al Cliente',
                          cantImagesMax: 3,
                        )),
                        ProviderScope(
                            child: SectionForm(
                          cid: widget.cid,
                          listCamera: listCamerasAvailables,
                          description: false,
                          titleSection: 'IV. ACTIVIDADES DURANTE MC',
                          titleSubSection:
                              'Durante el Mantenimiento Correctivo en la sede del Cliente',
                          cantImagesMax: 12,
                          isSubSecction: true,
                        )),

                        //SUCAIN
                        // ProviderScope(
                        //     child: SectionForm(
                        //       cid: widget.cid,
                        //   listCamera: listCamerasAvailables,
                        //   titleSection: 'REGISTRO IMAGENES SUCAIN',
                        //   titleSubSection: 'Registro de imagenes',
                        //   cantImagesMax: 2,
                        // )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {

            
            print('Enviar Imagenes');

            List<String> listaSecciones = [
              'Registro de Ubicacion',
              'Antes de ingresar al Cliente',
              'Durante el Mantenimiento Correctivo en la sede del Cliente'
            ];
            print('valor de cid en AddImage ${widget.cid}');

            for (var element in listaSecciones) {
              final imageProv = ref.watch(imageProviderFamily(element).notifier);

              List<ImageModel> images = imageProv.getImages();

              for (var i = 0; i < images.length; i++) {
                print('---- Index:  ${images[i].index}');
                print('---- Index:  ${images[i].image}');
                print('---- cid:  ${images[i].imagelUploadModel.cid}');
                print('---- description:  ${images[i].imagelUploadModel.description}');
                print('---- eliminacion_logica:  ${images[i].imagelUploadModel.eliminacion_logica}');
                print('---- id:  ${images[i].imagelUploadModel.id}');
                print('---- nivel1:  ${images[i].imagelUploadModel.nivel1}');
                print('---- nivel2:  ${images[i].imagelUploadModel.nivel2}');
                print('---- nro_imagen:  ${images[i].imagelUploadModel.nro_imagen}');
                print('---- tGeneralDataId:  ${images[i].imagelUploadModel.tGeneralDataId}');
              }

              // imageRepository.uploadImage(images, widget.cid);
            }

            
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.send),
        ));
  }

  Future<void> getAvailableCamera() async {
    await availableCameras().then((value) {
      setState(() {
        print('en addImage: $value');
        listCamerasAvailables = value;
      });
    });
  }
}
