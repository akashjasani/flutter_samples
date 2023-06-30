import 'package:flutter/material.dart';
import 'package:foodmelaapp/dummy_data.dart';
import '../models/Meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const routName = 'MeanDetailScreen';

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget buildContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String mealId = ModalRoute.of(context)?.settings.arguments as String;
    final mealDetails =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(mealDetails.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                mealDetails.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              child: ListView.builder(
                  itemCount: mealDetails.ingredients.length,
                  itemBuilder: (context, index) => Card(
                        color: Theme.of(context).accentColor,
                        child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(mealDetails.ingredients[index], style: TextStyle(color: Colors.black),)),
                      )),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
                child: ListView.builder(
              itemBuilder: (context, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('# ${index + 1}'),
                    ),
                    title: Text(mealDetails.steps[index]),
                  ),
                  const Divider()
                ],
              ),
              itemCount: mealDetails.steps.length,
            ))
          ],
        ),
      ),
    );
  }
}
