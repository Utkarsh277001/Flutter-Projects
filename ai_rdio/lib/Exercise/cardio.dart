// import 'package:flutter/material.dart';

// class CardioExercisePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Center(child: Text('Cardio Exercises')),
//       // ),
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
//               'Cycling',
//               'assets/images/cycle.jpg',
//               '''1. Start with a warm-up of 5-10 minutes.\n
// 2. Increase intensity by pedaling faster or adding resistance.\n
// 3. Maintain proper form with relaxed shoulders, straight back, and core stability.\n
// 4. Cool-down with slower cycling for another 5-10 minutes.\n
// 5. Stretch to reduce muscle soreness and improve flexibility.''',
//               Color.fromARGB(255, 248, 247, 247),
//             ),
//             SizedBox(height: 16.0),
//             _buildMeditationExerciseCard(
//               context,
//               'Jumping Rope',
//               'assets/images/jump-rope.jpg',
//               '''1. Choose the right rope.\n
// 2. Warm up for a few minutes.\n
// 3. Begin jumping with proper form.\n
// 4. Maintain good form by landing on the balls of your feet and keeping core engaged.\n
// 5. Increase intensity with advanced variations like double unders or crossover jumps.\n''',
//               Color.fromARGB(255, 248, 247, 247),
//             ),
//             SizedBox(height: 16.0),
//             _buildMeditationExerciseCard(
//               context,
//               'Running',
//               'assets/images/run.jpg',
//               '''1. Warm up for 5-10 minutes.\n
// 2. Start slowly and avoid overexertion.\n
// 3. Maintain proper form by keeping shoulders down, back straight, and landing on midfoot.\n
// 4. Increase intensity gradually by adding speed or hills.\n
// 5. Cool down with slower jogging or walking and stretch to reduce soreness and improve flexibility.''',
//               Color.fromARGB(255, 248, 247, 247),
//             ),
//             SizedBox(height: 16.0),
//             _buildMeditationExerciseCard(
//               context,
//               'Stair climbing',
//               'assets/images/stair-climb.jpg',
//               '''1. Warm up for 5-10 minutes.\n
// 2. Find a flight of stairs.\n
// 3. Begin climbing with proper form.\n
// 4. Maintain good form and engage leg muscles.\n
// 5. Increase intensity by increasing speed or adding weights. Cool down and stretch after your workout.''',
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

class CardioExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Center(child: Text('Cardio Exercises')),
      // ),
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
              'Cycling',
              'assets/exercise/cycling.gif',
              '''1. Start with a warm-up of 5-10 minutes.\n
2. Increase intensity by pedaling faster or adding resistance.\n
3. Maintain proper form with relaxed shoulders, straight back, and core stability.\n
4. Cool-down with slower cycling for another 5-10 minutes.\n
5. Stretch to reduce muscle soreness and improve flexibility.''',
              Color.fromARGB(255, 248, 247, 247),
            ),
            SizedBox(height: 16.0),
            _buildMeditationExerciseCard(
              context,
              'Jumping Rope',
              'assets/exercise/jumping-rope.gif',
              '''1. Choose the right rope.\n
2. Warm up for a few minutes.\n
3. Begin jumping with proper form.\n
4. Maintain good form by landing on the balls of your feet and keeping core engaged.\n
5. Increase intensity with advanced variations like double unders or crossover jumps.\n''',
              Color.fromARGB(255, 248, 247, 247),
            ),
            SizedBox(height: 16.0),
            _buildMeditationExerciseCard(
              context,
              'Running',
              'assets/exercise/Run.gif',
              '''1. Warm up for 5-10 minutes.\n
2. Start slowly and avoid overexertion.\n
3. Maintain proper form by keeping shoulders down, back straight, and landing on midfoot.\n
4. Increase intensity gradually by adding speed or hills.\n
5. Cool down with slower jogging or walking and stretch to reduce soreness and improve flexibility.''',
              Color.fromARGB(255, 248, 247, 247),
            ),
            SizedBox(height: 16.0),
            _buildMeditationExerciseCard(
              context,
              'TreadMill',
              'assets/exercise/Treadmill.gif',
              '''1. Begin by walking at a comfortable pace for 3-5 minutes to get your muscles warmed up and ready for more intense activity.\n

2. Gradually increase your speed to a moderate intensity that challenges you but still allows you to maintain proper form and breathing. This can take anywhere from 30 seconds to several minutes depending on your fitness level.\n

3. If your treadmill has an incline feature, adjust it to simulate walking or running uphill. This will help you burn more calories and improve your cardiovascular endurance.\n

4. After completing your workout, gradually reduce your speed and incline over 3-5 minutes to allow your body to cool down and prevent injury.\n

5. Finally, stretch your muscles to improve flexibility and prevent soreness. Focus on the muscles you used during your workout, holding each stretch for 10-30 seconds. in simple points''',
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
