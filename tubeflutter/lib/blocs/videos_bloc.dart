import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:tubeflutter/api.dart';
import 'package:tubeflutter/models/video.dart';

class VideosBloc implements BlocBase {
  Api api;

  List<Video> videos;

  final StreamController<List<Video>> _videosController =
      StreamController<List<Video>>(); //acesso a saida
  Stream get outVideos => _videosController.stream;

  final StreamController<String> _searchController =
      StreamController<String>(); //acesso a entrada
  Sink get inSearch => _searchController.sink;

  VideosBloc() {
    api = Api();

    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    if (search != null) {
      _videosController.sink.add([]);

      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }

    _videosController.sink.add(videos);

    print(videos);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _videosController.close();
    _searchController.close();
  }
}
