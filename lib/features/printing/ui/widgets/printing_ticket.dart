import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:ingressos/core/utils/helpers/date_helpers.dart';
import 'package:ingressos/features/ticket/domain/entities/ticket_entity.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';

class PrintingTicket {
  PrintingTicket({required this.ticket});

  final Ticket ticket;
  final dataFormatada = DateFormat('dd/MM/yyyy', 'pt_BR');
  final timeFormat = DateFormat('HH:mm');
  final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  Future<List<int>> escPosPrinting() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];

    final ByteData data = await rootBundle.load("assets/images/logo_cinema.png");
    final Uint8List bytesLogo = data.buffer.asUint8List();
    final img.Image image = img.decodeImage(bytesLogo)!;

    bytes += generator.hr(ch: "-", len: 20);
    bytes += generator.image(image);
    bytes += generator.text(
      "CINEMA DIGITAL MOVIE",
      styles: const PosStyles(bold: true, align: PosAlign.center),
    );
    bytes += generator.hr(ch: "-", len: 20);

    bytes += generator.feed(3);
    bytes += generator.text("FILME: ${ticket.filme.titulo}");

    bytes += generator.row([
      PosColumn(
        text: "DATA: ${dataFormatada.format(ticket.dataSessao)}",
        styles: PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: "HORA: ${DateHelpers.getHoraFormatada(ticket.horarioSessao)}",
        styles: PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: "SALA: ${ticket.sala.nome}",
        styles: PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: "SESSÃO: ${ticket.tipoSessao.description}",
        styles: PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: "ASSENTOS: ${ticket.assento.map((e) => e.posicao).join(", ")}",
        styles: PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: "TIPO: ${ticket.tipoIngresso.description.toUpperCase()}",
        styles: PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.feed(3);
    bytes += generator.hr(ch: "-", len: 20);

    bytes += generator.text("FORMA PAGAMENTO: PIX");
    bytes += generator.text("VALOR TOTAL: ${currencyFormat.format(ticket.valor)}");

    bytes += generator.feed(3);
    bytes += generator.hr(ch: "-", len: 20);

    bytes += generator.text(
      "Apresente este ingresso no acesso ao cinema ou na catraca",
      styles: PosStyles(align: PosAlign.center),
    );

    bytes += generator.text(
      "Compra efetuada via aplicativo",
      styles: PosStyles(align: PosAlign.center, fontType: PosFontType.fontA),
    );

    bytes += generator.feed(2);

    return bytes;
  }

  pw.Document buildCinemaTicketPdf() {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat(80 * PdfPageFormat.mm, PdfPageFormat.a4.height),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  'CINEMA DIGITAL MOVIE',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Divider(),

              pw.Text(
                'FILME: ${ticket.filme.titulo}',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('DATA: ${dataFormatada.format(ticket.dataSessao)}'),
                  pw.Text('HORA: ${DateHelpers.getHoraFormatada(ticket.horarioSessao)}'),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('SALA: ${ticket.sala.nome}'),
                  pw.Text('SESSÃO: ${ticket.tipoSessao.description}'),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('ASSENTOS: ${ticket.assento.map((e) => e.posicao).join(', ')}'),
                  pw.Text('TIPO: ${ticket.tipoIngresso.description.toUpperCase()}'),
                ],
              ),

              pw.Divider(),

              pw.Text('FORMA PAGAMENTO: PIX'),
              pw.Text('VALOR TOTAL: ${currencyFormat.format(ticket.valor)}'),

              pw.Divider(),

              pw.SizedBox(height: 20),

              pw.Center(
                child: pw.Text(
                  'Apresente este ingresso no acesso ao cinema ou na catraca',
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.Center(
                child: pw.Text(
                  'Compra efetuada via aplicativo',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  Widget preview() {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final timeFormat = DateFormat('HH:mm');
    final NumberFormat currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 100,
            child: Center(
              child: Image.asset('assets/images/logo_cinema.png'),
            ),
          ),
          const SizedBox(height: 8),
          Divider(thickness: 2),
          const SizedBox(height: 6),
          Text(
            'CINEMA DIGITAL MOVIE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Divider(thickness: 2),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'FILME: ${ticket.filme.titulo}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('DATA: ${dateFormat.format(ticket.dataSessao)}', style: TextStyle(fontSize: 18)),
              Text('HORA: ${timeFormat.format(ticket.horarioSessao)}', style: TextStyle(fontSize: 18)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('SALA: ${ticket.sala.nome}', style: TextStyle(fontSize: 18)),
              Text('SESSÃO: ${ticket.tipoSessao.description}', style: TextStyle(fontSize: 18)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ASSENTOS: ${ticket.assento.map((e) => e.posicao).join(', ')}', style: TextStyle(fontSize: 18)),
              Text('TIPO: ${ticket.tipoIngresso.description.toUpperCase()}', style: TextStyle(fontSize: 18)),
            ],
          ),
          const SizedBox(height: 6),
          Divider(thickness: 2),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'FORMA PAGAMENTO: PIX',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'VALOR TOTAL: ${currencyFormat.format(ticket.valor)}',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 6),
          Divider(thickness: 2),
          const SizedBox(height: 6),
          Text(
            'Apresente este ingresso no acesso ao cinema ou na catraca',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text(
            'Compra efetuada via aplicativo',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
