// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';


// class cameraPage extends StatefulWidget {
//   const cameraPage({super.key});

//   @override
//   State<cameraPage> createState() => _cameraPageState();
// }


// class _cameraPageState extends State<cameraPage> {
  
//   Future<void> _onImageButtonPressed(
//     ImageSource source, {
//     required BuildContext context,
//     bool isMedia = false,
//   }) async {
//     if (context.mounted) {

//         print('else isMedia');
//             final XFile? pickedFile = await _picker.pickImage(
//               source: source,
//               maxWidth: 600,
//               maxHeight: 600,
//               imageQuality: 90,
//             );
//             setState(() {
//               _setImageFileListFromFile(pickedFile);
//             });
      
//     }
//   }



//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }