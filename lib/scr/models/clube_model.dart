class Clube {
  int id;
  String abreviacao;
  String nome;
  int posicao;
  //String urlEscudo30x30;
  //String urlEscudo45x45;
  String urlEscudo60x60;
  
  

  Clube({this.id, 
        this.abreviacao, 
        this.nome, 
        this.posicao, 
        //this.urlEscudo30x30,
        //this.urlEscudo45x45, 
        this.urlEscudo60x60});

  factory Clube.fromJson(Map<String, dynamic> json) {
    return Clube(
      id: json['id'] as int,
      abreviacao: json['abreviacao'] as String,
      nome: json['nome'] as String,
      posicao: json['posicao'] as int,
      urlEscudo60x60: json['escudos']['60x60'] as String,
    );
  }
}