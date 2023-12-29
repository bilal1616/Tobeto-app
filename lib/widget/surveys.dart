import 'package:flutter/material.dart';

class Surveys extends StatefulWidget {
  const Surveys({Key? key}) : super(key: key);

  @override
  _SurveysState createState() => _SurveysState();
}

class _SurveysState extends State<Surveys> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 350,
          height: 275,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  "assets/anket.png",
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 17),
                child: Text("Atanmış herhangi bir anketiniz bulunmamaktadır.",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
              )
            ],
          ),
        ),
        SizedBox(height: 25)
      ],
    );
  }
}
