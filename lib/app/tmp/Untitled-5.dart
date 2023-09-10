//PREVIEW_PAGE
import 'dart:typed_data';
import 'package:app_manteni_correc/app/data/devices/LocationRepository.dart';
import 'package:app_manteni_correc/app/data/services/image.dart';
import 'package:app_manteni_correc/app/domain/models/image/image.dart';
import 'package:app_manteni_correc/app/domain/models/image/imageDescription.dart';
import 'package:app_manteni_correc/app/presentation/global/app_colors.dart';
import 'package:app_manteni_correc/app/presentation/modules/Image/widgets/droplist_custom.dart';
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

class PreviewPage extends ConsumerStatefulWidget {
  final XFile picture;
  String id;
  String titleSection;
  PreviewPage({super.key, required this.picture,required this.id,required this.titleSection});

  @override
  // State<PreviewPage> createState() => _PreviewPageState();
  _PreviewPageState createState() => _PreviewPageState();

}

class _PreviewPageState extends ConsumerState<PreviewPage> {
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
  String selectedDropdownValue = ''; 
  bool isloading = true;
  
  final List<String> list = [];

  @override
  void initState() {
    super.initState();
    
    // ref.read( nowImgDescripcionProvider.notifier ).load().whenComplete(() => isloading = false, );

    locationRepository = LocationRepositoryImpl();
    getInformationUbication();
  }

  Future<void> getInformationUbication() async {

    DateTime now = DateTime.now();
    intl.DateFormat formatter = intl.DateFormat('d MMM y HH:mm:ss');
    String formattedDate = formatter.format(now);
    Position informationUbication = await locationRepository.getCurrentUserLocation();
    print('getInformationUbication!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    print(informationUbication.longitude);
    print(informationUbication.latitude);
    print(informationUbication.altitude);

    if (informationUbication != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          informationUbication.latitude, informationUbication.longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        setState(() {
          postalCode = placemarks[0].postalCode.toString();
          country = placemarks[0].country.toString();
          city = placemarks[0].locality.toString();
        });

        print('${city} ${postalCode}, ${country}');
      } else {
        print('Código postal no encontrado');
      }

      setState(() {
        latitude = informationUbication.latitude.toString();
        longitude = informationUbication.longitude.toString();
        altitude = informationUbication.altitude.toString();
        loadingInformationUbication = false;

        textOnImage = '${formattedDate}\n${latitude}${longitude}W\n${city} ${postalCode}, ${country}\nAltitud:${altitude}\nVelocidad:0.0km/h\n# SUPERVISIÓN DE CAMPO';
        //${city} ${postalCode},
      });
    }
  }

  Future<void> _savePhotoWithText(File photo,String _textOnImage) async {
    String text = _textOnImage;
    if (text.isEmpty) {
      return;
    }
    print('antes de leer la imagen');

    // imagen procesada para escribir el texto
    img.Image? image = await loadImage(photo);

    ui.PictureRecorder recorder = ui.PictureRecorder();

    Canvas canvas = Canvas(recorder);

    final _image = await imgToImage(image!);

    canvas.drawImage(_image, Offset(0, 0), Paint());


    // Definir los estilos del texto
    TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    );

    // Calcular el tamaño del texto y su posición en la imagen
    TextSpan span = TextSpan(text: text, style: textStyle);
    TextPainter textPainter =
        TextPainter(text: span, textDirection: TextDirection.ltr);
    textPainter.layout();
    double x = (image.width - textPainter.width) / 2;
    double y = image.height - textPainter.height - 20;

    // Dibujar el texto en el lienzo
    textPainter.paint(canvas, Offset(x, y));

    // Finalizar el lienzo y obtener la imagen resultante
    ui.Image imgWithText =
        await recorder.endRecording().toImage(image.width, image.height);

    saveImageToDisk(imgWithText, 'fotoConTexto2.jpg');

  }

  Future<void> saveImageToDisk(ui.Image image, String fileName) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final buffer = byteData!.buffer.asUint8List();
    // final directory = await getApplicationDocumentsDirectory();
    final file = File('/storage/emulated/0/Documents/$fileName');
    await file.writeAsBytes(buffer);
    print('Image saved to: ${file.path}');
  }

  Future<img.Image?> loadImage(File photo) async {
    List<int> bytes = await photo.readAsBytes();

    // saveFile('test_1.txt',bytes);

    Uint8List uint8List = Uint8List.fromList(bytes);
    // saveFile('test_2.txt',uint8List);

    img.Image? image = img.decodeImage(uint8List);
    // saveFile('test_2.txt',uint8List);

    return image;
  }

  Future<img.Image> imgFromImage(ui.Image image) async {
    ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.rawRgba);

    Uint8List bytes = byteData!.buffer.asUint8List();
    print(img.decodeImage(bytes));

    return img.decodeImage(bytes)!;
  }

  Future<ui.Image> imgToImage(img.Image? image) async {
    if (image == null) {
      throw Exception('Image is null');
    }

    // Codificar la imagen en formato JPEG
    Uint8List bytes = img.encodeJpg(image);

    // Crear un ByteData desde los bytes de la imagen
    ByteData byteData = ByteData.sublistView(bytes);

    // Decodificar la imagen desde el ByteData
    ui.Image? result = await decodeImageFromList(byteData.buffer.asUint8List());

    if (result == null) {
      throw Exception('Failed to decode image');
    }

    return result;
  }


  
  @override
  Widget build(BuildContext context) {
    // ImageProviderModel imageProvider = context.watch<ImageProviderModel>();
    final imageProv = ref.watch(imageProviderFamily(widget.id).notifier);

    // final listDescripcion = ref.watch(imageDescripcionProvider);
    // final List<String> list = [];

    // final listDescripcion = ref.watch(imageDescripcionProvider);
    // final listDescripcionNotifier = ref.watch(nowImgDescripcionProvider.notifier);

    final nowimgdescripcionlist = ref.watch( nowImgDescripcionProvider );
    final nowimgdescripcionlistNotifier = ref.read( nowImgDescripcionProvider.notifier );

    // final imageUseCase = ref.watch(imageUseCaseProvider);


    return Scaffold(
      appBar: AppBar(title: const Text('Preview Page')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Stack(
            children: [
              Image.file(
                File(widget.picture.path),
                fit: BoxFit.cover,
                width: 100.w,
              ),
              loadingInformationUbication
                  ? Text('')
                  : Positioned.fill(
                      child: Container(
                          child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          textOnImage,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                          // Aquí puedes colocar el contenido que deseas que ocupe todo el ancho
                          ),
                    ),
            ],
          ),
          SizedBox(height: 24.h),
          // Text(widget.picture.name),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Container(
              width: 300.w,
              child: Container(
                  padding: EdgeInsets.only(left: 6.w),
                  child: Text('Nombre de la imagen')),
            ),
          ),

          DropdownCustom(
                  dropdownItems: nowimgdescripcionlist.imageDescripcionList,
                  onChanged: (String newValue) {
                    selectedDropdownValue = newValue;
                  }),
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
                onPressed: (){
                  _savePhotoWithText(File(widget.picture.path),textOnImage); // guarda imagen en el telefono
                  // ImageUploadData img = ImageUploadData(tGeneralDataId: tGeneralDataId, cid: cid, nivel1: nivel1, nivel2: nivel2, description: description, nro_imagen: nro_imagen, eliminacion_logica: '1');
                  // String nro_orden = imageUseCase.getCode(selectedDropdownValue);
                  
                  final ImageUploadData imageUploadData = ImageUploadData(tGeneralDataId: '7', cid: '1111Test', nivel1: widget.titleSection, nivel2: widget.id, description: selectedDropdownValue, nro_imagen: '0', eliminacion_logica: '1');
                  // imageProv.addImage(widget.id,widget.picture,imageUploadData);
                  //actualizar selected
                  // listDescripcionNotifier.updateSelected(selectedDropdownValue);
                  
                  // final info = listDescripcion.asData?.value;
                  // print('Veamos como es el valor del listDescripcion, se deberia ver el cambio');
                  // for (var element in info!) {
                  //   print(element.descripcion);
                  //   print(element.imageAssigned);

                  // }
                  print('Tam array list description : ${nowimgdescripcionlist.imageDescripcionList.length}');
                  Navigator.pop(context);// cierra la ventana de edicion y vuelve al anterior widget
                  nowimgdescripcionlistNotifier.updateSelected(selectedDropdownValue);
                  print(nowimgdescripcionlist.imageDescripcionList.length);

                },
                child: const Text(
                  "Guardar Imagen",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

}
