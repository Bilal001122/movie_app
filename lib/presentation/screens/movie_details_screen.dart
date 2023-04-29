import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app/const/colors.dart';
import 'package:movie_app/logic/models/movie.dart';
import '../../logic/services/bloc/favorites/favorites_cubit.dart';
import '../../logic/services/bloc/favorites/favorites_state.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieModel movie;
  final String textLabelCategorie;

  const MovieDetailScreen(
      {Key? key, required this.movie, required this.textLabelCategorie})
      : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _animation = Tween<double>(begin: 1, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.decelerate,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<FavoritesCubit, FavoritesState>(
        listener: (context, state) {},
        builder: (context, state) {
          FavoritesCubit favoritesCubit = FavoritesCubit.get(context);
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: kPrimaryColor,
              onPressed: () {
                favoritesCubit.addAndDeleteHandling(widget.movie);
                _controller.forward().then((value) => _controller.reverse());
                Fluttertoast.showToast(
                    msg: "Added Successfully",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 3,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => Icon(
                  size: _animation.value * 30,
                  Icons.favorite,
                  color: favoritesCubit.favoritesNames
                              .contains(widget.movie.name) ||
                          favoritesCubit.favoritesNames
                              .contains(widget.movie.title)
                      ? Colors.red
                      : Colors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag:
                            'hero${widget.movie.posterPath + widget.textLabelCategorie}',
                        flightShuttleBuilder: (flightContext, animation,
                            flightDirection, fromHeroContext, toHeroContext) {
                          switch (flightDirection) {
                            case HeroFlightDirection.push:
                              return ScaleTransition(
                                scale: animation.drive(
                                  Tween<double>(begin: 0.0, end: 1).chain(
                                    CurveTween(curve: Curves.bounceInOut),
                                  ),
                                ),
                                child: toHeroContext.widget,
                              );
                            case HeroFlightDirection.pop:
                              return ScaleTransition(
                                scale: animation.drive(
                                  Tween<double>(begin: 1, end: 0.0).chain(
                                    CurveTween(curve: Curves.bounceInOut),
                                  ),
                                ),
                                child: fromHeroContext.widget,
                              );
                          }
                        },
                        child: SizedBox(
                          height: 400,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                            child: CachedNetworkImage(
                              key: UniqueKey(),
                              imageUrl: widget.movie.posterPath ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: kPrimaryColor,
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.play_arrow,
                              color: kWhiteColor,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.movie.title != null &&
                                    widget.movie.title != 'null' &&
                                    widget.movie.title!.length > 25
                                ? widget.movie.title!.substring(0, 25)
                                : widget.movie.originalTitle != null &&
                                        widget.movie.originalTitle != 'null' &&
                                        widget.movie.originalTitle!.length > 25
                                    ? widget.movie.originalTitle!
                                        .substring(0, 25)
                                    : widget.movie.name != null &&
                                            widget.movie.name != 'null' &&
                                            widget.movie.name!.length > 25
                                        ? widget.movie.name!.substring(0, 25)
                                        : widget.movie.originalName != null &&
                                                widget.movie.originalName !=
                                                    'null' &&
                                                widget.movie.originalName!
                                                        .length >
                                                    25
                                            ? widget.movie.originalName!
                                                .substring(0, 25)
                                            : widget.movie.title != null &&
                                                    widget.movie.title != 'null'
                                                ? widget.movie.title!
                                                : widget.movie.originalTitle !=
                                                            null &&
                                                        widget.movie
                                                                .originalTitle !=
                                                            'null'
                                                    ? widget
                                                        .movie.originalTitle!
                                                    : widget.movie.name !=
                                                                null &&
                                                            widget.movie.name !=
                                                                'null'
                                                        ? widget.movie.name!
                                                        : widget.movie.originalName !=
                                                                    null &&
                                                                widget.movie
                                                                        .originalName !=
                                                                    'null'
                                                            ? widget.movie
                                                                .originalName!
                                                            : '',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Text('  |  '),
                          Text(
                            widget.movie.releaseDate != null &&
                                    widget.movie.releaseDate != 'null'
                                ? widget.movie.releaseDate!
                                : widget.movie.firstAirDate != null &&
                                        widget.movie.firstAirDate != 'null'
                                    ? widget.movie.firstAirDate!
                                    : '',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const Text('  |  '),
                          Row(
                            children: [
                              Text(
                                '${widget.movie.voteAverage is num ? (widget.movie.voteAverage).toStringAsFixed(1) : double.parse(
                                    widget.movie.voteAverage,
                                  ).toStringAsFixed(1)} ',
                                // (widget.movie.voteAverage as double).toStringAsFixed(1),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              const Icon(
                                Icons.star,
                                size: 18,
                                color: kPrimaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Overview',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              widget.movie.overview!,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
