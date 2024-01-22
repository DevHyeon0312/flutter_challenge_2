import 'package:flutter/material.dart';

class Deepen1Solution extends StatefulWidget {
  const Deepen1Solution({super.key});

  @override
  State<Deepen1Solution> createState() => _Deepen1SolutionState();
}

class _Deepen1SolutionState extends State<Deepen1Solution> {
  ValueNotifier<List<Message>> chatList = ValueNotifier([
    Message(messageType: MessageType.answer, data: 'Hello, how can I help you?')
  ]);

  void addMessage(String message) {
    chatList.value = [
      ...chatList.value,
      Message(messageType: MessageType.question, data: message),
      Message(
          messageType: MessageType.answer,
          data:
              'Actually, I don\'t have any features, but one day I\'ll grow up and become ChatGPT!')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.black,
        leading: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(
            Icons.menu,
            size: 24,
          ),
        ),
        leadingWidth: 24,
        title: const Text.rich(
          TextSpan(
            text: 'MyCuteGPT ',
            style: Deepen1TextStyle.appBarTitle,
            children: [
              TextSpan(
                text: '3.5',
                style: Deepen1TextStyle.appBarSubTitle,
              ),
            ],
          ),
          textScaler: TextScaler.noScaling,
        ),
        actions: const [
          Icon(
            Icons.edit,
            size: 24,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Icon(
              Icons.more_vert_rounded,
              size: 24,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: MessageListView(
                  chatList: chatList,
                ),
              ),
              MessageInputField(
                sendMessage: (message) {
                  addMessage(message);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// 메시지
enum MessageType { question, answer }

class Message {
  MessageType messageType;
  String data;

  Message({required this.messageType, required this.data});
}

/// 메시지 출력 List
class MessageListView extends StatefulWidget {
  const MessageListView({super.key, required this.chatList});

  final ValueNotifier<List<Message>> chatList;

  @override
  State<MessageListView> createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.chatList,
      builder:
          (BuildContext context, List<Message> messages, Widget? child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(seconds: 1),
                curve: Curves.easeOut,
              );
            });
        return ListView.builder(
          controller: _scrollController,
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            Message message = messages[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Container(
                    color: message.messageType == MessageType.answer
                        ? Colors.green
                        : Colors.purple,
                    height: 32,
                    width: 32,
                    alignment: Alignment.center,
                    child: NoScalingText(
                      message.messageType == MessageType.answer
                          ? 'FC'
                          : 'G',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NoScalingText(
                            message.messageType == MessageType.answer
                                ? 'MyCuteGPT'
                                : 'FlutterBoot',
                            style: Deepen1TextStyle.messageTitle),
                        NoScalingText(message.data,
                            style: Deepen1TextStyle.messageBody),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )),
              ],
            );
          },
        );
      },
    );
  }
}

/// 메시지 입력 Filed
class MessageInputField extends StatefulWidget {
  const MessageInputField({super.key, required this.sendMessage});

  final Function(String)? sendMessage;

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFD8D8D8),
                borderRadius: BorderRadius.circular(32),
              ),
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(textScaler: TextScaler.noScaling),
                      child: TextField(
                        controller: _textController,
                        decoration: const InputDecoration(
                            hintText: 'Message',
                            border: InputBorder.none,
                            hintStyle: Deepen1TextStyle.textFieldHint),
                        cursorColor: Colors.black,
                        minLines: 1,
                        maxLines: 8,
                        onChanged: (value) => setState(() {}),
                        style: Deepen1TextStyle.textField,
                      ),
                    ),
                  ),
                  _textController.value.text.isEmpty
                      ? const Icon(
                          Icons.graphic_eq,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          ClipOval(
            child: Container(
              color: _textController.value.text.isEmpty ? const Color(0xFFD8D8D8) : Colors.black,
              height: 40,
              width: 40,
              child: IconButton(
                onPressed: _textController.value.text.isEmpty
                    ? null
                    : () {
                        widget.sendMessage?.call(_textController.value.text);
                        _textController.clear();
                        FocusScope.of(context).unfocus();
                      },
                icon: const Icon(
                  Icons.arrow_upward,
                ),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoScalingText extends StatelessWidget {
  const NoScalingText(
    this.data, {
    super.key,
    this.style,
  });

  final String data;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
      textScaler: TextScaler.noScaling,
    );
  }
}

class Deepen1TextStyle {
  Deepen1TextStyle._();

  static const TextStyle appBarTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  static const TextStyle appBarSubTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.normal,
    color: Colors.black54,
  );
  static const TextStyle messageTitle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  static const TextStyle messageBody = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  static const TextStyle textField = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  static const TextStyle textFieldHint = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black54,
  );
}
