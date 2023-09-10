//PREVIEW_PAGE
import 'dart:typed_data';
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

class PreviewPage extends ConsumerStatefulWidget {
  final XFile picture;
  String cid;
  String id;
  String titleSection;
  PreviewPage(
      {super.key,
      required this.picture,
      required this.cid,
      required this.id,
      required this.titleSection});

  @override
  // State<PreviewPage> createState() => _PreviewPageState();
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends ConsumerState<PreviewPage>
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
    print('init1');

    locationRepository = LocationRepositoryImpl();

    // getInformationUbication();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      bool isServiceEnabledGPS =
          await locationRepository.checkisEnabledService();

      if (!isServiceEnabledGPS && isShowDialog == false) {
        setState(() {
          isShowDialog = true;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('GPS Desactivado'),
              content: Text('Por favor, activa el GPS para continuar.'),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      isShowDialog = false;
                    });
                  },
                ),
                TextButton(
                  child: Text('Activar GPS'),
                  onPressed: () {
                    Geolocator.openLocationSettings();
                    Navigator.pop(context);
                    setState(() {
                      isShowDialog = false;
                    });
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

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

  Future<void> getInformationUbication() async {
    DateTime now = DateTime.now();
    intl.DateFormat formatter = intl.DateFormat('d MMM y HH:mm:ss');
    String formattedDate = formatter.format(now);

    bool isServiceEnabledGPS = await locationRepository.checkisEnabledService();

    if (!isServiceEnabledGPS) {
      setState(() {
        isShowDialog = true;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('GPS Desactivado'),
            content: Text('Por favor, activa el GPS para continuar.'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    isShowDialog = false;
                  });
                },
              ),
              TextButton(
                child: Text('Activar GPS'),
                onPressed: () {
                  Geolocator.openLocationSettings();
                  Navigator.pop(context);
                  setState(() {
                    isShowDialog = false;
                  });
                },
              ),
            ],
          );
        },
      );
    }

    Position informationUbication =
        await locationRepository.getCurrentUserLocation();

    if (informationUbication != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          informationUbication.latitude, informationUbication.longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        setState(() {
          postalCode = placemarks[0].postalCode.toString();
          country = placemarks[0].country.toString();
          city = placemarks[0].locality.toString();
        });
      } else {
        print('Código postal no encontrado');
      }

      setState(() {
        // latitude = informationUbication.latitude.toString();
        // longitude = informationUbication.longitude.toString();
        // altitude = informationUbication.altitude.toString();
        // loadingInformationUbication = false;

        textOnImage =
            '${formattedDate}\n${latitude}${longitude}W\n${city} ${postalCode}, ${country}\nAltitud:${altitude}\nVelocidad:0.0km/h\n# SUPERVISIÓN DE CAMPO';
        //${city} ${postalCode},

        isloadingInformationGPS = false;
        // DialogStatusCustom.hideLoading(context);
      });
    }
  }
   
  Future<void> _savePhotoWithText(File photo, String _textOnImage) async {
    String text = _textOnImage;
    if (text.isEmpty) {
      return;
    }

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
    final directory = await getApplicationDocumentsDirectory();
    //final file = File('/storage/emulated/0/Documents/$fileName');
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(buffer);
    print('Image saved to: ${file.path}');
    imageWithText = file;
    
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
    final imageProviderNotifier = ref.watch(imageProviderFamily(widget.id).notifier);
    final imageProvider = ref.watch(imageProviderFamily(widget.id));

    final nowimgdescripcionlist = ref.watch(nowImgDescripcionProvider);
    final nowimgdescripcionlistNotifier = ref.read(nowImgDescripcionProvider.notifier);

    // final imageUseCase = ref.watch(imageUseCaseProvider);
    final imageRepository = ref.watch(imageRepositoryProvider);

    for (var element in nowimgdescripcionlist.imageDescripcionList) {
      print(element.descripcion);
    }

//
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Page')),
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
                loadingInformationUbication
                    ? CircularProgressIndicator()
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

            // DropdownCustom(
            //     //dropdownItems: nowimgdescripcionlist.imageDescripcionList.where((element) => element.imageAssigned == false).toList(),
            //     dropdownItems:
            //         nowimgdescripcionlist.imageDescripcionList.toList(),
            //     onChanged: (String newValue) {
            //       print('lo que llega : $newValue');
            //       setState(() {
            //         selectedDropdownValue = newValue;
            //       });
            //     }),
            
            SizedBox(height: 3.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w,),
              child: 
              TextField(
              decoration: InputDecoration(
                labelText: 'Ingresa texto',
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

                    print('id: ' + widget.id.toString() );

                    if (_textDescription.isEmpty || _textDescription == '') {
                      setState(() {
                        _errorText = 'Este campo no puede estar vacío';
                      });
                      return;
                    }

                    _savePhotoWithText(File(widget.picture.path),'textOnImage'); // guarda imagen en el telefono
                    
                    // ImageUploadData img = ImageUploadData(tGeneralDataId: tGeneralDataId, cid: cid, nivel1: nivel1, nivel2: nivel2, description: description, nro_imagen: nro_imagen, eliminacion_logica: '1');
                    
                    String nro_orden =  '0'; //'imageUseCase.getCode(selectedDropdownValue)';
                    print('selecccted: $selectedDropdownValue');
                    print('#ORDEN : $nro_orden');

                    String position = imageProvider.images.length > 0 ? (imageProvider.images.length).toString() : '0';
                    print(
                      'INDEX' + position.toString()
                    );
                    final ImageUploadData imageUploadData = ImageUploadData(
                        tGeneralDataId: '53',
                        cid: '123',
                        nivel1: widget.titleSection,
                        nivel2: widget.id,
                        description: _textDescription,
                        nro_imagen: nro_orden,
                        // createdAt: '', // revisar que debe
                        eliminacion_logica: '0' //no deberiamos enviar porque es por defecto
                        );



                    // guardar imagne en ftp y en bd
                    ImageModel img = ImageModel(position, widget.picture, imageUploadData);
                    print('Enviar Imagenes');
                    print(img);

                    //Guardar imagen en el FTP y la informacion en BD
                    DialogStatusCustom.showDialogLoading(context);
                    await imageRepository
                        .uploadImageFtpBD(img, widget.cid)
                        .then((value)  {
                      print(value);
                      ImageUploadData imageUploadDataRes = value;

                      imageProviderNotifier.addImage(widget.id, widget.picture, imageUploadDataRes,position);
                      DialogStatusCustom.hideLoading(context);
                      Navigator.pop(context);
                    });
                    


                    //actualizar selected
                    // listDescripcionNotifier.updateSelected(selectedDropdownValue);

                    // final info = listDescripcion.asData?.value;
                    // print('Veamos como es el valor del listDescripcion, se deberia ver el cambio');
                    // for (var element in info!) {
                    //   print(element.descripcion);
                    //   print(element.imageAssigned);

                    // }
                    // cierra la ventana de edicion y vuelve al anterior widget
                    // print('ACTUALIZA ');

                    nowimgdescripcionlistNotifier.updateSelected(selectedDropdownValue);
                    
                    setState(() {
                      selectedDropdownValue = '';
                    });
                    // print('TAM LIST');
                    // print(nowimgdescripcionlist.imageDescripcionList.length);
                  },
                  child: const Text(
                    "Guardar Imagen",
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
