import 'package:app_manteni_correc/app/domain/models/image/imageDescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownCustom extends StatefulWidget {
  final List<ImageDescripcion> dropdownItems;
  final Function(String)? onChanged;

  DropdownCustom({required this.dropdownItems, this.onChanged});

  @override
  _DropdownCustomState createState() => _DropdownCustomState();
}

class _DropdownCustomState extends State<DropdownCustom> {
  String selectedValue = ''; // Valor seleccionado por defecto

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print('INIT STATE DROP LIST CUSTOM');
    // for (var element in widget.dropdownItems) {
    //   print(element);
    //   print('-------');
    // }
    // print(widget.dropdownItems.length);
    // print(widget.dropdownItems.first.descripcion);
    //selectedValue = widget.dropdownItems.first.descripcion;

    selectedValue = 'Seleccione una opción';

    print('value first default: $selectedValue');
  }

  TextEditingController name_picture = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // for (var element in widget.dropdownItems) {
    //   print('DENTRO DEL DROP LIST CUSTOM');
    //   print(element);
    // }
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Container(
          constraints: BoxConstraints(
            minHeight: 45,
          ),
          width: 300.w,
          height: 6.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: DropdownButton<String>(
            value: selectedValue, // Valor seleccionado
            onChanged: (String? newValue) {
              print('seleccionado : $newValue');
              setState(() {
                selectedValue = newValue!;
                widget.onChanged?.call(newValue);
              });
            },
            underline: Container(), // Quitar la línea inferior
            icon: Icon(Icons
                .keyboard_arrow_down_sharp), // Icono de desplegar personalizado
            iconSize: 30.sp, // Tamaño del icono
            isExpanded: true, // Hacer que el DropdownButton ocupe todo el ancho
            alignment:
                Alignment.centerRight, // Alineación del contenido a la derecha
            items: [
              // Fila por defecto
              DropdownMenuItem<String>(
                value: 'Seleccione una opción',
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Seleccione una opción',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              // Opciones de la lista
              ...widget.dropdownItems
                  //.where((element) => element.imageAssigned == false)
                  .map((ImageDescripcion value) {
                return DropdownMenuItem<String>(
                  value: value.descripcion,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(value.descripcion),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
