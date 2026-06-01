class ItemTrabalho {
  int id;
  String titulo;

  ItemTrabalho({required this.id, required this.titulo});

  void exibirResumo() {
    print('Item $id - $titulo');
  }
}
