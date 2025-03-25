import 'package:app_youtube/Api.dart';
import 'package:app_youtube/model/Video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  final String pesquisa;
  Inicio(this.pesquisa);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  Future<List<Video>> _listarVideos(String pesquisa) async {
    Api api = Api();
    return api.pesquisar(pesquisa);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: _listarVideos(widget.pesquisa),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              List<Video> videos = snapshot.data!;
              return ListView.separated(
                itemBuilder: (context, index) {
                  Video video = videos[index];
                  return Column(
                    children: [
                      YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: video.id,
                          flags: YoutubePlayerFlags(
                            autoPlay: false,
                            isLive: false,
                          ),
                        ),
                        showVideoProgressIndicator: true,
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
        }
      },
    );
  }
}
