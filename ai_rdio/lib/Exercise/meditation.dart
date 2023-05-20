// import 'package:flutter/material.dart';

// class MeditationExercisePage extends StatelessWidget {
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
//               'Flat Dumbell Row',
//               'assets/images/flat-dumbell-back.png',
//               '''1. Start by standing with your feet shoulder-width apart and holding a dumbbell in each hand.\n
// 2. Bend your knees slightly and hinge forward at the hips until your torso is parallel to the floor. Keep your back straight and core engaged.\n
// 3. With your arms fully extended towards the ground, let the dumbbells hang straight down from your shoulders.\n
// 4. Pull the dumbbells up towards your chest, leading with your elbows. Keep your elbows close to your body as you lift the weights.\n
// 5. Pause briefly at the top of the movement, squeezing your shoulder blades together, then slowly lower the weights back to the starting position.''',
//               Color.fromARGB(255, 248, 247, 247),
//             ),
//             SizedBox(height: 16.0),
//             _buildMeditationExerciseCard(
//               context,
//               'Reverse Lat Pull Down',
//               'assets/images/reverse-lat.png',
//               '''1. Start by adjusting the cable machine with a wide-grip bar attachment at the top.\n
// 2. Stand facing the machine and grasp the bar with your palms facing away from your body (overhand grip). Your hands should be slightly wider than shoulder-width apart.\n
// 3. Step back a few feet from the machine and kneel down on one knee. Keep your back straight and core engaged.\n
// 4. Pull the bar down towards your chest, keeping it close to your body and leading with your elbows. Squeeze your shoulder blades together as you pull down.\n
// 5. Pause briefly at the bottom of the movement, then slowly release the bar back up to the starting position.''',
//               Color.fromARGB(255, 248, 237, 237),
//             ),
//             SizedBox(height: 16.0),
//             _buildMeditationExerciseCard(
//               context,
//               'Lat Pull Down',
//               'assets/images/lat-pull.png',
//               '''1. Start by adjusting the weight on the machine to a comfortable level and selecting the appropriate handle attachment for your grip preference.\n
// 2. Sit down on the bench or seat provided and secure your legs under the pads, ensuring that your back remains straight.\n
// 3. Reach up and grab the handle with an overhand grip that is slightly wider than shoulder-width apart.\n
// 4. Slowly pull the handle down towards your chest while keeping your elbows close to your sides and squeezing your shoulder blades together.\n
// 5. Pause briefly at the bottom of the movement before slowly releasing the handle back up to the starting position, taking care not to let the weight stack slam back into place.''',
//               Color.fromARGB(255, 248, 247, 247),
//             ),
//             SizedBox(height: 16.0),
//             _buildMeditationExerciseCard(
//               context,
//               'Bent Over Row',
//               'assets/images/bentover_row.png',
//               '''1. Begin by standing with your feet shoulder-width apart and holding a barbell or dumbbells in front of your thighs.\n
// 2. Hinge forward at the hips, keeping your back straight and your core engaged, until your upper body is nearly parallel to the ground.\n
// 3. Keeping your elbows close to your body, pull the weight up towards your chest by squeezing your shoulder blades together and engaging your back muscles.\n
// 4. Pause briefly at the top of the movement, then slowly lower the weight back down to the starting position.\n
// 5. Repeat for several repetitions, taking care not to let your form break down as you fatigue.''',
//               Color.fromARGB(255, 248, 237, 237),
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

class MeditationExercisePage extends StatelessWidget {
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
              'Pull-Up',
              'assets/exercise/pull.gif',
              '''1. Grab onto the bar with an overhand grip that is slightly wider than shoulder-width apart.\n
2. Engage your core and pull your shoulder blades down and back.\n
3. Pull your body up towards the bar, keeping your elbows close to your body.\n
4. Pause briefly at the top of the movement, with your chin above the bar.\n
5. Lower yourself back down slowly and with control until your arms are fully extended.''',
              Color.fromARGB(255, 248, 247, 247),
            ),
            SizedBox(height: 16.0),
            _buildMeditationExerciseCard(
              context,
              'Muscle-Up',
              'assets/exercise/muscleup.gif',
              '''1. Begin by hanging from a bar with an overhand grip that is slightly wider than shoulder-width apart.\n
2. Pull your body up towards the bar until your chest reaches the bar.\n
3. At the top of the pull-up, start to shift your weight forward and explosively push down on the bar while pulling your elbows towards your hips.\n
4. As you reach the peak of your upward trajectory, begin to transition your hands from above the bar to in front of it.\n
5. Push yourself up and over the bar, extending your arms fully at the top.''',
              Color.fromARGB(255, 248, 237, 237),
            ),
            SizedBox(height: 16.0),
            _buildMeditationExerciseCard(
              context,
              'Weighted-Pull-Up',
              'assets/exercise/weightedpullup.gif',
              '''1. Begin by attaching your desired amount of weight to a dip belt or weight vest.\n
2. Grab onto the bar with an overhand grip that is slightly wider than shoulder-width apart.\n
3. Engage your core and pull your shoulder blades down and back.\n
4. Pull your body up towards the bar, keeping your elbows close to your body and maintaining control over the added weight.\n
5. Lower yourself back down slowly and with control until your arms are fully extended.''',
              Color.fromARGB(255, 248, 247, 247),
            ),
            SizedBox(height: 16.0),
            _buildMeditationExerciseCard(
              context,
              'Inverted-Row',
              'assets/exercise/invertedrow.gif',
              '''1. Begin by setting up a bar or other sturdy object at waist height.\n
2. Lie on your back underneath the bar and grab onto it with an overhand grip that is slightly wider than shoulder-width apart.\n
3. Engage your core and lift your hips up towards the ceiling until your body forms a straight line from your head to your heels.\n
4. Pull your chest up towards the bar by squeezing your shoulder blades together and keeping your elbows close to your body.\n
5. Lower yourself back down slowly and with control until your arms are fully extended.''',
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
