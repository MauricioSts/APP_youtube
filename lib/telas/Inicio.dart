import 'package:app_youtube/Api.dart';
import 'package:app_youtube/model/Video.dart';
import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  Future<List<Video>> _listarVideos() async {
    Api api = Api();
    return api.pesquisar(
      "vinicius13",
    ); // Supondo que pesquisar retorne um Future<List<Video>>
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      //ele constroi a interface com base no estado de um future, ele recebe 2 parametros
      future: _listarVideos(), //o future é 1 parametro que sera aguardado
      builder: (context, snapshot) {
        //funcao que sera chamado toda vez que o future mudar
        switch (snapshot.connectionState) {
          //indica o estado da requisicao
          case ConnectionState.none: //nenhuma requesicao
          case ConnectionState.waiting: // a resposta ainda n chegou
            return Center(child: CircularProgressIndicator());
          case ConnectionState
              .active: //a requisicao esta ativa mas ainda n chegou
          case ConnectionState.done: // a requisicao foi concluida
            if (snapshot.hasData) {
              /// se tiver dados os videos sao extraidos
              List<Video> videos = snapshot.data!;
              return ListView.separated(
                // é uma listview com separacao entre os itens
                itemBuilder: (context, index) {
                  Video video =
                      videos[index]; //responsavel por pegar cada video com base no index
                  return Column(
                    children: <Widget>[
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(video.imagem),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(video.titulo),
                        subtitle: Text(video.canal),
                      ),
                    ],
                  );
                },
                separatorBuilder:
                    (context, index) => Divider(height: 2, color: Colors.grey),
                itemCount: videos.length,
              );
            } else {
              return Center(child: Text("Nenhum dado a ser exibido!"));
            }
            break;
        }
      },
    );
  }
}
