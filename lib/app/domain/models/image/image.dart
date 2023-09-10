import 'dart:convert';

ImageUploadData welcomeFromJson(String str) => ImageUploadData.fromJson(json.decode(str));

String welcomeToJson(ImageUploadData data) => json.encode(data.toJson());


class ImageUploadData {
  final int? id;
  final String tGeneralDataId;
  final String cid;
  final String nivel1;
  final String nivel2;
  final String description;
  final String nro_imagen;
  // final String createdAt;
  String? eliminacion_logica;

  ImageUploadData({
    this.id,
    required this.tGeneralDataId,
    required this.cid,
    required this.nivel1,
    required this.nivel2,
    required this.description,
    required this.nro_imagen,
    // required this.createdAt,
    this.eliminacion_logica,
  });
  //  : registro = registro ??
  //           DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());



  ImageUploadData copyWith({String? description}) {
    return ImageUploadData(
      id: this.id,
      tGeneralDataId: this.tGeneralDataId,
      cid: this.cid,
      nivel1: this.nivel1,
      nivel2: this.nivel2,
      description: description ?? this.description, // Utiliza el nuevo valor si se proporciona
      nro_imagen: this.nro_imagen,
      // createdAt: this.createdAt,
      eliminacion_logica: this.eliminacion_logica,
    );
  }

  // To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);



    factory ImageUploadData.fromJson(Map<String, dynamic> json) => ImageUploadData(
        id: json["id"],
        tGeneralDataId: json["t_general_data_id"],
        cid: json["CID"],
        nivel1: json["Nivel1"],
        nivel2: json["Nivel2"],
        // url: json["URL"],
        description: json["Description"],
        nro_imagen: json["nro_imagen"]
        // eliminacionLogica: json["eliminacion_logica"],
        // updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        // "createdAt": createdAt.toIso8601String(),
        "id": id,
        "t_general_data_id": tGeneralDataId,
        "CID": cid,
        "Nivel1": nivel1,
        "Nivel2": nivel2,
        // "URL": url,
        "Description": description,
        "nro_imagen": nro_imagen,
        // "eliminacion_logica": eliminacionLogica,
        // "updatedAt": updatedAt.toIso8601String(),
    };

}


class Result {
  final bool success;
  final String message;

  Result({required this.success, required this.message});
}
