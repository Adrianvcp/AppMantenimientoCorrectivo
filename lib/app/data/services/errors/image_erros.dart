class ImageApiError implements Exception{

  @override
  String toString(){
    return 'Error al obtener la lista de informes';
  }
}