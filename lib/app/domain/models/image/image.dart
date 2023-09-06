import 'dart:typed_data';
import 'package:app_manteni_correc/app/domain/repositories/image_repository.dart';
import 'package:intl/intl.dart';

class ImageUseCase {

  ImageUseCase();

  static Map<String, String> dataMap = {
    'Registro de supervisor en sede': '1',
    'Personal con uso correcto de EPPs': '2',
    'Carnet del contratista': '3',
    'QR': '4',
    'SCRT': '5',
    'Kit de limpieza': '6',
    'Herramienta de trabajo': '7',
    'Equipos de Back up': '8',
    'Equipo de medición 1': '9',
    'Personal técnico en revisiones': '10',
    'Área de trabajo': '11',
    'Equipo de medición 2': '12',
    'Personal técnico realiza actualización del IOS': '13',
    'Se actualiza versión del IOS': '14',
    'Se verifica respuesta del servidor de prueba': '15',
    'Validación del servicio': '16',
    'Acta de servicio': '17',
  };

  String getCode(String input) {
    return dataMap[input] ?? 'Código no encontrado';
  }
  
}

class ImageUploadData {
  final String tGeneralDataId;
  final String cid;
  final String nivel1;
  final String nivel2;
  final String description;
  final String nro_imagen;
  final String registro;
  final String eliminacion_logica;

  ImageUploadData({
    required this.tGeneralDataId,
    required this.cid,
    required this.nivel1,
    required this.nivel2,
    required this.description,
    required this.nro_imagen,
    String? registro,
    required this.eliminacion_logica,
  }) : registro = registro ??
            DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  ImageUploadData copyWith({String? description}) {
    return ImageUploadData(
      tGeneralDataId: this.tGeneralDataId,
      cid: this.cid,
      nivel1: this.nivel1,
      nivel2: this.nivel2,
      description: description ?? this.description, // Utiliza el nuevo valor si se proporciona
      nro_imagen: this.nro_imagen,
      registro: this.registro,
      eliminacion_logica: this.eliminacion_logica,
    );
  }
}


class Result {
  final bool success;
  final String message;

  Result({required this.success, required this.message});
}
