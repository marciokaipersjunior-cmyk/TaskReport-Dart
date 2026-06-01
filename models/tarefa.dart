import 'trabalho.dart';

class Tarefa extends ItemTrabalho {
  String responsavel;
  String status;
  String prioridade;
  double valor;
  int horas;

  Tarefa({
    required int id,
    required String titulo,
    required this.responsavel,
    required this.status,
    required this.prioridade,
    required this.valor,
    required this.horas,
  }) : super(id: id, titulo: titulo);

  factory Tarefa.fromMap(Map<String, dynamic> dados) {
    return Tarefa(
      id: dados['id'] ?? 0,
      titulo: _limparTexto(dados['titulo'], 'Sem Título'),
      responsavel: _limparTexto(dados['responsavel'], 'Não Informado'),
      status: _limparTexto(dados['status'], 'Sem Status'),
      prioridade: _limparTexto(dados['prioridade'], 'Sem Prioridade'),
      valor: _converterValor(dados['valor']),
      horas: _converterHoras(dados['horas']),
    );
  }

  static String _limparTexto(dynamic valor, String padrao) {
    if (valor == null) {
      return padrao;
    }

    String texto = valor.toString().trim();

    if (texto.isEmpty) {
      return padrao;
    }

    return texto;
  }

  static double _converterValor(dynamic valor) {
    if (valor == null) {
      return 0.0;
    }

    String valorTextoDb = valor.toString();
    valorTextoDb = valorTextoDb.replaceAll('R\$', '');
    valorTextoDb = valorTextoDb.replaceAll(' ', '');
    valorTextoDb = valorTextoDb.replaceAll(',', '.');

    return double.tryParse(valorTextoDb) ?? 0.0;
  }

  static int _converterHoras(dynamic horas) {
    if (horas == null) {
      return 0;
    }

    return int.tryParse(horas.toString()) ?? 0;
  }

  @override
  void exibirResumo() {
    print('Tarefa $id - $titulo | Status: $status | Valor: R\$ $valor');
  }
}
