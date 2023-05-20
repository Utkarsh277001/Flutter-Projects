// // import 'package:flutter/material.dart';

// // class BarItemPage extends StatelessWidget {
// //   const BarItemPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     double height = MediaQuery.of(context).size.width;
// //     double width = MediaQuery.of(context).size.height;
// //     // return Scaffold(
// //     //   body: Center(
// //     //     child: Row(
// //     //       children: [
// //     //         Container(
// //     //           height: height*0.7,
// //     //           width: width*0.8,
// //     //           decoration: BoxDecoration(

// //     //             borderRadius: BorderRadius.circular(30),
// //     //             gradient: LinearGradient(
// //     //               colors: [
// //     //                 Colors.amber[900],
// //     //                 Colors.amber[700],
// //     //               ],

// //     //             ),
// //     //           ),
// //     //           child: ClipRRect(
// //     //         borderRadius: BorderRadius.circular(30),
// //     //         child: CustomPaint(
// //     //           size: Size(width, height),
// //     //           painter: CardCustomPainter(),
// //     //           child: Stack(
// //     //             children: [
// //     //               Positioned(
// //     //                 bottom: 10,
// //     //                 left: 10,
// //     //                 child: Image.asset(
// //     //                   'assets/img.png',
// //     //                   color: Colors.purpleAccent.withOpacity(0.3),
// //     //                   width: width * 0.7,
// //     //                 ),
// //     //               ),
// //     //               Positioned(
// //     //                 bottom: 30,
// //     //                 left: 20,
// //     //                 child: Image.asset(
// //     //                   'assets/2.png',
// //     //                   width: width * 0.7,
// //     //                   color: Colors.white70,
// //     //                 ),
// //     //               ),
// //     //               Column(
// //     //                 children: [
// //     //                   SizedBox(
// //     //                     height: 30,
// //     //                   ),
// //     //                   Center(
// //     //                     child: Image.asset(
// //     //                       'assets/eye.png',
// //     //                       color: Colors.deepPurple[700],
// //     //                       width: width * 0.4,
// //     //                     ),
// //     //                   ),
// //     //                   Text(
// //     //                     'Cylon Coder',
// //     //                     style: TextStyle(
// //     //                       color: Colors.deepPurple[700],
// //     //                       fontSize: 25,
// //     //                       fontWeight: FontWeight.bold,
// //     //                     ),
// //     //                   ),
// //     //                   SizedBox(
// //     //                     height: 110,
// //     //                   ),
// //     //                   detailWidget(
// //     //                     icon: Icons.phone,
// //     //                     text: '+94765555777',
// //     //                   ),
// //     //                   detailWidget(
// //     //                     icon: Icons.email,
// //     //                     text: 'coderofceylon@gmail.com',
// //     //                   ),
// //     //                   detailWidget(
// //     //                     icon: Icons.location_on,
// //     //                     text: 'Galle, Sri Lanka',
// //     //                   )
// //     //                 ],
// //     //               )
// //     //             ],
// //     //           ),
// //     //         ),
// //     //       ),
// //     //     ),
// //     //       ],
// //     //     ),
// //     // ),
// //     // );
// //     return Scaffold(
// //       backgroundColor: Colors.grey[900],
// //       body: Center(
// //         child: Container(
// //           height: height * 0.7,
// //           width: width * 0.8,
// //           decoration: BoxDecoration(
// //             borderRadius: BorderRadius.circular(30),
// //             gradient: LinearGradient(
// //               colors: [
// //                 Colors.purple,
// //                 Colors.red,
// //               ],
// //             ),
// //           ),
// //           child: ClipRRect(
// //             borderRadius: BorderRadius.circular(30),
// //             child: CustomPaint(
// //               size: Size(width, height),
// //               painter: CardCustomPainter(),
// //               child: Stack(
// //                 children: [
// //                   Positioned(
// //                     bottom: 10,
// //                     left: 10,
// //                     child: Image.asset(
// //                       'assets/images/img.png',
// //                       color: Colors.purpleAccent.withOpacity(0.3),
// //                       width: width * 0.7,
// //                     ),
// //                   ),
// //                   Positioned(
// //                     bottom: 30,
// //                     left: 20,
// //                     child: Image.asset(
// //                       'assets/2.png',
// //                       width: width * 0.7,
// //                       color: Colors.white70,
// //                     ),
// //                   ),
// //                   Column(
// //                     children: [
// //                       SizedBox(
// //                         height: 30,
// //                       ),
// //                       Center(
// //                         child: Image.asset(
// //                           'assets/images/eye.png',
// //                           color: Colors.deepPurple[700],
// //                           width: width * 0.4,
// //                         ),
// //                       ),
// //                       Text(
// //                         'Cylon Coder',
// //                         style: TextStyle(
// //                           color: Colors.deepPurple[700],
// //                           fontSize: 25,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       SizedBox(
// //                         height: 110,
// //                       ),
// //                       detailWidget(
// //                         icon: Icons.phone,
// //                         text: '+94765555777',
// //                       ),
// //                       detailWidget(
// //                         icon: Icons.email,
// //                         text: 'coderofceylon@gmail.com',
// //                       ),
// //                       detailWidget(
// //                         icon: Icons.location_on,
// //                         text: 'Galle, Sri Lanka',
// //                       )
// //                     ],
// //                   )
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget detailWidget({required IconData icon, required String text}) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 30),
// //       child: Column(
// //         children: [
// //           Row(
// //             children: [
// //               Icon(
// //                 icon,
// //                 size: 30,
// //                 color: Colors.white70,
// //               ),
// //               SizedBox(
// //                 width: 20,
// //               ),
// //               Expanded(
// //                 child: Text(
// //                   text,
// //                   overflow: TextOverflow.ellipsis,
// //                   style: TextStyle(
// //                     fontSize: 20,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.white70,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //           Divider(),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // Widget detailWidget({required IconData icon, required String text}) {
// //   return Padding(
// //     padding: const EdgeInsets.symmetric(horizontal: 30),
// //     child: Column(
// //       children: [
// //         Row(
// //           children: [
// //             Icon(
// //               icon,
// //               size: 30,
// //               color: Colors.white70,
// //             ),
// //             SizedBox(
// //               width: 20,
// //             ),
// //             Expanded(
// //               child: Text(
// //                 text,
// //                 overflow: TextOverflow.ellipsis,
// //                 style: TextStyle(
// //                   fontSize: 20,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.white70,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //         Divider(),
// //       ],
// //     ),
// //   );
// // }

// // class CardCustomPainter extends CustomPainter {
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     Paint paint = new Paint()
// //       ..color = Colors.black
// //       ..style = PaintingStyle.fill;

// //     Path path = Path();
// //     path.moveTo(0, 0);
// //     path.lineTo(0, size.height * 0.32);
// //     path.quadraticBezierTo(size.width * 0.24, size.height * 0.45,
// //         size.width * 0.49, size.height * 0.45);
// //     path.quadraticBezierTo(
// //         size.width * 0.73, size.height * 0.45, size.width, size.height * 0.32);
// //     path.lineTo(size.width, 0);
// //     path.lineTo(0, 0);
// //     path.close();

// //     canvas.drawPath(path, paint);
// //   }

// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) {
// //     // TODO: implement shouldRepaint
// //     throw UnimplementedError();
// //   }
// // }

// // //old design inside the scaffold
// // // body: Center(
// // //         child: Column(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: [
// // //             SizedBox(
// // //               height: 40,
// // //             ),
// // //             Container(
// // //               height: 200,
// // //               width: 300,
// // //               child: Card(
// // //                 shape: RoundedRectangleBorder(
// // //                   borderRadius: BorderRadius.circular(20),
// // //                 ),
// // //                 color: Color.fromARGB(209, 152, 86, 223),
// // //                 child: Column(
// // //                   mainAxisSize: MainAxisSize.min,
// // //                   children: [
// // //                     Padding(
// // //                       padding: const EdgeInsets.all(12.0),
// // //                       child: ListTile(
// // //                         leading: Icon(
// // //                           Icons.person,
// // //                           color: Colors.white70,
// // //                           size: 60,
// // //                         ),
// // //                         title: Text(
// // //                           'Card title',
// // //                           style: TextStyle(
// // //                               color: Colors.white70,
// // //                               fontSize: 20,
// // //                               fontWeight: FontWeight.bold),
// // //                         ),
// // //                         subtitle: Padding(
// // //                           padding: const EdgeInsets.only(top: 8.0),
// // //                           child: Text(
// // //                             'Youtube',
// // //                             style: TextStyle(
// // //                               color: Colors.white70,
// // //                               fontSize: 15,
// // //                               fontWeight: FontWeight.bold,
// // //                             ),
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),

// // //             SizedBox(
// // //               height: 30,
// // //             ),
// // //             //2nd conatiner
// // //             Container(
// // //               height: 200,
// // //               width: 300,
// // //               child: Card(
// // //                 shape: RoundedRectangleBorder(
// // //                   borderRadius: BorderRadius.circular(20),
// // //                 ),
// // //                 color: Color.fromARGB(234, 191, 94, 240),
// // //                 child: Column(
// // //                   mainAxisSize: MainAxisSize.min,
// // //                   children: [
// // //                     Padding(
// // //                       padding: const EdgeInsets.all(12.0),
// // //                       child: ListTile(
// // //                         leading: Icon(
// // //                           Icons.person,
// // //                           color: Colors.white70,
// // //                           size: 60,
// // //                         ),
// // //                         title: Text(
// // //                           'Card title',
// // //                           style: TextStyle(
// // //                               color: Colors.white70,
// // //                               fontSize: 20,
// // //                               fontWeight: FontWeight.bold),
// // //                         ),
// // //                         subtitle: Padding(
// // //                           padding: const EdgeInsets.only(top: 8.0),
// // //                           child: Text(
// // //                             'Youtube',
// // //                             style: TextStyle(
// // //                               color: Colors.white70,
// // //                               fontSize: 15,
// // //                               fontWeight: FontWeight.bold,
// // //                             ),
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ),
// // //                     Padding(
// // //                       padding: const EdgeInsets.all(12.0),
// // //                       child: Text(
// // //                         "Silver Membership : (Access to all Gyms + Traineer)",
// // //                         style: TextStyle(
// // //                           color: Colors.white70,
// // //                           fontSize: 17,
// // //                           fontWeight: FontWeight.bold,
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),

// // //             SizedBox(
// // //               height: 30,
// // //             ),
// // //             //3rd Container
// // //             Container(
// // //               height: 200,
// // //               width: 300,
// // //               child: Card(
// // //                 shape: RoundedRectangleBorder(
// // //                   borderRadius: BorderRadius.circular(20),
// // //                 ),
// // //                 color: Color.fromARGB(255, 220, 105, 241),
// // //                 child: Column(
// // //                   mainAxisSize: MainAxisSize.min,
// // //                   children: [
// // //                     Padding(
// // //                       padding: const EdgeInsets.all(12.0),
// // //                       child: ListTile(
// // //                         leading: Icon(
// // //                           Icons.person,
// // //                           color: Colors.white70,
// // //                           size: 60,
// // //                         ),
// // //                         title: Text(
// // //                           'Card title',
// // //                           style: TextStyle(
// // //                               color: Colors.white70,
// // //                               fontSize: 20,
// // //                               fontWeight: FontWeight.bold),
// // //                         ),
// // //                         subtitle: Padding(
// // //                           padding: const EdgeInsets.only(top: 8.0),
// // //                           child: Text(
// // //                             'Youtube',
// // //                             style: TextStyle(
// // //                               color: Colors.white70,
// // //                               fontSize: 15,
// // //                               fontWeight: FontWeight.bold,
// // //                             ),
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ),
// // //                     ListTile(
// // //                       title: Text(
// // //                         "Brownze Membership :",
// // //                         style: TextStyle(
// // //                           color: Colors.white,
// // //                           fontSize: 20,
// // //                           fontWeight: FontWeight.bold,
// // //                         ),
// // //                       ),
// // //                       subtitle: Padding(
// // //                         padding: const EdgeInsets.only(top: 8.0),
// // //                         child: Text(
// // //                           "Access to all Gyms",
// // //                           style: TextStyle(
// // //                             color: Colors.white70,
// // //                             fontSize: 15,
// // //                             fontWeight: FontWeight.bold,
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             )
// // //           ],
// // //         ),
// // //       ),

// import "package:chat_bubbles/chat_bubbles.dart";
// import 'package:flutter/material.dart';
// import 'package:sitesurface_flutter_openai/sitesurface_flutter_openai.dart';

// class ChatBot extends StatefulWidget {
//   const ChatBot({super.key});

//   @override
//   State<ChatBot> createState() => _ChatBotState();
// }

// class _ChatBotState extends State<ChatBot> {
//   final _openAiClient = OpenAIClient(OpenAIConfig(
//       apiKey: "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",
//       organizationId: "org-WF6DjAMMkrsIm7g4sdUZ23wa"));

//   final _textEditingController = TextEditingController();
//   final _scrollController = ScrollController();
//   final _completionRequest =
//       CreateCompletionRequest(model: "text-davinci-003", maxTokens: 2048);

//   bool _isTyping =
//       false; // add a boolean variable to keep track of typing state

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: (const Text("Gymmate Assistant 🤖")),
//         backgroundColor: Color.fromARGB(210, 147, 95, 210),
//       ),
//       body: SafeArea(
//         child: ChatGPTBuilder(
//           completionRequest: _completionRequest,
//           openAIClient: _openAiClient,
//           builder: (context, messages, onSend) {
//             return SafeArea(
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Expanded(
//                     child: ListView.separated(
//                         itemCount: messages.length,
//                         controller: _scrollController,
//                         separatorBuilder: (context, index) => const SizedBox(
//                               height: 5,
//                             ),
//                         itemBuilder: (context, index) {
//                           var isSender = !messages[index].fromChatGPT;
//                           return BubbleSpecialThree(
//                             isSender: isSender,
//                             text: messages[index].message,
//                             color: isSender
//                                 ? Color.fromARGB(210, 147, 95, 210)
//                                 : Colors.white,
//                             tail: true,
//                             textStyle: TextStyle(
//                                 color:
//                                     isSender ? Colors.white : Colors.grey[800],
//                                 fontSize: 16),
//                           );
//                         }),
//                   ),
//                   _isTyping // display the "typing" message if the boolean is true
//                       ? Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 height: 24,
//                                 width: 24,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 3,
//                                 ),
//                               ),
//                               SizedBox(width: 8),
//                               Text(
//                                 'typing...',
//                                 style: TextStyle(
//                                   color: Color.fromARGB(210, 147, 95, 210),
//                                   fontStyle: FontStyle.italic,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       : SizedBox(),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.all(7.0),
//                           child: TextField(
//                             controller: _textEditingController,
//                             decoration: InputDecoration(
//                                 hintText: "Message",
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(21))),
//                           ),
//                         ),
//                       ),
//                       FloatingActionButton(
//                         onPressed: () {
//                           if (_textEditingController.text.trim().isEmpty)
//                             return;
//                           setState(() {
//                             // set the boolean to true when send button is pressed
//                             _isTyping = true;
//                           });
//                           onSend(_textEditingController.text).whenComplete(() {
//                             setState(() {
//                               // set the boolean back to false when response is received
//                               _isTyping = false;
//                             });
//                             _scrollController.jumpTo(
//                                 _scrollController.position.maxScrollExtent);

//                             _scrollController.animateTo(
//                               _scrollController.position.maxScrollExtent,
//                               duration: Duration(milliseconds: 100),
//                               curve: Curves.ease,
//                             );
//                           });
//                           FocusScope.of(context).unfocus();
//                           _textEditingController.clear();
//                         },
//                         child: const Icon(Icons.send),
//                         backgroundColor: Color.fromARGB(210, 147, 95, 210),
//                       ),
//                       const SizedBox(
//                         width: 7,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }


























// // class ChatBot extends StatefulWidget {
// //   const ChatBot({super.key});

// //   @override
// //   State<ChatBot> createState() => _ChatBotState();
// // }

// // class _ChatBotState extends State<ChatBot> {
// //   final _openAiClient = OpenAIClient(OpenAIConfig(
// //       apiKey: "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",
// //       organizationId: "org-WF6DjAMMkrsIm7g4sdUZ23wa"));

// //   final _textEditingController = TextEditingController();
// //   final _scrollController = ScrollController();
// //   final _completionRequest =
// //       CreateCompletionRequest(model: "text-davinci-003", maxTokens: 2048);
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: (const Text("Gymmate Assistant")),
// //         backgroundColor: Color.fromARGB(255, 211, 99, 245),
// //       ),
// //       body: ChatGPTBuilder(
// //         completionRequest: _completionRequest,
// //         openAIClient: _openAiClient,
// //         builder: (context, messages, onSend) {
// //           return Column(
// //             children: [
// //               const SizedBox(
// //                 height: 10,
// //               ),
// //               Expanded(
// //                 child: ListView.separated(
// //                     itemCount: messages.length,
// //                     controller: _scrollController,
// //                     separatorBuilder: (context, index) => const SizedBox(
// //                           height: 5,
// //                         ),
// //                     itemBuilder: (context, index) {
// //                       var isSender = !messages[index].fromChatGPT;
// //                       return BubbleSpecialThree(
// //                         isSender: isSender,
// //                         text: messages[index].message,
// //                         color: isSender
// //                             ? Color.fromARGB(255, 211, 99, 245)
// //                             : Colors.white,
// //                         tail: true,
// //                         textStyle: TextStyle(
// //                             color: isSender ? Colors.white : Colors.grey[800],
// //                             fontSize: 16),
// //                       );
// //                     }),
// //               ),
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(10.0),
// //                       child: TextField(
// //                         controller: _textEditingController,
// //                         decoration: InputDecoration(
// //                             hintText: "Message",
// //                             border: OutlineInputBorder(
// //                                 borderRadius: BorderRadius.circular(21))),
// //                       ),
// //                     ),
// //                   ),
// //                   FloatingActionButton(
// //                     onPressed: () {
// //                       if (_textEditingController.text.trim().isEmpty) return;
// //                       onSend(_textEditingController.text).whenComplete(() {
// //                         _scrollController
// //                             .jumpTo(_scrollController.position.maxScrollExtent);
// //                       });
// //                       FocusScope.of(context).unfocus();
// //                       _textEditingController.clear();
// //                     },
// //                     child: const Icon(Icons.send),
// //                     backgroundColor: Color.fromARGB(255, 218, 107, 241),
// //                   ),
// //                   const SizedBox(
// //                     width: 7,
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }