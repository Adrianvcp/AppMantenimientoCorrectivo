import 'package:app_manteni_correc/app/presentation/modules/Image/widgets/section_images.dart';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionForm extends StatefulWidget {
  String titleSection;
  String titleSubSection;
  bool description;
  int cantImagesMax;
  bool isSubSecction;
  String cid;
  List<CameraDescription> listCamera;
  SectionForm({super.key,required this.cid, required this.listCamera,required this.titleSection,required this.titleSubSection,this.description = true,required this.cantImagesMax,this.isSubSecction = false});

  @override
  State<SectionForm> createState() => _SectionFormState();
}

class _SectionFormState extends State<SectionForm> {
  @override
  Widget build(BuildContext context) {

    // print('en Section_Form: ${widget.listCamera}');
    double fem = 1;
    double ffem = 1;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                widget.isSubSecction ? '' : widget.titleSection,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16 * ffem,
                  fontWeight: FontWeight.w600,
                  height: 1 * ffem / fem,
                  color: Color(0xff000000),
                ),
              ),
            )
          ],
        ),
        Container(
          height: 5.h,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                widget.description ? 'En esta seccion se deben ingresar las imagenes correspondientes.' : '',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16 * ffem,
                  fontWeight: FontWeight.w500,
                  height: 1.375 * ffem / fem,
                  color: Color(0xff87898e),
                ),
              ),
            )
          ],
        ),
        Container(
          height: 10.h,
        ),
        SectionImages(
              cid: widget.cid,
              listCamera: widget.listCamera,
              titleSection: widget.titleSection,
              title: widget.titleSubSection,
              id: widget.titleSubSection,
              cantImagesMax : widget.cantImagesMax,
              isSubSection: widget.isSubSecction,
            ),
            Container(
              height: 10.h,
            ),

        // if (widget.titleSubSection != null &&
        //     widget.titleSubSection!.isNotEmpty) ...[
        //   for (var title in widget.titleSubSection!) ...[
        //     SectionImages(
        //       title: title,
        //       id: title,
        //     ),
        //     Container(
        //       height: 10.h,
        //     ),
        //   ]
        // ] 
        //else ...[
        //   SectionImages(id: '0',),
        //   Container(
        //     height: 25.h,
        //   ),
        // ]

        
      ],
    );
  }
}
