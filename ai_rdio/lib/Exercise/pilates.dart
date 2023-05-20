// import 'package:flutter/material.dart';

// class BicepsExercisePage extends StatelessWidget {
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
//               'Biceps Curl',
//               'assets/exercise/Barbell-Curl.gif',
//               '''1.Stand up straight with your feet shoulder-width apart and hold the dumbbells in each hand at arm's length by your sides, palms facing forward.\n
// 2. Keeping your elbows locked into your sides, slowly lift the weights towards your shoulders while you exhale. Only your forearms should move during this exercise.\n
// 3. Pause for a second when the dumbbells reach your shoulders.\n
// 4. Slowly lower the weights back down to your starting position while inhaling.\n
// 5. Repeat the exercise for the desired number of repetitions, typically 8-12 reps per set.

// ''',
//               Color.fromARGB(255, 248, 247, 247),
//             ),
//             SizedBox(height: 16.0),
//             _buildMeditationExerciseCard(
//               context,
//               'Sitting Biceps Curl',
//               'assets/images/sitting-biceps-curl.jpg',
//               '''1. Sit down on a bench or chair with your feet flat on the floor and your back straight.\n
// 2. Hold a pair of dumbbells with an underhand grip (palms facing up) and let your arms hang down at your sides.\n
// 3. Slowly curl the weights up towards your shoulders, keeping your elbows close to your body and your wrists straight.\n
// 4. Pause briefly at the top of the movement, then slowly lower the weights back down to the starting position.\n
// 5. Repeat for the desired number of repetitions, keeping control of the weights throughout the entire movement.''',
//               Color.fromARGB(255, 248, 247, 247),
//             ),
//             SizedBox(height: 16.0),
//             _buildMeditationExerciseCard(
//               context,
//               'Triceps',
//               'assets/images/triceps.png',
//               '''1. Stand facing cable machine with rope attachment\n
// 2. Hold the rope with palms facing down\n
// 3. Bring the rope down towards your thighs using only your arms\n
// 4. Return the rope to starting position by extending your arms\n''',
//               Color.fromARGB(255, 248, 247, 247),
//             ),
//             SizedBox(height: 16.0),
//             _buildMeditationExerciseCard(
//               context,
//               'Overhead Shoulder Press',
//               'assets/images/overhead.png',
//               '''1. Begin by standing with your feet hip-width apart, holding a barbell or dumbbells at shoulder level with palms facing forward.\n
// 2. Engage your core and lift the weight overhead by extending your arms straight up towards the ceiling. Keep your elbows close to your ears as you lift.\n
// 3. Pause briefly at the top of the movement, then slowly lower the weight back down to shoulder level.\n
// 4. Repeat the motion for your desired number of repetitions, maintaining proper form throughout.\n
// 5. Remember to breathe deeply and evenly as you perform the exercise, and avoid using momentum or swinging your arms to lift the weight.''',
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
//             //           child: GifImage.asset(
//             //   imagePath,
//             //   fit: BoxFit.cover,
//             // ),
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

class BicepsExercisePage extends StatelessWidget {
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
              'DUMBBELL WRIST CURLS',
              'assets/exercise/wristcurl.gif',
              '''1. Begin by sitting on a bench or chair and holding a dumbbell in one hand with an underhand grip.\n
2. Rest your forearm on a bench, table, or other flat surface, with your wrist hanging over the edge.\n
3. Slowly raise the weight towards your forearm by flexing your wrist, keeping your elbow still and close to your body.\n
4. Pause briefly at the top of the movement, then lower the weight back down slowly and with control until your wrist is fully extended.\n
5. Repeat the movement for the desired number of repetitions, then switch arms and repeat.

''',
              Color.fromARGB(255, 248, 247, 247),
            ),
            SizedBox(height: 16.0),
            _buildMeditationExerciseCard(
              context,
              'WRIST ROLLS',
              'assets/exercise/wristroll.gif',
              '''1. Begin by holding a lightweight barbell or dowel rod with an overhand grip, hands shoulder-width apart.\n
2. Extend your arms straight out in front of you with the bar held horizontally.\n
3. Roll the bar downwards towards your fingers, using only your wrists to control the movement.\n
4. Once the bar has reached your fingertips, slowly roll it back up towards your palms.\n
5. Repeat the rolling motion for the desired number of repetitions.''',
              Color.fromARGB(255, 248, 247, 247),
            ),
            SizedBox(height: 16.0),
            _buildMeditationExerciseCard(
              context,
              'LEVER BICEPS CURL',
              'assets/exercise/leverbicepscurl.gif',
              '''1. Begin by standing with your feet shoulder-width apart and holding a barbell or other weighted object in front of you with an underhand grip.\n
2. Extend your arms fully downwards, keeping them close to your body.\n
3. Slowly lift the weight up towards your shoulders by flexing your elbows and keeping your upper arms stationary.\n
4. Pause briefly at the top of the movement, then lower the weight back down slowly and with control until your arms are fully extended.\n
5. Repeat the movement for the desired number of repetitions.''',
              Color.fromARGB(255, 248, 247, 247),
            ),
            SizedBox(height: 16.0),
            _buildMeditationExerciseCard(
              context,
              'DOUBLE ARM DUMBBELL CURL',
              'assets/exercise/doublearmdumbbellcurl.gif',
              '''1. Begin by standing with your feet shoulder-width apart and holding a dumbbell in each hand with an underhand grip.\n
2. Extend your arms fully downwards, keeping them close to your body.\n
3. Slowly lift both weights up towards your shoulders by flexing your elbows, keeping your upper arms stationary.\n
4. Pause briefly at the top of the movement, then lower the weights back down slowly and with control until your arms are fully extended.\n
5. Repeat the movement for the desired number of repetitions.''',
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
