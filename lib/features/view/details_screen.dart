import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/data/actor_model.dart';
import '../cubit/movie_cubit.dart';
import '../cubit/movie_state.dart';
import '../data/movie_api.dart';
import '../data/movie_model.dart';

class DetailsScreen extends StatefulWidget {
  final Movie movie;
  const DetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MovieCubit>().getActors(widget.movie.id);

  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Positioned.fill(
            child: Image.network(
              widget.movie.fullPosterUrl,
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color(0xff191923),
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          ListView(
            padding: EdgeInsets.zero,
            children: [
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(backgroundColor: Colors.black.withOpacity(0.5), child: BackButton(color: Colors.white,)),
                      Row(
                        children: [
                          const Text("A NETFLIX FILM", style: TextStyle(color: Colors.white70, fontSize: 10, letterSpacing: 1.2)),
                        ],
                      ),
                      CircleAvatar(backgroundColor: Colors.black.withOpacity(0.5), child: IconButton(icon: Icon(Icons.share, color: Colors.white,), onPressed: (){})),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 250),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.red,
                        child: Icon(Icons.play_arrow, size: 40, color: Colors.white,),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Align(alignment: Alignment.centerRight, child: Text("1h 44min", style: TextStyle(color: Colors.white70, fontSize: 12))),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        _buildTag("+18"),
                        const SizedBox(width: 8),
                        _buildTag("Action"),
                        const SizedBox(width: 15),
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 5),
                        Text(widget.movie.rating.toStringAsFixed(1), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        const Spacer(),
                        const Icon(Icons.favorite, color: Colors.red),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Text(widget.movie.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),

                    Text(
                      widget.movie.overview,
                      style: TextStyle(color: Colors.grey[300], fontSize: 13, height: 1.4),
                    ),

                    const SizedBox(height: 20),

                    const Text("Actors", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    BlocBuilder<MovieCubit, MovieState>(
                      builder: (context, state) {

                        if (state is ActorsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is ActorsError) {
                          return Text(state.message);
                        }

                        if (state is ActorsSuccess) {
                          return _buildActorsSection(state.actors);
                        }

                        return const SizedBox();
                      },
                    ),

                    const SizedBox(height: 25),


                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFFD700),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text("Open IMDb", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xff21212E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 11)),
    );
  }

  Widget _buildActorsSection(List<Actor> actors) {

    return SizedBox(
      height: 90,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,

        itemBuilder: (context,index){

          final actor = actors[index];


          return Container(
            margin: const EdgeInsets.only(right:15),
            width:70,

            child: Column(
              children:[

                CircleAvatar(
                  radius:25,

                  backgroundImage:
                  actor.fullImageUrl.isNotEmpty
                      ? NetworkImage(actor.fullImageUrl)
                      : null,

                  child: actor.fullImageUrl.isEmpty
                      ? const Icon(Icons.person)
                      : null,
                ),


                const SizedBox(height:5),


                Text(
                  actor.name,
                  maxLines:1,
                  overflow:TextOverflow.ellipsis,

                  style: const TextStyle(
                      color:Colors.grey,
                      fontSize:10
                  ),

                  textAlign:TextAlign.center,
                )

              ],
            ),
          );

        },
      ),
    );
  }
}