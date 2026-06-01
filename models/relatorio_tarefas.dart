import 'tarefa.dart';

class RelatorioTarefas {
  final List<Tarefa> _tarefas;

  RelatorioTarefas(List<Tarefa> tarefas) : _tarefas = tarefas;

  int get quantidadeTotal => _tarefas.length;

  int get quantidadeConcluidas =>
      _tarefas.where((tarefa) => tarefa.status == 'concluida').length;

  int get quantidadePendentes =>
      _tarefas.where((tarefa) => tarefa.status == 'pendente').length;

  int get quantidadeEmAndamento =>
      _tarefas.where((tarefa) => tarefa.status == 'em andamento').length;

  int get quantidadeCanceladas =>
      _tarefas.where((tarefa) => tarefa.status == 'cancelada').length;
}
