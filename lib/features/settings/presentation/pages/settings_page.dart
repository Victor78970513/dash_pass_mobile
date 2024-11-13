import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dash_pass/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dash_pass/features/settings/presentation/pages/profile_page.dart';
import 'package:dash_pass/models/user_model.dart';

class SettingsPage extends StatelessWidget {
  final UserModel user;
  const SettingsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SvgPicture.asset(
            "assets/logos/dash_pass.svg",
            height: size.height * 0.1,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Configuración",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SettingsItem(
                  icon: Icons.person_outline_rounded,
                  itemName: "Mis Datos",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(user: user),
                      ),
                    );
                  },
                ),
                SettingsItem(
                  icon: Icons.edit_document,
                  itemName: "Términos y Condiciones",
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (BuildContext context) {
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Términos y Condiciones de Uso',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(
                                    '''
Última actualización: [Fecha actual]

Bienvenido/a a [Nombre de la Aplicación], una plataforma diseñada para facilitar el pago y gestión de peajes en Bolivia mediante una aplicación móvil. Estos Términos y Condiciones de Uso (en adelante, "Términos") regulan el acceso y uso de nuestra aplicación. Al descargar, registrarse o utilizar nuestra aplicación, usted acepta cumplir con estos Términos. Si no está de acuerdo, le recomendamos no utilizar la aplicación.

1. Definiciones
1.1 "Aplicación": hace referencia a [Nombre de la Aplicación], la plataforma de gestión de peajes mediante el uso de tecnología RFID y recarga de saldo.

1.2 "Usuario": hace referencia a cualquier persona que descarga y utiliza la aplicación.

2. Registro y Uso de la Aplicación
2.1 Registro: Para utilizar la aplicación, el usuario debe proporcionar información precisa y verídica al crear su cuenta, incluyendo datos personales y detalles de vehículos.

2.2 Acceso a los Servicios: Al registrarse, el usuario puede acceder a funcionalidades como recarga de saldo, consulta de historial de pases, información sobre peajes y verificación de cobros.

2.3 Actualización de Información: El usuario se compromete a mantener actualizados sus datos personales y la información de sus vehículos en la aplicación.

3. Recarga de Saldo y Pagos
3.1 Recarga de Saldo: La aplicación permite al usuario recargar saldo, el cual será descontado automáticamente cada vez que pase por un peaje registrado en el sistema.

3.2 Descuento Automático: Al pasar por un peaje, el saldo será descontado automáticamente. Los detalles de cada transacción estarán disponibles en la aplicación para revisión del usuario.

4. Uso de Tecnología RFID
4.1 Etiquetas RFID: La aplicación funciona en conjunto con etiquetas RFID asignadas a cada usuario. Estas etiquetas deben ser utilizadas correctamente para asegurar el registro y cobro adecuado de cada peaje.

4.2 Protección de la Etiqueta: El usuario es responsable de la seguridad de su etiqueta RFID y deberá informar de inmediato cualquier pérdida o daño.

5. Derechos y Responsabilidades del Usuario
5.1 Conducta Adecuada: El usuario se compromete a utilizar la aplicación de manera legal, respetando estos Términos y las leyes locales.

5.2 Uso No Autorizado: Queda prohibido realizar actividades fraudulentas o que comprometan la seguridad del sistema, como el uso indebido de etiquetas RFID o manipulación de datos.

5.3 Notificación de Problemas: El usuario debe informar cualquier problema con la aplicación, como cobros erróneos o fallos técnicos, a través de los canales de soporte proporcionados.

6. Privacidad y Protección de Datos
6.1 Recopilación de Datos: La aplicación recopila y almacena información personal, como nombre, correo electrónico, número de teléfono, y datos de vehículos, así como datos de localización relacionados con el uso de peajes.

6.2 Uso de Datos: La información del usuario será utilizada únicamente para gestionar el sistema de peajes, mejorar los servicios y cumplir con obligaciones legales.

6.3 Seguridad de la Información: La aplicación implementa medidas de seguridad para proteger la información del usuario. Sin embargo, el usuario reconoce que ningún sistema es completamente seguro y exime de responsabilidad a [Nombre de la Aplicación] por posibles brechas de seguridad que estén fuera de nuestro control.

7. Limitación de Responsabilidad
7.1 Exactitud de la Información: Aunque hacemos todo lo posible para proporcionar información precisa y actualizada, [Nombre de la Aplicación] no se responsabiliza por posibles errores o retrasos en la información proporcionada.

7.2 Disponibilidad del Servicio: No garantizamos que la aplicación esté libre de interrupciones o errores y no seremos responsables por la falta de disponibilidad del servicio debido a factores externos.

8. Modificaciones a los Términos
Nos reservamos el derecho de modificar estos Términos en cualquier momento. Las actualizaciones se notificarán al usuario a través de la aplicación o por correo electrónico. El uso continuo de la aplicación implica la aceptación de las modificaciones.

9. Contacto
Si tiene preguntas o comentarios sobre estos Términos, puede ponerse en contacto con nosotros en:
[Correo de contacto]
[Teléfono de contacto]
                  ''',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.black87,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                SettingsItem(
                  icon: Icons.question_answer,
                  itemName: "Preguntas frecuentes",
                  onTap: () {},
                ),
                SettingsItem(
                  icon: Icons.sync_problem,
                  itemName: "Reportar Problema / Sugerencia",
                  onTap: () {},
                ),
                SettingsItem(
                  icon: Icons.logout,
                  itemName: "Cerrar Sesión",
                  onTap: () {
                    context.read<AuthBloc>().add(AuthLogOut());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  final String itemName;
  final bool show;
  const SettingsItem({
    super.key,
    required this.icon,
    required this.itemName,
    this.show = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 4),
                blurRadius: 20,
                color: Colors.black.withOpacity(0.2),
              )
            ],
          ),
          child: ListTile(
            leading: Icon(
              icon,
              color: Colors.blueAccent,
              size: 30,
            ),
            title: Text(
              itemName,
              style: GoogleFonts.poppins(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade600,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
