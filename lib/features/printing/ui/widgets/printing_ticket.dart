import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:ingressos/core/utils/helpers/date_helpers.dart';
import 'package:ingressos/features/ticket/domain/entities/ticket_entity.dart';
import 'package:intl/intl.dart';

class PrintingTicket {
  PrintingTicket({
    required this.ticket,
  });

    final Ticket ticket;

  final dataFormatada = DateFormat('dd/MM/yyyy', 'pt_BR');  



Future<List<int>> escPosPrinting() async{
  final profile = await CapabilityProfile.load();
  final generator = Generator(PaperSize.mm58, profile);
  List<int> bytes = [];

  // conversão da imagem para um tipo que o escPosUtils aceita
  final ByteData data = await rootBundle.load("assets/images/logo_cinema.png");
  final Uint8List bytesLogo = data.buffer.asUint8List();
  final img.Image image = img.decodeImage(bytesLogo)!;

  bytes += generator.hr(ch: "-",len: 20);
  bytes +=generator.image(image);
  bytes += generator.text("CINEMA DIGITAL MOVIE", styles: const PosStyles(bold:  true, align: PosAlign.center));
  bytes += generator.hr(ch: "-",len: 20);

  bytes += generator.feed(3);
  bytes +=generator.text("FILME: ${ticket.filme.titulo}");

  bytes += generator.row([
    PosColumn(
      text: "DATA: ${dataFormatada.format(ticket.dataHoraCompra)}",styles: PosStyles(align: PosAlign.left)
    ),
    PosColumn(
      text: "HORA: ${DateHelpers.getHoraFormatada(ticket.horarioSessao)}", styles: PosStyles(align: PosAlign.right)
    )
  ]);

  bytes += generator.row([
    PosColumn(
      text: "ASSENTOS: ${ticket.assento.map((e) => e.posicao).toList().join(", ")}",styles: PosStyles(align: PosAlign.left),
    ),
    PosColumn(
      text: "TIPO: ${ticket.tipoIngresso.description.toUpperCase()}", styles: PosStyles(align: PosAlign.right),
    ),
  ]);

  bytes += generator.feed(3);

  bytes += generator.hr(ch: "-",len: 20);

  bytes += generator.text("FORMA PAGAMENTO: PIX");

  bytes += generator.text("VALOR TOTAL: R\$ ${ticket.valor.toStringAsFixed(2)}");

  bytes += generator.feed(3);

  bytes += generator.hr(ch: "-", len: 20);

  bytes += generator.text("Apresente este ingresso no acesso ao cinema", styles: PosStyles(align: PosAlign.center));

  bytes += generator.text("Compra efetuada via aplicativo", styles: PosStyles(align: PosAlign.center, fontType: PosFontType.fontA));
  
  bytes += generator.feed(2);

return bytes;
}

}
