import 'package:dash_pass/models/recargas_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecargaCardWidget extends StatelessWidget {
  final RecargasModel recarga;
  final Color color;
  const RecargaCardWidget(
      {super.key, required this.recarga, required this.color});

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('dd/MM/yyyy - HH:mm').format(recarga.createdAt);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 7,
            color: color,
            height: 80,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            width: size.width * 0.87,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xffE1EBF5),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(4, 4),
                  blurRadius: 32,
                  color: Colors.black.withOpacity(0.2),
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      formattedDate,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Bs ${recarga.monto}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "El pago se realizo por ${recarga.tipoPago}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
