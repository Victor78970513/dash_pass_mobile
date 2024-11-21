class VehiculoModel {
  final String rfid;
  final String chasis;
  final String estado;
  final String idVehiculo;
  final String marca;
  final String modelo;
  final int numeroRegisgtro;
  final String placa;
  final String tipoVehiculo;
  final String userId;
  final String image;

  VehiculoModel(
      {required this.rfid,
      required this.chasis,
      required this.estado,
      required this.idVehiculo,
      required this.marca,
      required this.modelo,
      required this.numeroRegisgtro,
      required this.placa,
      required this.tipoVehiculo,
      required this.userId,
      required this.image});

  factory VehiculoModel.fromJson(Map<String, dynamic> json) {
    return VehiculoModel(
      rfid: json["RFID"],
      chasis: json["chasis"],
      estado: json["estado"],
      idVehiculo: json["id_vehiculo"],
      marca: json["marca"],
      modelo: json["modelo"],
      numeroRegisgtro: json["numero_registro"],
      placa: json["placa"],
      tipoVehiculo: json["tipo_vehiculo"],
      userId: json["id_usuario"],
      image: json['imagen'],
    );
  }
}
