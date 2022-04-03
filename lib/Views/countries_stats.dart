import 'package:covid_tracker/Services/stats_services.dart';
import 'package:flutter/material.dart';

class CountriesStatsScreen extends StatefulWidget {
  const CountriesStatsScreen({Key? key}) : super(key: key);
  @override
  State<CountriesStatsScreen> createState() => _CountriesStatsScreenState();
}

class _CountriesStatsScreenState extends State<CountriesStatsScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
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
                    return Text("Loading.....");
                  } else {}
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(snapshot.data?[index]['country']),
                            leading: Image(
                              height: 50,
                              width: 50,
                              image: NetworkImage(
                                  snapshot.data?[index]['countryInfo']['flag']),
                            ),
                            subtitle:
                                Text(snapshot.data![index]['cases'].toString()),
                          )
                        ],
                      );
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
