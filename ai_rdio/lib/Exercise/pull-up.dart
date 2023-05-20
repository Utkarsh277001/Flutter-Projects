// import 'package:flutter/material.dart';

// class PullExercisePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: Text(
//           '',
//           style: TextStyle(color: Colors.black),
//         ),
//         iconTheme: IconThemeData(color: Colors.black),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             _buildMeditationExerciseCard(
//               context,
//               'Standard Pull-Up',
//               'assets/images/flat-bench-press.png',
//               '''1. Adjust the height of the bench to suit your body frame and ensure it is properly anchored on the ground.\n
// 2. Lie down on the bench with your feet firmly planted on the ground.\n
// 3. Grasp the barbell slightly wider than shoulder-width apart, ensuring that your palms are facing away from your body.\n
// 4. Lift the bar out of the rack using your chest muscles, keeping your elbows tucked in and your shoulders back.\n
// 5. Slowly lower the bar towards your chest, keeping your elbows at a 45-degree angle to your body. Stop when the bar is just above your chest.\n
// 6. Push the barbell back up to the starting position by extending your arms and contracting your chest muscles.\n
// 7. Lock out your elbows at the top of the movement, then slowly lower the bar back down to your chest.
// 8. Repeat for desired reps.''',
//               Color.fromARGB(255, 248, 247, 247),
//             ),
//             SizedBox(height: 16.0),
//             _buildMeditationExerciseCard(
//               context,
//               'Machine Chest Expansion',
//               'assets/images/machine-chest.png',
//               '''1. Adjust the seat height and backrest to suit your body frame, ensuring that you are seated comfortably with your back against the pad.\n
// 2. Grasp the handles of the machine with both hands, keeping your elbows bent at a 90-degree angle and your upper arms parallel to the ground.\n
// 3. Slowly push the handles away from your body, contracting your chest muscles as you do so. Keep your core engaged and maintain good posture throughout the movement.\n
// 4. Slowly release the handles and allow them to return to the starting position, without letting the weight stack touch down.\n
// 5. Perform the exercise for the desired number of reps, ensuring that you are using a weight that challenges your muscles but does not compromise your form. Take breaks between sets as needed.''',
//               Color.fromARGB(255, 248, 247, 247),
//             ),
//             SizedBox(height: 16.0),
//             _buildMeditationExerciseCard(
//               context,
//               'Push-Up',
//               'assets/images/push-up.png',
//               '''1. Start in a plank position with your hands placed slightly wider than shoulder-width apart on the ground, and your feet together.\n
// 2. Tighten your abdominal muscles to form a straight line from head to heels, ensuring that your back is flat and your hips are level with your shoulders.\n
// 3. Bend your elbows and slowly lower your body towards the ground, keeping your elbows close to your body. Stop when your chest is just above the ground.\n
// 4. Push into the ground with your hands and extend your arms to raise your body back up to the starting position.\n
// 5. Perform the exercise for the desired number of reps, focusing on maintaining good form throughout the movement. Take breaks between sets as needed.''',
//               Color.fromARGB(255, 248, 247, 247),
//             ),
//             SizedBox(height: 16.0),
//             _buildMeditationExerciseCard(
//               context,
//               'Incline Bench Press',
//               'assets/images/incline-bench.png',
//               '''1. Adjust the bench to a 30-45 degree angle and ensure it is securely anchored on the ground. Lie down on the bench with your feet firmly planted on the ground.\n
// 2. Grasp the barbell slightly wider than shoulder-width apart, ensuring that your palms are facing away from your body.\n
// 3. Lift the bar out of the rack using your chest muscles, keeping your elbows tucked in and your shoulders back.\n
// 4. Slowly lower the bar towards your upper chest, keeping your elbows at a 45-degree angle to your body. Stop when the bar is just above your chest.\n
// 5. Push the barbell back up to the starting position by extending your arms and contracting your chest muscles. Lock out your elbows at the top of the movement, then slowly lower the bar back down to your chest and repeat for desired reps.''',
//               Color.fromARGB(255, 248, 247, 247),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMeditationExerciseCard(
//     BuildContext context,
//     String title,
//     String imagePath,
//     String description,
//     Color color,
//   ) {
//     return Card(
//       color: color,
//       elevation: 6,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(10),
//               topRight: Radius.circular(10),
//             ),
//             child: Image.asset(
//               imagePath,
//               fit: BoxFit.cover,
//             ),
//           ),
//           SizedBox(height: 10),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                 ),
//                 SizedBox(height: 8.0),
//                 Text(
//                   description,
//                   style: Theme.of(context).textTheme.bodyText2,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class PullExercisePage extends StatelessWidget {
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
              'BENCH PRESS',
              'assets/exercise/benchpress.gif',
              '''1.Lie on a flat bench with your feet firmly planted on the floor and your eyes positioned underneath the bar.\n
2. Grab onto the bar with an overhand grip that is slightly wider than shoulder-width apart, making sure to keep your wrists straight.\n
3. Lift the bar off the rack and lower it slowly towards your chest, keeping your elbows close to your body and inhaling deeply as you do so.\n
4. Once the bar touches your chest, push it back up towards the starting position while exhaling forcefully, using your chest, shoulders, and triceps to drive the movement.\n
5. Repeat the movement for the desired number of repetitions, then carefully re-rack the bar.''',
              Color.fromARGB(255, 248, 247, 247),
            ),
            SizedBox(height: 16.0),
            _buildMeditationExerciseCard(
              context,
              'DUMBBELL PULLOVER',
              'assets/exercise/dumbbellpullover.gif',
              '''1. Begin by lying on a flat bench with your feet firmly planted on the floor and your head at the end of the bench.\n
2. Hold a dumbbell with both hands and extend it straight up over your chest.\n
3. Slowly lower the weight down and behind your head, keeping your arms extended and your elbows slightly bent.\n
4. Once you feel a stretch in your chest and lats, lift the weight back up towards the starting position, focusing on using your chest muscles to drive the movement.\n
5. Repeat the movement for the desired number of repetitions.''',
              Color.fromARGB(255, 248, 247, 247),
            ),
            SizedBox(height: 16.0),
            _buildMeditationExerciseCard(
              context,
              'HIGH CABLE CROSSOVER',
              'assets/exercise/highcablecrossover.gif',
              '''1. Begin by standing in the center of a cable machine with the pulleys set to their highest position.\n
2. Grab onto the handles with an overhand grip that is slightly wider than shoulder-width apart, making sure to keep your wrists straight.\n
3. Take a step forward with one foot and lean forward slightly, keeping your core engaged and your back straight.\n
4. Pull the cables down and across your body towards your opposite hip, focusing on using your chest muscles to drive the movement.\n
5. Slowly release the tension and return the handles back to the starting position, then repeat the movement on the other side.''',
              Color.fromARGB(255, 248, 247, 247),
            ),
            SizedBox(height: 16.0),
            _buildMeditationExerciseCard(
              context,
              'INCLINE BARBELL BENCH PRESS',
              'assets/exercise/Inclinebarbellbenchpress.gif',
              '''1. Adjust the bench to a 30-45 degree angle and ensure it is securely anchored on the ground. Lie down on the bench with your feet firmly planted on the ground.\n
2. Grasp the barbell slightly wider than shoulder-width apart, ensuring that your palms are facing away from your body.\n
3. Lift the bar out of the rack using your chest muscles, keeping your elbows tucked in and your shoulders back.\n
4. Slowly lower the bar towards your upper chest, keeping your elbows at a 45-degree angle to your body. Stop when the bar is just above your chest.\n
5. Push the barbell back up to the starting position by extending your arms and contracting your chest muscles. Lock out your elbows at the top of the movement, then slowly lower the bar back down to your chest and repeat for desired reps.''',
              Color.fromARGB(255, 248, 247, 247),
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
