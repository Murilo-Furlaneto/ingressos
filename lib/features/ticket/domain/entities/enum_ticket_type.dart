enum TicketType {
  meiaEntrada("Meia Entrada"),
  inteira("Inteira"),
  estudante("Estudante"),
  aposentado("Aposentado"),
  vip("VIP");

  final String description;

  const TicketType([this.description = '']);

  @override
  String toString() {
    return description.isNotEmpty
        ? description
        : super.toString().split('.').last;
  }
}
