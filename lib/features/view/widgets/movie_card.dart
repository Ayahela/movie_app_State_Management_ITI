import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../data/movie_model.dart';
import '../details_screen.dart';
import '../../cubit/movie_cubit.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final movieCubit = BlocProvider.of<MovieCubit>(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: movieCubit,
              child: DetailsScreen(movie: movie),
            ),
          ),
        );
      },
      child: Container(
        width: 110,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                movie.fullPosterUrl,
                height: 150,
                width: 110,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(height: 150, width: 110, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 7),
            Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 4),
            RatingBarIndicator(
              rating: movie.rating / 2,
              itemCount: 5,
              itemSize: 13,
              itemBuilder: (_, __) =>
              const Icon(Icons.star, color: Colors.amber),
            ),
          ],
        ),
      ),
    );
  }
}