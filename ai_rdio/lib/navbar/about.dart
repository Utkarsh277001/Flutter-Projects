import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

//import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white,
                // Color.fromRGBO(19, 19, 31, 1),
                // Color.fromRGBO(19, 15, 11, 1),
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            //physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
              child: Column(
                children: [
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        AntDesign.arrowleft,
                        color: Colors.white,
                      ),
                      Icon(
                        AntDesign.logout,
                        color: Colors.white,
                      ),
                    ],
                  ),*/
                  /*SizedBox(
                  height: 20,
                  ),
                  Text(
                    'hello',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontFamily: 'Nisebuschgardens',
                    ),
                  ),*/
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: height * 0.43,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: innerHeight * 0.7,
                                width: innerWidth,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 247, 246, 246),
                                  borderRadius: BorderRadius.circular(21),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'About FitSync',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Nunito',
                                          fontSize: 37,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Divider(
                                      thickness: 2.5,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(11.0),
                                      child: Text(
                                        '''The "FitSync" app is a mobile fitness application designed to help users achieve their fitness goals by providing personalized workout plans, tracking progress and provide single Membership to access different gyms.''',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Nunito',
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    /*Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'The "GymMate" ',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 8, 8, 8),
                                                fontFamily: 'Nunito',
                                                fontSize: 5,
                                              ),
                                            ),
                                            Text(
                                              'The "GymMate" ',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 25,
                                            vertical: 8,
                                          ),
                                          child: Container(
                                            height: 50,
                                            width: 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Pending',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              '1',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )*/
                                  ],
                                ),
                              ),
                            ),
                            /*Positioned(
                              top: 110,
                              right: 20,
                              child: Icon(
                                AntDesign.setting,
                                color: Colors.grey[700],
                                size: 30,
                              ),
                            ),*/
                            /*Positioned(
                              top: -20,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  child: Image.asset(
                                    'assets/images/lock.jpg',
                                    width: innerWidth * .45,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),*/
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: height * 0.5,
                    width: width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 247, 246, 246),
                      borderRadius: BorderRadius.circular(21),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Features',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 37,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            thickness: 2.5,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '''* FitSync has a significant potential to revolutionize the fitness industry by providing users with a convenient way to access multiple fitness centers with a single subscription.\n\n * It has the scope to expand its services globally, attracting fitness enthusiasts who prefer flexibility in their workout routine\n\n * The app can also benefit gym owners by providing them with a platform to reach out to a wider audience and increase their revenue\n''',
                              style: TextStyle(
                                  decorationColor: Colors.black,
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )

                          /*Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                'Hello mdfbjbd j jhgrnbjrbjk h jrhjebkjk',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                     height: height * 0.7,
//                     width: width,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Colors.white,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Text(
//                             'Membership Plans',
//                             style: TextStyle(
//                               color: Color.fromRGBO(39, 105, 171, 1),
//                               fontSize: 37,
//                               fontFamily: 'Nunito',
//                             ),
//                           ),
//                           Divider(
//                             thickness: 2.5,
//                           ),
//                           SizedBox(
//                             height: 8,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               '''1. BASIC PLAN:\n
// * access to gym equipment  and facilities
// * no additional perks or benefits\n\n
// 2.PREMIUM:\n
// * Personalized training plans or workout recommendation
// * Access to premium services like steam bath,hot tubs ,ice bath\n\n
// 3.Elite:\n
// * Access to all exclusive services like private locker rooms or lounge areas.
// * Special events such as fitness challenges  or workshops
// * Unlimited access yo personal training''',
//                               style: TextStyle(
//                                   decorationColor: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 15),
//                             ),
//                           )
                  /*Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                'Hello mdfbjbd j jhgrnbjrbjk h jrhjebkjk',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),*/
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: height * 1,
                    width: width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 247, 246, 246),
                      borderRadius: BorderRadius.circular(21),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Membership Plans',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 37,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            thickness: 2.5,
                          ),
                          SizedBox(
                            height: 20,
                          ),
//
                          Container(
                            height: height * 0.2,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 250, 241, 238),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    ''' BASIC PLAN''',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '''
\n* Access to gym equipment  and facilities.\n
* No additional perks or benefits.\n\n''',
                                    style: TextStyle(
                                      fontSize: 15,
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
//
                          Container(
                            height: height * 0.25,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 237, 235, 235),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    ''' PREMIUM''',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Text(
                                        '''
                                                                      \n* Personalized training plans or workout recommendation.\n\n* Access to premium services like steam bath,hot tubs ,ice bath\n''',
                                        style: TextStyle(
                                          fontSize: 15,
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Container(
                            height: height * 0.3,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 247, 241, 176),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    ''' ELITE''',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '''
                                  \n* Access to all exclusive services like private locker rooms or lounge areas.\n\n* Special events such as fitness challenges  or workshops.\n\n* Unlimited access yo personal training''',
                                      style: TextStyle(
                                        fontSize: 15,
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //                   SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                     height: height * 0.7,
//                     width: width,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Colors.white,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Text(
//                             'Membership Plans',
//                             style: TextStyle(
//                               color: Color.fromRGBO(39, 105, 171, 1),
//                               fontSize: 37,
//                               fontFamily: 'Nunito',
//                             ),
//                           ),
//                           Divider(
//                             thickness: 2.5,
//                           ),
//                           SizedBox(
//                             height: 8,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               '''1. BASIC PLAN:\n
// * access to gym equipment  and facilities
// * no additional perks or benefits\n\n
// 2.PREMIUM:\n
// * Personalized training plans or workout recommendation
// * Access to premium services like steam bath,hot tubs ,ice bath\n\n
// 3.Elite:\n
// * Access to all exclusive services like private locker rooms or lounge areas.
// * Special events such as fitness challenges  or workshops
// * Unlimited access yo personal training''',
//                               style: TextStyle(
//                                   decorationColor: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 15),
//                             ),
//                           )
                          // Container(
                          //   height: height * 0.2,
                          //   decoration: BoxDecoration(
                          //     color: Color.fromRGBO(231, 234, 231, 0.894),
                          //     borderRadius: BorderRadius.circular(30),
                          //   ),
                          //   child: Center(
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Text(
                          //         '''2.PREMIUM:\n\n* Personalized training plans or workout recommendation.\n*Access to premium services like steam bath,hot tubs ,ice bath\n''',
                          //         style: TextStyle(
                          //           fontSize: 15,
                          //           fontWeight: FontWeight.bold,
                          //           color: Colors.black,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // Container(
                          //   height: height * 0.25,
                          //   decoration: BoxDecoration(
                          //     color: Color.fromARGB(255, 244, 244, 240),
                          //     borderRadius: BorderRadius.circular(30),
                          //   ),
                          //   child: Center(
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Text(
                          //         '''3.Elite:\n\n* Access to all exclusive services like private locker rooms or lounge areas.\n* Special events such as fitness challenges  or workshops.\n* Unlimited access yo personal training''',
                          //         style: TextStyle(
                          //           fontSize: 15,
                          //           fontWeight: FontWeight.bold,
                          //           color: Colors.black,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //                   SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                     height: height * 0.7,
//                     width: width,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Colors.white,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Text(
//                             'Membership Plans',
//                             style: TextStyle(
//                               color: Color.fromRGBO(39, 105, 171, 1),
//                               fontSize: 37,
//                               fontFamily: 'Nunito',
//                             ),
//                           ),
//                           Divider(
//                             thickness: 2.5,
//                           ),
//                           SizedBox(
//                             height: 8,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               '''1. BASIC PLAN:\n
// * access to gym equipment  and facilities
// * no additional perks or benefits\n\n
// 2.PREMIUM:\n
// * Personalized training plans or workout recommendation
// * Access to premium services like steam bath,hot tubs ,ice bath\n\n
// 3.Elite:\n
// * Access to all exclusive services like private locker rooms or lounge areas.
// * Special events such as fitness challenges  or workshops
// * Unlimited access yo personal training''',
//                               style: TextStyle(
//                                   decorationColor: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 15),
//                             ),
//                           )
                  Container(
                    height: height * .25,
                    width: width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 247, 246, 246),
                      borderRadius: BorderRadius.circular(21),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Support',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 37,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            thickness: 2.5,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Text(
                              '''* www.FitSync.com\n\n*9000065798\n\n*FitSync@gmail.com''',
                              style: TextStyle(
                                  decorationColor: Colors.black,
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                          /*Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
