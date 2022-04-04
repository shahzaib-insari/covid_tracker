
import 'package:covid_tracker/ViewModels/world_stats_view_model.dart';
import 'package:covid_tracker/Views/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesStatsScreen extends StatefulWidget {
  const CountriesStatsScreen({Key? key}) : super(key: key);
  @override
  State<CountriesStatsScreen> createState() => _CountriesStatsScreenState();
}

class _CountriesStatsScreenState extends State<CountriesStatsScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    WorldStatsViewModel statsServices = WorldStatsViewModel();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintText: 'Search with country name',
                  suffixIcon: searchController.text.isEmpty
                      ? const Icon(Icons.search)
                      : GestureDetector(
                          onTap: () {
                            searchController.text = "";
                            setState(() {});
                          },
                          child: Icon(Icons.clear)),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statsServices.fetchCountriesStats(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                  height: 10,
                                  width: 80,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 80,
                                  color: Colors.white,
                                ),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                        );
                      },
                    );
                  } else {}
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];

                      if (searchController.text.isEmpty) {
                        return InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                image: snapshot.data![index]['countryInfo']
                                    ['flag'],
                                name: snapshot.data![index]['country'],
                                totalCases: snapshot.data![index]['cases'],
                                totalRecovered: snapshot.data![index]
                                    ['recovered'],
                                totalDeaths: snapshot.data![index]['deaths'],
                                active: snapshot.data![index]['active'],
                                test: snapshot.data![index]['tests'],
                                todayRecovered: snapshot.data![index]
                                    ['todayRecovered'],
                                critical: snapshot.data![index]['critical'],
                              ),
                            ),
                          ),
                          child: ListTile(
                            title: Text(snapshot.data?[index]['country']),
                            leading: Image(
                              height: 50,
                              width: 50,
                              image: NetworkImage(
                                  snapshot.data?[index]['countryInfo']['flag']),
                            ),
                            subtitle:
                                Text(snapshot.data![index]['cases'].toString()),
                          ),
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                        return InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                image: snapshot.data![index]['countryInfo']
                                    ['flag'],
                                name: snapshot.data![index]['country'],
                                totalCases: snapshot.data![index]['cases'],
                                totalRecovered: snapshot.data![index]
                                    ['recovered'],
                                totalDeaths: snapshot.data![index]['deaths'],
                                active: snapshot.data![index]['active'],
                                test: snapshot.data![index]['tests'],
                                todayRecovered: snapshot.data![index]
                                    ['todayRecovered'],
                                critical: snapshot.data![index]['critical'],
                              ),
                            ),
                          ),
                          child: ListTile(
                            title: Text(snapshot.data?[index]['country']),
                            leading: Image(
                              height: 50,
                              width: 50,
                              image: NetworkImage(
                                  snapshot.data?[index]['countryInfo']['flag']),
                            ),
                            subtitle:
                                Text(snapshot.data![index]['cases'].toString()),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
