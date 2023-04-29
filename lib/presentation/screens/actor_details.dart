import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/const/colors.dart';
import 'package:movie_app/logic/models/movie.dart';
import 'package:movie_app/presentation/shared/widgets/movie_widget.dart';

import '../../logic/models/actor_model.dart';

class ActorDetails extends StatelessWidget {
  final ActorModel actor;

  const ActorDetails({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Hero(
                tag: actor.name!,
                child: CachedNetworkImage(
                  imageUrl: actor.profilePath!,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 350,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Name :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    actor.name!,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Known For :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: actor.knownFor!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      childAspectRatio: 0.62,
                    ),
                    itemBuilder: (context, index) {
                      return MovieWidget(
                        movie: MovieModel(
                          id: actor.knownFor![index].id,
                          title: actor.knownFor![index].title,
                          posterPath: actor.knownFor![index].posterPath,
                          voteAverage: actor.knownFor![index].voteAverage,
                          releaseDate: actor.knownFor![index].releaseDate,
                          originalLanguage:
                              actor.knownFor![index].originalLanguage,
                          overview: actor.knownFor![index].overview,
                          originalTitle: actor.knownFor![index].originalTitle,
                          mediaType: null,
                          name: actor.knownFor![index].name,
                          originalName: actor.knownFor![index].originalName,
                          firstAirDate: null,
                        ),
                        textLabelCategorie: 'tt',
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
