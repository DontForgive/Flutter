import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:tubeflutter/blocs/favorite_bloc.dart';
import 'package:tubeflutter/models/video.dart';
import 'package:tubeflutter/api.dart';
class VideoTile extends StatelessWidget {

  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);
    return GestureDetector(
      onTap:(){
        FlutterYoutube.playYoutubeVideoById(
            apiKey: API_KEY,
            videoId: video.id);
      } ,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
                aspectRatio: 16/9,
              child: Image.network(video.thumb,fit: BoxFit.cover,),
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(video.title,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                        ),
                        )
                          ,),
                        Padding(padding: EdgeInsets.all(8),
                          child: Text(video.channel,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14
                          ),)
                          ,)
                      ],
                    )
                ),
               StreamBuilder<Map<String, Video>>(
                    stream: bloc.outFav,
                    builder: (context,snapshopt){
                      if(snapshopt.hasData)
                        return  IconButton(
                          icon: Icon(snapshopt.data.containsKey(video.id) ?
                          Icons.star : Icons.star_border
                          ),
                          onPressed: (){
                            bloc.toggleFavorite(video);
                          },
                          color: Colors.white,
                          iconSize: 30,);
                      else
                        return CircularProgressIndicator();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
