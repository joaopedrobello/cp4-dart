import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/cast_model.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/pages/cast_detail/person_detail_page.dart';
import 'package:movie_app/services/api_services.dart';

class CastDetailPage extends StatefulWidget {
  final int movieId;
  final MovieDetailModel movie;
  const CastDetailPage({super.key, required this.movieId, required this.movie});

  @override
  State<CastDetailPage> createState() => _CastDetailPageState();
}

class _CastDetailPageState extends State<CastDetailPage> {
  ApiServices apiServices = ApiServices();

  late Future<Cast> castData;

  @override
  void initState() {
    fetchInitialData();
    super.initState();
  }

  fetchInitialData() {
    castData = apiServices.getMovieCast(widget.movieId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    String genresText =
        widget.movie.genres.map((genre) => genre.name).join(', ');

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: size.height * 0.4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            NetworkImage("$imageUrl${widget.movie.posterPath}"),
                        fit: BoxFit.cover)),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.movie.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      widget.movie.releaseDate.year.toString(),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      genresText,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  widget.movie.overview,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          FutureBuilder(
            future: castData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final cast = snapshot.data;

                const String castString = 'Cast';

                return cast!.actors.isEmpty
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            castString,
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: cast.actors.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 15,
                              childAspectRatio: 1.5 / 2,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PersonDetailPage(
                                          personId: cast.actors[index].id),
                                    ),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Name: ${cast.actors[index].originalName}",
                                      maxLines: 6,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Character: ${cast.actors[index].character}",
                                      maxLines: 6,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Image(
                                      height: 500,
                                      width: 300,
                                      image: NetworkImage(
                                        "$imageUrl${cast.actors[index].profilePath}",
                                      ),
                                      fit: BoxFit.cover
                                    ),
                                  ]
                                ,)
                              );
                            },
                          ),
                        ],
                      );
              }
              return const Text("Something Went wrong");
            },
          ),
        ],
      )),
    );
  }
}
