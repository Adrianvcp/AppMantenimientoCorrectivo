import 'dart:convert';

ImageDescripcionList imageDescripcionFromJson(String str) => ImageDescripcionList.fromJson(json.decode(str));

String imageDescripcionToJson(ImageDescripcionList data) => json.encode(data.toJson());

class ImageDescripcionList {
    ImageDescripcionList({
        required this.imageDescripcionList,
    });
    final List<ImageDescripcion> imageDescripcionList;

    factory ImageDescripcionList.fromJson(Map<String, dynamic> json) => ImageDescripcionList(
        imageDescripcionList: List<ImageDescripcion>.from(json["data"].map((x) => ImageDescripcion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(imageDescripcionList.map((x) => x.toJson())),
    };
}

class ImageDescripcion {
    int id;
    String titulo;
    String subtitulo;
    String descripcion;
    bool imageAssigned;

    ImageDescripcion({
        required this.id,
        required this.titulo,
        required this.subtitulo,
        required this.descripcion,
        this.imageAssigned = false,
    });

    factory ImageDescripcion.fromJson(Map<String, dynamic> json) => ImageDescripcion(
        id: json["id"],
        titulo: json["titulo"],
        subtitulo: json["subtitulo"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "subtitulo": subtitulo,
        "descripcion": descripcion,
    };
}
