import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/person_model.dart';
import 'package:movie_app/services/api_services.dart';

class PersonDetailPage extends StatefulWidget {
  final int personId;
  const PersonDetailPage({super.key, required this.personId});

  @override
  State<PersonDetailPage> createState() => _PersonDetailPageState();
}

class _PersonDetailPageState extends State<PersonDetailPage> {
  ApiServices apiServices = ApiServices();

  late Future<Person> personData;

  @override
  void initState() {
    fetchInitialData();
    super.initState();
  }

  fetchInitialData() {
    personData = apiServices.getPerson(widget.personId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
          FutureBuilder(
              future: personData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final person = snapshot.data;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                          height: 500,
                          width: 300,
                          image: NetworkImage(
                            "$imageUrl${person!.profilePath}",
                          ),
                          fit: BoxFit.cover),
                      Text(
                        person.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            person.birthday,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Text(
                            person.gender,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            person.popularity.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 15,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      Text(
                        person.biography,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  );
                }
                return const Text("Something Went wrong");
              })
        ],
      ),
    ));
  }
}
