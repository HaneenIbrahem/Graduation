import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:new_design/Screens/messages.dart';

import '../services/utils.dart';
import '../widgets/text_widget.dart';

class ChatBot extends StatefulWidget {
  // final int currentIndex;
  const ChatBot({
    Key? key,
    // required this.currsentIndex,
    // required this.currentIndex
  }) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  @override
  void initState() {
    DialogFlowtter.fromFile().then((insatance) => dialogFlowtter = insatance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final isDark = Utils(context).getTheme;
    final Size size = Utils(context).getScreenSize;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.android,
            color: color,
            size: 40,
          ),
        ),
        title: TextWidget(
          fontFamily: 'times-new-roman',
          text: 'SuppMeBot',
          color: color,
          isTitle: true,
          textSize: 22,
        ),
      ),
      body: Container(
        child: Column(children: [
          Expanded(child: MessagesScreen(messages: messages)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            color: Color.fromARGB(255, 80, 160, 180),
            child: Row(children: [
              Expanded(
                  child: TextField(
                controller: _controller,
                style: TextStyle(color: Colors.black),
              )),
              IconButton(
                  onPressed: () {
                    sendMessages(_controller.text);
                    _controller.clear();
                  },
                  icon: Icon(Icons.send))
            ]),
          )
        ]),
      ),
      // ),
    );
  }

  sendMessages(String text) async {
    if (text.isEmpty) {
      print('Message is ampty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });
      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
