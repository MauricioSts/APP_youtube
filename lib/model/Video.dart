class Video {
  //AQUI EU ESTOU ARMAZENANDO O QUE VAI VIR DA API DO YOURUBE
  String id;
  String titulo;
  String descricao;
  String imagem;
  String canal;

  Video(
    this.id,
    this.titulo,
    this.descricao,
    this.imagem,
    this.canal,
  ); //AQUI NO CONSTRUTOR, É UTILIZADO PARA CRIAR UMA INSTANCIA DO VIDEO E INICIALIZAR SEUS ATRIBUTOS COM OS VALORES PASSADOS ACIMA

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      //AQUI É UM METODO ESPECIAL QUE CRIA UMA INSTANCIA DE VIDEO A PARTIR DE UM MAPA JSON QUE FOI DADO PELA API
      //O METODO FROMJSON FAZ REFERENCIA A ESTRUTURA HIERARQUICA DOS CAMPOS DENTRO DO JSON
      json["id"]["videoId"],
      json["snippet"]["title"],
      json["snippet"]["description"], // Corrigido
      json["snippet"]["thumbnails"]["high"]["url"],
      json["snippet"]["channelTitle"], // Corrigido: era "channelId", mas deveria ser "channelTitle"
    );
  }
}
