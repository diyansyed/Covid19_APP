import 'package:covid_19_app/View/world_states.dart';
import 'package:flutter/material.dart';
class DetailScreen extends StatefulWidget {
  String name,image;
  int totalCases,totalDeaths,totalRecovered,active,critical,todayRecovered,test;
   DetailScreen({
     required this.name,
     required this.image,
     required this.totalCases,
     required this.todayRecovered,
     required this.active,
     required this.critical,
     required this.totalDeaths,
     required this.totalRecovered,
     required this.test,
     super.key


   });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [

                      SizedBox(height: 50,),
                    Reusable(title: 'Total Cases', value: widget.totalCases.toString()),
                    Reusable(title: 'Total Recovered', value: widget.totalRecovered.toString()),
                    Reusable(title: 'Recovered today', value: widget.todayRecovered.toString()),
                    Reusable(title: 'Active Cases', value: widget.active.toString()),
                    Reusable(title: 'Critical', value: widget.critical.toString()),
                    Reusable(title: 'Deaths', value: widget.totalDeaths.toString()),
                    Reusable(title: 'Tests', value: widget.test.toString()),


                ],),),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
            ],
          )
        ],
      ),
    );
  }
}
