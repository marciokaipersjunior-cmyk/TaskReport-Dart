import 'models/tarefa.dart';
import 'service/dados.dart';

void main() {
  List<Tarefa> listaTarefas = [];

  for (var item in dadosTarefas) {
    Tarefa tarefaConvertida = Tarefa.fromMap(item);
    listaTarefas.add(tarefaConvertida);
  }

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

  print('');

  for (var tarefaAtual in listaTarefas) {
    tarefaAtual.exibirResumo();
  }

  List<Tarefa> tarefasConcluidas = listaTarefas
      .where((tarefa) => tarefa.status == 'concluida')
      .toList();

  double valorTotalConcluidas = listaTarefas
      .where((tarefa) => tarefa.status == 'concluida')
      .fold(0.0, (acumulador, tarefa) => acumulador + tarefa.valor);

  print('\nTotal de tarefas concluídas: R\$ $valorTotalConcluidas');

  List<Tarefa> tarefasEmAndamento = listaTarefas
      .where((tarefa) => tarefa.status == 'em andamento')
      .toList();

  List<Tarefa> tarefasPendentes = listaTarefas
      .where((tarefa) => tarefa.status == 'pendente')
      .toList();

  if (tarefasPendentes.isEmpty) {
    print('\nNão existem tarefas pendentes para calcular média.');
  } else {
    double somaPendentes = tarefasPendentes.fold(
      0.0,
      (acumulador, tarefa) => acumulador + tarefa.valor,
    );

    double mediaPendentes = somaPendentes / tarefasPendentes.length;

    print('\nMédia de valor das tarefas pendentes: R\$ $mediaPendentes');
  }

  List<Tarefa> tarefasCanceladas = listaTarefas
      .where((tarefa) => tarefa.status == 'cancelada')
      .toList();

  print('\nTarefas concluídas:');
  for (var tarefa in tarefasConcluidas) {
    print('- ${tarefa.titulo}');
  }

  print('\nTarefas em andamento:');
  for (var tarefa in tarefasEmAndamento) {
    print('- ${tarefa.titulo}');
  }

  print('\nTarefas pendentes:');
  for (var tarefa in tarefasPendentes) {
    print('- ${tarefa.titulo}');
  }

  print('\nTarefas canceladas:');
  for (var tarefa in tarefasCanceladas) {
    print('- ${tarefa.titulo}');
  }
}
