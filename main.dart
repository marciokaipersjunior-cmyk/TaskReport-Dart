import 'models/tarefa.dart';
import 'service/dados.dart';
import 'models/relatorio_tarefas.dart';

void main() {
  List<Tarefa> listaTarefas = [];

  for (var item in dadosTarefas) {
    Tarefa tarefaConvertida = Tarefa.fromMap(item);
    listaTarefas.add(tarefaConvertida);
  }

  print('TAREFAS CONVERTIDAS:');
  for (var tarefaAtual in listaTarefas) {
    print('');
    print('ID: ${tarefaAtual.id}');
    print('Título: ${tarefaAtual.titulo}');
    print('Responsável: ${tarefaAtual.responsavel}');
    print('Status: ${tarefaAtual.status}');
    print('Prioridade: ${tarefaAtual.prioridade}');
    print('Valor: R\$ ${tarefaAtual.valor}');
    print('Horas: ${tarefaAtual.horas}');
  }

  print('\nRESUMO DAS TAREFAS:');
  for (var tarefaAtual in listaTarefas) {
    tarefaAtual.exibirResumo();
  }

  List<Tarefa> tarefasConcluidas = listaTarefas
      .where((tarefa) => tarefa.status == 'concluida')
      .toList();

  List<Tarefa> tarefasEmAndamento = listaTarefas
      .where((tarefa) => tarefa.status == 'em andamento')
      .toList();

  List<Tarefa> tarefasPendentes = listaTarefas
      .where((tarefa) => tarefa.status == 'pendente')
      .toList();

  List<Tarefa> tarefasCanceladas = listaTarefas
      .where((tarefa) => tarefa.status == 'cancelada')
      .toList();

  print('\nTAREFAS CONCLUÍDAS:');
  for (var tarefa in tarefasConcluidas) {
    print('- ${tarefa.titulo}');
  }

  print('\nTAREFAS EM ANDAMENTO:');
  for (var tarefa in tarefasEmAndamento) {
    print('- ${tarefa.titulo}');
  }

  print('\nTAREFAS PENDENTES:');
  for (var tarefa in tarefasPendentes) {
    print('- ${tarefa.titulo}');
  }

  print('\nTAREFAS CANCELADAS:');
  for (var tarefa in tarefasCanceladas) {
    print('- ${tarefa.titulo}');
  }

  double valorTotalConcluidas = tarefasConcluidas.fold(
    0.0,
    (acumulador, tarefa) => acumulador + tarefa.valor,
  );

  print(
    '\nValor total das tarefas concluídas: R\$ ${valorTotalConcluidas.toStringAsFixed(2)}',
  );

  if (tarefasPendentes.isEmpty) {
    print('\nNão existem tarefas pendentes para calcular média.');
  } else {
    double somaPendentes = tarefasPendentes.fold(
      0.0,
      (acumulador, tarefa) => acumulador + tarefa.valor,
    );

    double mediaPendentes = somaPendentes / tarefasPendentes.length;

    print(
      '\nMédia de valor das tarefas pendentes: R\$ ${mediaPendentes.toStringAsFixed(2)}',
    );
  }

  Map<String, int> horasPorStatus = {
    'concluida': 0,
    'em andamento': 0,
    'pendente': 0,
    'cancelada': 0,
  };

  for (var tarefa in listaTarefas) {
    horasPorStatus[tarefa.status] =
        (horasPorStatus[tarefa.status] ?? 0) + tarefa.horas;
  }

  print('\nHORAS POR STATUS:');
  horasPorStatus.forEach((status, totalHoras) {
    print('$status: $totalHoras horas');
  });

  print('\nTAREFAS COM DADOS INCOMPLETOS:');
  for (var item in dadosTarefas) {
    List<String> problemas = [];

    if (item['titulo'] == null || item['titulo'].toString().trim().isEmpty) {
      problemas.add('título ausente');
    }

    if (item['responsavel'] == null ||
        item['responsavel'].toString().trim().isEmpty) {
      problemas.add('responsável ausente');
    }

    if (item['horas'] == null || item['horas'].toString().trim().isEmpty) {
      problemas.add('horas ausentes');
    }

    if (item['status'] == null || item['status'].toString().trim().isEmpty) {
      problemas.add('status ausente');
    }

    if (item['valor'] == null || item['valor'].toString().trim().isEmpty) {
      problemas.add('valor ausente');
    }

    if (problemas.isNotEmpty) {
      print('- ID ${item['id']}: ${problemas.join(' ou ')}');
    }
  }

  Set<String> statusUnicos = {};

  for (var tarefa in listaTarefas) {
    statusUnicos.add(tarefa.status);
  }

  print('\nSTATUS ENCONTRADOS:');
  for (var status in statusUnicos) {
    print(status);
  }

  RelatorioTarefas relatorio = RelatorioTarefas(listaTarefas);

  int horasConcluidas = tarefasConcluidas.fold(
    0,
    (acumulador, tarefa) => acumulador + tarefa.horas,
  );

  double mediaPendentesFinal = 0.0;
  if (tarefasPendentes.isNotEmpty) {
    double somaPendentes = tarefasPendentes.fold(
      0.0,
      (acumulador, tarefa) => acumulador + tarefa.valor,
    );
    mediaPendentesFinal = somaPendentes / tarefasPendentes.length;
  }

  print('\nRELATÓRIO FINAL DE TAREFAS');
  print('Total de tarefas analisadas: ${relatorio.quantidadeTotal}');
  print('Tarefas concluídas: ${relatorio.quantidadeConcluidas}');
  print('Tarefas pendentes: ${relatorio.quantidadePendentes}');
  print('Tarefas em andamento: ${relatorio.quantidadeEmAndamento}');
  print('Tarefas canceladas: ${relatorio.quantidadeCanceladas}');

  print(
    '\nValor total das concluídas: R\$ ${valorTotalConcluidas.toStringAsFixed(2)}',
  );
  print(
    'Média de valor das pendentes: R\$ ${mediaPendentesFinal.toStringAsFixed(2)}',
  );
  print('Total de horas concluídas: $horasConcluidas');

  print('\nStatus encontrados:');
  for (var status in statusUnicos) {
    print(status);
  }

  print('\nTarefas com dados incompletos:');
  for (var item in dadosTarefas) {
    List<String> problemas = [];

    if (item['titulo'] == null || item['titulo'].toString().trim().isEmpty) {
      problemas.add('título ausente');
    }

    if (item['responsavel'] == null ||
        item['responsavel'].toString().trim().isEmpty) {
      problemas.add('responsável ausente');
    }

    if (item['horas'] == null || item['horas'].toString().trim().isEmpty) {
      problemas.add('horas ausentes');
    }

    if (item['status'] == null || item['status'].toString().trim().isEmpty) {
      problemas.add('status ausente');
    }

    if (item['valor'] == null || item['valor'].toString().trim().isEmpty) {
      problemas.add('valor ausente');
    }

    if (problemas.isNotEmpty) {
      String tituloOriginal = (item['titulo'] ?? 'Sem título')
          .toString()
          .trim();

      if (tituloOriginal.isEmpty) {
        tituloOriginal = 'Sem título';
      }

      print('ID ${item['id']} - $tituloOriginal');
    }
  }
}
