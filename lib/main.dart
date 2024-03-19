import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => CalculateScreen()),
        GetPage(name: '/info', page: () => InfoScreen()),
      ],
    );
  }
}

class CalculateScreen extends StatelessWidget {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculate BMI'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height (cm)',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                double weight = double.tryParse(weightController.text) ?? 0;
                double heightInCm = double.tryParse(heightController.text) ?? 0;
                double heightInM = heightInCm / 100; // Convert cm to m
                double bmi = weight / (heightInM * heightInM);
                Get.toNamed('/info', arguments: bmi);
              },
              child: Text('Calculate'),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double bmi = Get.arguments;
    String category;

    if (bmi < 16) {
      category = 'Severe undernourishment';
    } else if (bmi >= 16 && bmi < 17) {
      category = 'Medium undernourishment';
    } else if (bmi >= 17 && bmi < 18.5) {
      category = 'Slight undernourishment';
    } else if (bmi >= 18.5 && bmi < 25) {
      category = 'Normal nutrition state';
    } else if (bmi >= 25 && bmi < 30) {
      category = 'Overweight';
    } else if (bmi >= 30 && bmi < 40) {
      category = 'Obesity';
    } else {
      category = 'Pathological obesity';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Info'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your BMI: $bmi',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 16),
              Text(
                'Category: $category',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
