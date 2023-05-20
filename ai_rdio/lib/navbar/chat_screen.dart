// // import "package:chat_bubbles/chat_bubbles.dart";
// // import 'package:flutter/material.dart';
// // import 'package:sitesurface_flutter_openai/sitesurface_flutter_openai.dart';

// // // "text-davinci-003" model
// // class ChatBot extends StatefulWidget {
// //   const ChatBot({super.key});

// //   @override
// //   State<ChatBot> createState() => _ChatBotState();
// // }

// // class _ChatBotState extends State<ChatBot> {

// //   final _openAiClient = OpenAIClient(
// //       OpenAIConfig(apiKey: "---abc-----", organizationId: "-----def---------"));

// //   final _textEditingController = TextEditingController();
// //   final _scrollController = ScrollController();
// //   final _completionRequest =
// //       CreateCompletionRequest(model: "text-davinci-003", maxTokens: 2048);

// //   bool _isTyping =
// //       false; // add a boolean variable to keep track of typing state

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: (const Text("Gymmate Assistant 🤖")),
// //         backgroundColor: Color.fromARGB(210, 147, 95, 210),
// //       ),
// //       body: SafeArea(
// //         child: ChatGPTBuilder(
// //           completionRequest: _completionRequest,
// //           openAIClient: _openAiClient,
// //           builder: (context, messages, onSend) {
// //             return SafeArea(
// //               child: Column(
// //                 children: [
// //                   const SizedBox(
// //                     height: 10,
// //                   ),
// //                   Expanded(
// //                     child: ListView.separated(
// //                         itemCount: messages.length,
// //                         controller: _scrollController,
// //                         separatorBuilder: (context, index) => const SizedBox(
// //                               height: 5,
// //                             ),
// //                         itemBuilder: (context, index) {
// //                           var isSender = !messages[index].fromChatGPT;
// //                           return BubbleSpecialThree(
// //                             isSender: isSender,
// //                             text: messages[index].message,
// //                             color: isSender
// //                                 ? Color.fromARGB(210, 147, 95, 210)
// //                                 : Colors.white,
// //                             tail: true,
// //                             textStyle: TextStyle(
// //                                 color:
// //                                     isSender ? Colors.white : Colors.grey[800],
// //                                 fontSize: 16),
// //                           );
// //                         }),
// //                   ),
// //                   _isTyping // display the "typing" message if the boolean is true
// //                       ? Padding(
// //                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
// //                           child: Row(
// //                             children: [
// //                               SizedBox(
// //                                 height: 24,
// //                                 width: 24,
// //                                 child: CircularProgressIndicator(
// //                                   strokeWidth: 4,
// //                                 ),
// //                               ),
// //                               SizedBox(width: 8),
// //                               Text(
// //                                 'typing...',
// //                                 style: TextStyle(
// //                                   color: Colors.grey[800],
// //                                   fontStyle: FontStyle.italic,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         )
// //                       : SizedBox(),
// //                   Row(
// //                     children: [
// //                       Expanded(
// //                         child: Padding(
// //                           padding: const EdgeInsets.all(7.0),
// //                           child: TextField(
// //                             controller: _textEditingController,
// //                             decoration: InputDecoration(
// //                                 hintText: "Message",
// //                                 border: OutlineInputBorder(
// //                                     borderRadius: BorderRadius.circular(21))),
// //                           ),
// //                         ),
// //                       ),
// //                       FloatingActionButton(
// //                         onPressed: () {
// //                           if (_textEditingController.text.trim().isEmpty)
// //                             return;
// //                           setState(() {
// //                             // set the boolean to true when send button is pressed
// //                             _isTyping = true;
// //                           });
// //                           onSend(_textEditingController.text).whenComplete(() {
// //                             setState(() {
// //                               // set the boolean back to false when response is received
// //                               _isTyping = false;
// //                             });
// //                             _scrollController.jumpTo(
// //                                 _scrollController.position.maxScrollExtent);

// //                             _scrollController.animateTo(
// //                               _scrollController.position.maxScrollExtent,
// //                               duration: Duration(milliseconds: 100),
// //                               curve: Curves.ease,
// //                             );
// //                           });
// //                           FocusScope.of(context).unfocus();
// //                           _textEditingController.clear();
// //                         },
// //                         child: const Icon(Icons.send),
// //                         backgroundColor: Color.fromARGB(210, 147, 95, 210),
// //                       ),
// //                       const SizedBox(
// //                         width: 7,
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatPage extends StatefulWidget {
  final String apiKey;

  const ChatPage({Key? key, required this.apiKey}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _textEditingController = TextEditingController();

  List<Map<String, dynamic>> _messages = [];

  bool _isTyping = false;

  Future<void> _sendMessage(String message) async {
    setState(() {
      _isTyping = true;

      _messages.add({
        'user': true,
        'message': message,
      });
    });

    var url = Uri.parse('https://api.chatgpt.com/v1/messages');

    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${widget.apiKey}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'text': message}),
    );

    var responseBody = jsonDecode(response.body);

    setState(() {
      _isTyping = false;

      _messages.add({
        'user': false,
        'message': responseBody['text'],
      });
    });
  }

  Widget _buildChatMessage(Map<String, dynamic> message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment:
            message['user'] ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: message['user'] ? Colors.blue[600] : Colors.grey[300],
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Text(
            message['message'],
            style: TextStyle(
              color: message['user'] ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chatbot')),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    var message = _messages[index];

                    return _buildChatMessage(message);
                  },
                ),
              ),
              Container(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: 'Type your message',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          if (_textEditingController.text.isNotEmpty) {
                            _sendMessage(_textEditingController.text);

                            _textEditingController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_isTyping)
            Positioned.fill(
              bottom: 50.0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
