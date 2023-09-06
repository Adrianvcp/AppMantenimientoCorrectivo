// import 'package:app_manteni_correc/app/presentation/global/dialogs/dialog_status_custom.dart';
// import 'package:app_manteni_correc/app/presentation/modules/Image/widgets/dottedborder_custom.dart';
// import 'package:app_manteni_correc/app/presentation/modules/camera/myhomePage.dart';
// import 'package:app_manteni_correc/app/presentation/modules/camera/preview_camera.dart';
// import 'package:app_manteni_correc/app/presentation/modules/home/Informe/components/full_screen_loader.dart';
// import 'package:app_manteni_correc/app/presentation/providers/image/image_provider_model.dart';
// import 'package:camera/camera.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
// import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';

// class SectionImages extends ConsumerStatefulWidget {
//   String titleSection; //titleSection
//   String title; //titleSubSection
//   String id;  //titleSubSection
//   int cantImagesMax;
//   bool isSubSection;
//   String cid;
//   List<CameraDescription> listCamera;
//   SectionImages({super.key,required this.cid,required this.listCamera,required this.id,required this.titleSection,this.title = '',required this.cantImagesMax,this.isSubSection = false});

//   @override
//   _SectionImagesState createState() => _SectionImagesState();

// }

// class _SectionImagesState extends ConsumerState<SectionImages> {
//   DottedBorderCustom dottedBorderEmpty = DottedBorderCustom(id: '',onDeletePressed: (){}, position: '0',onEditPressed: (){}); // Lista para almacenar los DottedBorder
//   List<XFile>? _mediaFileList;
  

//   final _fruits = <String>["apple", "banana", "strawberry"];


//   bool isLoading = false;
//   void _setImageFileListFromFile(XFile? value) {

//     _mediaFileList = value == null ? null : <XFile>[value];

//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     // getAvailableCamera();

//   }

//     @override
//   void deactivate() {
//     super.deactivate();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   //Camera
//   final ImagePicker _picker = ImagePicker();
  

//   @override
//   Widget build(BuildContext context) {
//       final _scrollController = ScrollController();
//   final _gridViewKey = GlobalKey();
//   List<String> dataList = ['as','asd','2dasd','asda'];


//     final imagenProv = ref.watch( imageProviderFamily(widget.id)  );
//     List<ImageModel> images = imagenProv.images;
    
//     int cantImagesNow = images.length;

//     double fem = 1;
//     double ffem = 1;


//     final generatedChildren = List.generate(
//       dataList.length,
//       (index) => Container(
//         key: Key(dataList.elementAt(index)),
//         color: Colors.lightBlue,
//         child: Text(
//           dataList.elementAt(index),
//         ),
//       ),
//     );

//     return ReorderableBuilder(
//                 children: generatedChildren,
//                 scrollController: _scrollController,
//                 onReorder: (List<OrderUpdateEntity> orderUpdateEntities) {
//                   for (final orderUpdateEntity in orderUpdateEntities) {
//                     final fruit = dataList.removeAt(orderUpdateEntity.oldIndex);
//                     dataList.insert(orderUpdateEntity.newIndex, fruit);
//                   }
//                 },
//                 builder: (children) {
//                   return GridView(
//                     key: _gridViewKey,
//                     controller: _scrollController,
//                     children: children,
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 2,
//                       crossAxisSpacing: 10,
//                     ),
//                   );
//                 });
//   }
// }



import 'package:app_manteni_correc/app/presentation/global/dialogs/dialog_status_custom.dart';
import 'package:app_manteni_correc/app/presentation/modules/Image/widgets/dottedborder_custom.dart';
import 'package:app_manteni_correc/app/presentation/modules/camera/myhomePage.dart';
import 'package:app_manteni_correc/app/presentation/modules/camera/preview_camera.dart';
import 'package:app_manteni_correc/app/presentation/modules/home/Informe/components/full_screen_loader.dart';
import 'package:app_manteni_correc/app/presentation/providers/image/image_provider_model.dart';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class SectionImages extends ConsumerStatefulWidget {
  String titleSection; //titleSection
  String title; //titleSubSection
  String id;  //titleSubSection
  int cantImagesMax;
  bool isSubSection;
  String cid;
  List<CameraDescription> listCamera;
  SectionImages({super.key,required this.cid,required this.listCamera,required this.id,required this.titleSection,this.title = '',required this.cantImagesMax,this.isSubSection = false});

  @override
  _SectionImagesState createState() => _SectionImagesState();

}

class _SectionImagesState extends ConsumerState<SectionImages> {
  DottedBorderCustom dottedBorderEmpty = DottedBorderCustom(id: '',onDeletePressed: (){}, position: '0',onEditPressed: (){}); // Lista para almacenar los DottedBorder
  // List<CameraDescription> listCamerasAvailables = [];
  List<XFile>? _mediaFileList;
    List<String> dataList = ['as'];

  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();
  final _fruits = <String>["apple","pineapple","applePen"];


  bool isLoading = false;
  void _setImageFileListFromFile(XFile? value) {
          // print('dentro del setImamge');

    _mediaFileList = value == null ? null : <XFile>[value];
          // print('fin del setImage');

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // getAvailableCamera();

  }

    @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  // Future<void> getAvailableCamera() async {
  //   await availableCameras().then(
  //     (value) => listCamerasAvailables = value,
    
  //   ); //
                  
  // }
  
  //Camera
  final ImagePicker _picker = ImagePicker();
  
  Future<void> _onImageButtonPressed(
    ImageSource source, {
    required BuildContext context,
    // bool isMedia = false,
  }) async {
    if (context.mounted) {
      
      final XFile? pickedFile = await _picker.pickImage(
        source: source
      );

      DialogStatusCustom.showDialogLoading(context);
      
      await DialogStatusCustom.wait();

      setState(() {
        _setImageFileListFromFile(pickedFile);
        DialogStatusCustom.hideLoading(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PreviewPage(
                      picture: pickedFile!,
                      cid: widget.cid,
                      id: widget.id,
                      titleSection: widget.titleSection,
                    )));
      });

      


    }
  }

  @override
  Widget build(BuildContext context) {
    
    print('en Section_Images: ${widget.listCamera}');

    // final uniqueImageProvider = StateNotifierProvider<ImageProviderModel, ImageListModel>((ref) {
    //   return ImageProviderModel([]);
    // });

    // final imageProv = ref.watch(uniqueImageProvider);
    // List<ImageModel> images = imageProv.images;



    // ImageProviderModel imageProvider = context.watch<ImageProviderModel>();
    final imagenProv = ref.watch( imageProviderFamily(widget.id)  );
    List<ImageModel> images = imagenProv.images;
    
    int cantImagesNow = images.length;
    // print('cantImagesNow: $cantImagesNow');
    // print('widget.cantImagesMax : ${widget.cantImagesMax}');
    // print('cauntos hay ');
    // print(images.length);

    double fem = 1;
    double ffem = 1;


    // final generatedChildren = List.generate(
    //   _fruits.length,
    //   (index) => Container(
    //     key: Key(_fruits.elementAt(index)),
    //     color: Colors.lightBlue,
    //     child: Text(
    //       _fruits.elementAt(index),
    //     ),
    //   ),
    // );

    final generatedChildren = List.generate(
      images.length,
      (index) => Container(
        key: Key(images.elementAt(index).imagelUploadModel.registro),
        child: DottedBorderCustom(id:widget.id,picture: images[index].image,position: index.toString(),onDeletePressed: (){}, onEditPressed: (){})//dottedBorder[index];,
      ),
    );
    print('generatedChildren');

    print(generatedChildren);
    return Column(
      children: [

        Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.title ?? '',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.375 * ffem / fem,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w,),
                  Text(
                    '${cantImagesNow}/${widget.cantImagesMax.toString()}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1 * ffem / fem,
                      color: Color(0xff000000),
                    ),
                  )
                ],
              ),
        widget.title != ''
            ? Container(
                height: 10.h,
              )
            : SizedBox(),

        images.isEmpty ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            dottedBorderEmpty
          ],
        ):
        Container(
          height: images.length > 0 ? (images.length / 2).ceil() * 140.h : 140.h,
          child: ReorderableBuilder(
                children: generatedChildren,
                scrollController: _scrollController,
                onReorder: (List<OrderUpdateEntity> orderUpdateEntities) {
                  for (final orderUpdateEntity in orderUpdateEntities) {
                    final fruit = images.removeAt(orderUpdateEntity.oldIndex);
                    images.insert(orderUpdateEntity.newIndex, fruit);
                  }
                },
                builder: (children) {
                  return GridView(
                    key: _gridViewKey,
                    controller: _scrollController,
                    children: children,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 8,
                    ),
                  );
                }),
        ),
        
        
        
        // GridView.builder(
        //   shrinkWrap: true,
        //   physics: NeverScrollableScrollPhysics(),
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2, // Número de columnas basado en el ancho de la pantalla
        //     crossAxisSpacing: 10, // Espacio entre las columnas
        //     mainAxisSpacing: 10, // Espacio entre las filas
        //   ),
        //   itemCount: images.length, //dottedBorder.length, // Cantidad total de tarjetas
        //   itemBuilder: (context, index) {
        //     // Generar las tarjetas con contenido de ejemplo
        //     return DottedBorderCustom(id:widget.id,picture: images[index].image,position: index.toString(),onDeletePressed: (){}, onEditPressed: (){});//dottedBorder[index];
        //   },
        // ),







        Container(
          height: 10.h,
        ),
        SizedBox(
          width: double.infinity,
          height: 28.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

        //       ElevatedButton(
        //   onPressed: () async {
        //     await availableCameras().then((value) => Navigator.push(context,
        //         MaterialPageRoute(builder: (_) => MyHomePage(title: 'Image Picker Example') )));
        //   },
        //   child: const Text("Take a Picture"),
        // )


        //       ElevatedButton(
        //   onPressed: () async {
        //     await availableCameras().then((value) => Navigator.push(context,
        //         MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
        //   },
        //   child: const Text("Take a Picture"),
        // )

              //Tomar Foto
              Container(
                // btntQ1 (35:650)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 28 * fem, 0 * fem),
                width: 115 * fem,
                height: double.infinity,

                decoration: BoxDecoration(
                  color: Color(0xfffbbb21),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: cantImagesNow  == widget.cantImagesMax ? null:() async {
                    print('Tomar Foto');


                    _onImageButtonPressed(ImageSource.camera,context: context);

                //     Navigator.push(context,
                // MaterialPageRoute(builder: (_) => MyHomePage(title: 'Image Picker Example')));

                    // setState(() {
                    //   dottedBorder.add(DottedBorderCustom(onDeletePressed: (){}, onEditPressed: (){}));
                    // });
                    // print(listCamerasAvailables);
                        print('en el boton: ${widget.listCamera}');

          //           Navigator.push(
          // context,
          // MaterialPageRoute(
          //     builder: (context) =>  CameraPage(
          //                           cameras: widget.listCamera,
          //                           id: widget.id,
          //                           titleSection: widget.titleSection,
          //                         )));
            // await availableCameras().then((value) => Navigator.push(context,
            //     MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));

          //                                 Navigator.push(
          // context,
          // MaterialPageRoute(
          //     builder: (context) =>  CameraPage(
          //                           cameras: widget.listCamera,
          //                         )));   

                  
                    // await availableCameras().then((value) => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) => CameraPage(cameras: value,id: widget.id,titleSection: widget.titleSection,)))); //
                  
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        cantImagesNow == widget.cantImagesMax ? const Color.fromARGB(255, 212, 210, 210): Color(0xfffbbb21)), // Color de fondo del botón
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // Ajusta el radio de los bordes para darle un aspecto de botón
                      ),
                    ),
                    
                  ),
                  child: Text(
                    'Tomar Foto',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1 * ffem / fem,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),




              //Importar Foto
              Container(
                // btntQ1 (35:650)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 28 * fem, 0 * fem),
                width: 115 * fem,
                height: double.infinity,

                decoration: BoxDecoration(
                  color: Color(0xfffbbb21),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: (){
                    print('importar');
                    _onImageButtonPressed(ImageSource.gallery,context: context);
                    
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        cantImagesNow == widget.cantImagesMax ? const Color.fromARGB(255, 212, 210, 210): Color(0xfffbbb21)), // Color de fondo del botón
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // Ajusta el radio de los bordes para darle un aspecto de botón
                      ),
                    ),
                  ),
                  child: Text(
                    'Importar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1 * ffem / fem,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            
            ],
          ),
        ),
        
      ],
    );
  }
}