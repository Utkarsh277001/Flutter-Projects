import 'package:flutter/material.dart';

class ShoulderExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildMeditationExerciseCard(
              context,
              'DUMBBELL LATERAL RAISE',
              'assets/exercise/dumbbelllateralraise.gif',
              '''1. Stand with your feet shoulder-width apart and hold a dumbbell in each hand at your sides with your palms facing your body.\n
2. Raise both dumbbells up and out to your sides until they reach shoulder height. Keep your elbows slightly bent throughout the movement.\n
3. Hold for a brief moment at the top of the movement, focusing on contracting your shoulder muscles.\n
4. Slowly lower the dumbbells back down to your sides, again keeping your elbows slightly bent.\n
5. Repeat for the desired number of repetitions or sets.''',
              Color.fromARGB(255, 248, 247, 247),
            ),
            SizedBox(height: 16.0),
            _buildMeditationExerciseCard(
              context,
              'SMITH MACHINE SHOULDER PRESS',
              'assets/exercise/Smith-Machine-Shoulder-Press.gif',
              '''1. Stand facing the Smith machine with your feet shoulder-width apart and the barbell resting on your shoulders.\n
2. Grip the barbell slightly wider than shoulder width, with your palms facing forward.\n
3. Push the barbell up and overhead, extending your arms fully but not locking your elbows\n.
4. Slowly lower the barbell back down to your shoulders, keeping your elbows slightly bent.\n
5. Repeat for the desired number of repetitions or sets.''',
              Color.fromARGB(255, 248, 237, 237),
            ),
            SizedBox(height: 16.0),
            _buildMeditationExerciseCard(
              context,
              'DUMBBELL SHOULDER PRESS',
              'assets/exercise/Dumbbell-Shoulder-Press.gif',
              '''1. Stand or sit with your feet flat on the ground and hold a dumbbell in each hand at shoulder height, with your palms facing forward and your elbows bent.\n
2. Push the dumbbells up and overhead, fully extending your arms but not locking your elbows.\n
3. Hold for a brief moment at the top of the movement, focusing on contracting your shoulder muscles.\n
4. Slowly lower the dumbbells back down to shoulder height, again keeping your elbows slightly bent.\n
5. Repeat for the desired number of repetitions or sets.''',
              Color.fromARGB(255, 248, 247, 247),
            ),
            SizedBox(height: 16.0),
            _buildMeditationExerciseCard(
              context,
              'BENT OVER LATERAL RAISE',
              'assets/exercise/Bent-Over-Lateral-Raise.gif',
              '''1. Stand with your feet shoulder-width apart and hold a dumbbell in each hand.\n
2. Bend forward at the hips, keeping your back straight and your knees slightly bent, until your torso is nearly parallel to the ground.\n
3. Allow the dumbbells to hang down directly below your shoulders, with your palms facing each other.\n
4. Raise both dumbbells out to your sides until they reach shoulder height, keeping your elbows slightly bent throughout the movement.\n
5. Slowly lower the dumbbells back down to starting position, again keeping your elbows slightly bent.''',
              Color.fromARGB(255, 248, 237, 237),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeditationExerciseCard(
    BuildContext context,
    String title,
    String imagePath,
    String description,
    Color color,
  ) {
    return Card(
      color: color,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 8.0),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
