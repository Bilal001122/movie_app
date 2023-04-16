import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/const/colors.dart';
import 'package:movie_app/logic/services/bloc/actors/actors_cubit.dart';
import 'package:movie_app/logic/services/bloc/actors/actors_state.dart';
import 'package:movie_app/presentation/screens/actor_details.dart';

class ActorsScreen extends StatelessWidget {
  const ActorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActorsCubit, ActorsState>(
      listener: (context, state) {},
      builder: (context, state) {
        ActorsCubit actorsCubit = ActorsCubit.get(context);
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: GridView.builder(
                itemCount: actorsCubit.actors.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: actorsCubit.actors[index].name!,
                          flightShuttleBuilder: (flightContext, animation,
                              flightDirection, fromHeroContext, toHeroContext) {
                            switch (flightDirection) {
                              case HeroFlightDirection.push:
                                return ScaleTransition(
                                  scale: animation.drive(
                                    Tween<double>(begin: 0.0, end: 1.3).chain(
                                      CurveTween(curve: Curves.decelerate),
                                    ),
                                  ),
                                  child: toHeroContext.widget,
                                );
                              case HeroFlightDirection.pop:
                                return ScaleTransition(
                                  scale: animation.drive(
                                    Tween<double>(begin: 1.3, end: 0.0).chain(
                                      CurveTween(curve: Curves.decelerate),
                                    ),
                                  ),
                                  child: fromHeroContext.widget,
                                );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: kPrimaryColor,
                                width: 2,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 20,
                                  spreadRadius: 1,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ActorDetails(
                                      actor: actorsCubit.actors[index],
                                    ),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: CachedNetworkImageProvider(
                                  actorsCubit.actors[index].profilePath!,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          actorsCubit.actors[index].name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
