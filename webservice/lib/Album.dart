class Album {
  final int usuario;
  final int id;
  final String title;

  Album({
    required this.usuario,
    required this.id,
    required this.title,
  });

  /*Aquí mapeamos cada atributo de la clase con su
  correspondiente en json
   */
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      usuario: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}