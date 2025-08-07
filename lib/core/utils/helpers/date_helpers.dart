
class DateHelpers {
  static String getHoraFormatada(DateTime date) {
  final hora = date.hour.toString().padLeft(2, '0');
  final minuto = date.minute.toString().padLeft(2, '0');
  return '$hora:$minuto';
}
}