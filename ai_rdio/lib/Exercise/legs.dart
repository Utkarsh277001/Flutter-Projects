import 'package:flutter/material.dart';

class LegsExercisePage extends StatelessWidget {
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
              'DUMBBELL GOBLET SQUAT',
              'assets/exercise/dumbbellgobletsquat.gif',
              '''1. Stand with your feet shoulder-width apart and hold a dumbbell vertically against your chest, with both hands cupping the top end of the weight.\n

2. Lower your body by pushing your hips back and bending your knees. Keep your back straight and your chest up as you descend into the squat position.\n

3. Continue to lower your body until your thighs are parallel to the ground or slightly below. Make sure your knees do not extend past your toes.\n

4. Push through your heels to stand back up, squeezing your glutes and thighs at the top of the movement.\n

5. Repeat for the desired number of repetitions.''',
              Color.fromARGB(255, 248, 247, 247),
            ),
            SizedBox(height: 16.0),
            _buildMeditationExerciseCard(
              context,
              'ROMANIAN DEADLIFT',
              'assets/exercise/barbellromaniandeadlift.gif',
              '''1. Stand with your feet hip-width apart and hold a barbell or dumbbells in front of your thighs with an overhand grip.\n

2. Brace your core and keep your back straight as you hinge forward at the hips, pushing your buttocks back behind you.\n

3. Lower the weight towards the ground while keeping it close to your body, allowing your knees to bend slightly but keeping them mostly stationary.\n

4. Continue lowering until you feel a stretch in your hamstrings, but stop before your back begins to round.\n

5. Reverse the movement by squeezing your glutes and driving your hips forward as you lift the weight back up to the starting position. Repeat for the desired number of repetitions.''',
              Color.fromARGB(255, 248, 247, 247),
            ),
            SizedBox(height: 16.0),
            _buildMeditationExerciseCard(
              context,
              'SPLIT SQUAT JUMP',
              'assets/exercise/jumpsquat.gif',
              '''1. Begin by standing with your feet hip-width apart and take a step forward with one foot, while keeping the other foot in place behind you.\n

2. Lower your body until both knees are bent at a 90-degree angle, making sure that your front knee is directly above your ankle and not past your toes.\n

3. Push through your front foot to jump explosively into the air, switching the position of your feet mid-air so that you land softly with the opposite foot forward.\n

4. As soon as you land, lower your body back into the lunge position and immediately jump again, switching your feet once more.\n

5. Repeat this movement for the desired number of reps or time period, making sure to keep your core engaged, chest lifted and landing softly each time to protect your joints.''',
              Color.fromARGB(255, 248, 247, 247),
            ),
            SizedBox(height: 16.0),
            _buildMeditationExerciseCard(
              context,
              'CABLE PULL THROUGH',
              'assets/exercise/cablepullthrough.gif',
              '''1. Set the cable machine to its lowest setting and attach a rope handle to the cable.\n

2. Stand facing away from the cable machine with your feet shoulder-width apart and grab the rope handle with both hands, palms facing down.\n

3. Walk forward so that there is tension on the cable and your arms are straight in front of your hips.\n

4. Keeping your back straight and your core engaged, hinge at the hips and lower your torso until it is parallel to the ground.\n

5. Reverse the movement by squeezing your glutes and driving your hips forward to return to the starting position. Repeat for the desired number of repetitions.''',
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
