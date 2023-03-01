import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/const/colors.dart';
import 'package:movie_app/services/bloc/cubit.dart';
import 'package:movie_app/services/bloc/states.dart';

import 'movie_details_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      onFieldSubmitted: (value) {
                        appCubit.getSearchMovie(str: value);
                      },
                      onChanged: (value) {
                        appCubit.getSearchMovie(str: value);
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: kPrimaryColor,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: kPrimaryColor,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search',
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 12),
                          child: SizedBox(
                            height: 200,
                            width: 130,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 200,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 200,
                                                decoration: const BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 5,
                                                        spreadRadius: 5,
                                                        offset: Offset(0, 2),
                                                      )
                                                    ]),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            MovieDetailScreen(
                                                                movie: appCubit
                                                                        .searchMovies[
                                                                    index]),
                                                      ),
                                                    );
                                                  },
                                                  child: Image.network(
                                                    appCubit.searchMovies[index]
                                                            .posterPath ??
                                                        '',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 5,
                                                right: 5,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: kDarkColor,
                                                        blurRadius: 20,
                                                      )
                                                    ],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.star,
                                                        color: kPrimaryColor,
                                                        size: 20,
                                                      ),
                                                      Text(
                                                        appCubit
                                                            .searchMovies[index]
                                                            .voteAverage.toInt()
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color: kWhiteColor,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        appCubit.searchMovies[index]
                                                .originalTitle ??
                                            appCubit
                                                .searchMovies[index].title ??
                                            appCubit.searchMovies[index].name ??
                                            appCubit.searchMovies[index]
                                                .originalName ??
                                            '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        'Overview',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w600,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          appCubit.searchMovies[index].overview,
                                          maxLines: 7,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 20,
                        );
                      },
                      itemCount: appCubit.searchMovies.isNotEmpty ? 4 : 0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
