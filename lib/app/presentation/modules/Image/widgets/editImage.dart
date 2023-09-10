import 'package:app_manteni_correc/app/data/devices/LocationRepository.dart';
import 'package:app_manteni_correc/app/data/services/image.dart';
import 'package:app_manteni_correc/app/domain/models/image/image.dart';
import 'package:app_manteni_correc/app/domain/models/image/imageDescription.dart';
import 'package:app_manteni_correc/app/presentation/global/app_colors.dart';
import 'package:app_manteni_correc/app/presentation/global/dialogs/dialog_status_custom.dart';
import 'package:app_manteni_correc/app/presentation/modules/Image/widgets/droplist_custom.dart';
import 'package:app_manteni_correc/app/presentation/modules/home/Informe/components/custom_product_field.dart';
import 'package:app_manteni_correc/app/presentation/providers/image/imageDescripcion_provider.dart';
import 'package:app_manteni_correc/app/presentation/providers/image/image_provider_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart' as intl;
import 'dart:ui' as ui;
// import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:app_manteni_correc/app/domain/repositories/location_repository.dart';
import 'package:path_provider/path_provider.dart';



class EditImagePage extends ConsumerStatefulWidget {
  final XFile picture;
  String id;
  String position;
  int idBd;
  EditImagePage(
      {super.key,
      required this.picture,
      required this.id,
      required this.position,
      required this.idBd
      });

  @override
  _EditImagePageState createState() => _EditImagePageState();
}

class _EditImagePageState extends ConsumerState<EditImagePage>
    with WidgetsBindingObserver {

  //Description image
  String _textDescription = '';
  String? _errorText;


  bool loadingInformationUbication = true;
  late final LocationRepository locationRepository;

  late String latitude;
  late String longitude;
  late String altitude;
  late String rol;
  late String postalCode;
  late String country;
  late String city;

  late String textOnImage;

  final name_picture = TextEditingController();
  late final File imageWithText;


  bool isShowDialog = false;
  String selectedDropdownValue = '';
  bool isloadingInformationGPS = true;
  final String pathImageWithText = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // ref.read( nowImgDescripcionProvider.notifier ).load().whenComplete(() => isloading = false, );
    print('edit Image');


  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) async {
  //   super.didChangeAppLifecycleState(state);
  //   if (state == AppLifecycleState.resumed) {
  //     bool isServiceEnabledGPS =
  //         await locationRepository.checkisEnabledService();

  //     if (!isServiceEnabledGPS && isShowDialog == false) {
  //       setState(() {
  //         isShowDialog = true;
  //       });
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('GPS Desactivado'),
  //             content: Text('Por favor, activa el GPS para continuar.'),
  //             actions: <Widget>[
  //               TextButton(
  //                 child: Text('Cancelar'),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                   setState(() {
  //                     isShowDialog = false;
  //                   });
  //                 },
  //               ),
  //               TextButton(
  //                 child: Text('Activar GPS'),
  //                 onPressed: () {
  //                   Geolocator.openLocationSettings();
  //                   Navigator.pop(context);
  //                   setState(() {
  //                     isShowDialog = false;
  //                   });
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   }
  // }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _validateInput(String value) {
    setState(() {
      _textDescription = value;
      if (value.isEmpty) {
        _errorText = 'Este campo no puede estar vacío';
      } else {
        _errorText = null;
      }
    });
  }


  // Future<void> _savePhotoWithText(File photo, String _textOnImage) async {
  //   String text = _textOnImage;
  //   if (text.isEmpty) {
  //     return;
  //   }

  //   // imagen procesada para escribir el texto
  //   img.Image? image = await loadImage(photo);

  //   ui.PictureRecorder recorder = ui.PictureRecorder();

  //   Canvas canvas = Canvas(recorder);

  //   final _image = await imgToImage(image!);

  //   canvas.drawImage(_image, Offset(0, 0), Paint());

  //   // Definir los estilos del texto
  //   TextStyle textStyle = TextStyle(
  //     color: Colors.white,
  //     fontSize: 30,
  //     fontWeight: FontWeight.bold,
  //   );

  //   // Calcular el tamaño del texto y su posición en la imagen
  //   TextSpan span = TextSpan(text: text, style: textStyle);
  //   TextPainter textPainter =
  //       TextPainter(text: span, textDirection: TextDirection.ltr);
  //   textPainter.layout();
  //   double x = (image.width - textPainter.width) / 2;
  //   double y = image.height - textPainter.height - 20;

  //   // Dibujar el texto en el lienzo
  //   textPainter.paint(canvas, Offset(x, y));

  //   // Finalizar el lienzo y obtener la imagen resultante
  //   ui.Image imgWithText =
  //       await recorder.endRecording().toImage(image.width, image.height);

  //   saveImageToDisk(imgWithText, 'fotoConTexto2.jpg');
  // }
 
  Future<void> saveImageToDisk(ui.Image image, String fileName) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final buffer = byteData!.buffer.asUint8List();
    final directory = await getApplicationDocumentsDirectory();
    //final file = File('/storage/emulated/0/Documents/$fileName');
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(buffer);
    print('Image saved to: ${file.path}');
    imageWithText = file;
    
  }

  // Future<img.Image?> loadImage(File photo) async {
  //   List<int> bytes = await photo.readAsBytes();

  //   // saveFile('test_1.txt',bytes);

  //   Uint8List uint8List = Uint8List.fromList(bytes);
  //   // saveFile('test_2.txt',uint8List);

  //   img.Image? image = img.decodeImage(uint8List);
  //   // saveFile('test_2.txt',uint8List);

  //   return image;
  // }



  @override
  Widget build(BuildContext context) {
    final imageProviderNotifier = ref.watch(imageProviderFamily(widget.id).notifier);
    final imageProvider = ref.watch(imageProviderFamily(widget.id));
    final imageUpdateDescription = ref.watch(updateImageDescriptionProvider(widget.id));

    // final nowimgdescripcionlist = ref.watch(nowImgDescripcionProvider);
    // final nowimgdescripcionlistNotifier = ref.read(nowImgDescripcionProvider.notifier);

    final imageRepository = ref.watch(imageRepositoryProvider);

    // final imageUseCase = ref.watch(imageUseCaseProvider);

    // for (var element in nowimgdescripcionlist.imageDescripcionList) {
    //   print(element.descripcion);
    // }


    print(widget.id);
    print(widget.position);
    print(widget.key);
    print(widget.picture);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Image')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Stack(
              children: [
                Image.file(
                  File(widget.picture.path),
                  fit: BoxFit.cover,
                  width: 300.w,
                ),
              ],
            ),
            SizedBox(height: 24.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Container(
                width: 300.w,
                child: Container(
                    padding: EdgeInsets.only(left: 6.w),
                    child: Text('Modificar Nombre de la imagen')),
              ),
            ),

            SizedBox(height: 3.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w,),
              child: 
              TextField(
              decoration: InputDecoration(
                labelText: imageProvider.images[int.parse(widget.position)].imagelUploadModel.description,
                border: OutlineInputBorder(),
                errorText: _errorText,
              ),
              onChanged: (value) {
                setState(() {
                  _textDescription = value;
                  _errorText = value.isEmpty ? 'Este campo no puede estar vacío' : null;
                });
              },
            ),
              //Luego hacer que funcione con esto
              // CustomProductField(
              //   isTopField: true,
              //   initialValue: '',
              //   onChanged: null
                        
              //   //  ref
              //   //      .read(informeFormProvider(informe).notifier)
              //   //      .onClientePhoneChanged,
              // ),
            ),

            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Container(
                constraints: BoxConstraints(
                  minHeight: 45,
                ),
                margin: EdgeInsets.only(top: 10.h),
                width: double.infinity,
                height: 10.h,
                decoration: BoxDecoration(
                  color: AppColors.kColorPrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  onPressed: () async {

                    if (_textDescription.isEmpty || _textDescription == '') {
                      setState(() {
                        _errorText = 'Este campo no puede estar vacío';
                      });
                      return;
                    }
                  
                    String nro_orden =  '0'; //'imageUseCase.getCode(selectedDropdownValue)';

                    String position = imageProvider.images.length > 0 ? (imageProvider.images.length).toString() : '0';

                    DialogStatusCustom.showDialogLoading(context);
                    await imageRepository
                        .updateDescriptionImage(widget.idBd, _textDescription)
                        .then((value)  {
                          
                      // ImageUploadData imageUploadDataRes = value;
                      
                      imageProviderNotifier.updateImageDescription(_textDescription,int.parse(widget.position));

                      DialogStatusCustom.hideLoading(context);
                      Navigator.pop(context);
                    });

                    // imageProviderNotifier.updateImageDescription(_textDescription,int.parse(widget.position));

                    
                    print('TEXT');
                    print(imageProvider.id);
                    
                    // imageUpdateDescription.call('111',1);
                    print(_textDescription);
                    // imageUpdateDescription(_textDescription,int.parse(widget.position));
                                        


                  },
                  child: const Text(
                    "Guardar",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ]),
        ),
      ),
    );
  }
}
