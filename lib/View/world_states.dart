import 'package:covid_19_app/Model/WorldStatesModel.dart';
import 'package:covid_19_app/Services/states_services.dart';
import 'package:covid_19_app/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .01),

            FutureBuilder(
                future: statesServices.fetchWorldStatesRecords(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                  if (! snapshot.hasData) {
                    return Expanded(
                        flex: 1 ,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 20.0,
                          controller: _controller,
                        ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap:  {
                            'Total': double.parse(snapshot.data!.cases!.toString()),
                            'Recovered': double.parse(snapshot.data!.recovered.toString()),
                            'Deaths': double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions:
                          const LegendOptions(legendPosition: LegendPosition.left),
                          animationDuration: const Duration(microseconds: 1200),
                          chartType: ChartType.disc,
                          colorList: colorList,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.height * 0.06),
                          child: Card(
                            child: Column(
                              children: [
                                Reusable(
                                  title: 'Total',
                                  value: (snapshot.data!.cases!.toString()),
                                ),
                                Reusable(
                                  title: 'Recovered',
                                  value: (snapshot.data!.recovered.toString()),
                                ),
                                Reusable(
                                  title: 'Deaths',
                                  value: (snapshot.data!.deaths     .toString()),
                                ),
                                Reusable(
                                  title: 'Active',
                                  value: (snapshot.data!.active.toString()),
                                ),Reusable(
                                  title: 'Critical',
                                  value: (snapshot.data!.critical!.toString()),
                                ),Reusable(
                                  title: 'Today Recovered',
                                  value: (snapshot.data!.todayRecovered.toString()),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>const  CountriesListScreen()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10)),
                            child: const  Center(
                              child: Text('Track Countries'),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }),

          ],
        ),
      )),
    );
  }
}

class Reusable extends StatelessWidget {
  String title, value;
  Reusable({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
