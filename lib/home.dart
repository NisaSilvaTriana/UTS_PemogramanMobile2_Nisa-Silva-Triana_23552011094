import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'list_info.dart';
import 'about.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class ChatMessage {
  final String text;
  final bool isUser;
  final File? image;

  ChatMessage({required this.text, required this.isUser, this.image});
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Content> conversation = [];
  final List<ChatMessage> _messages = [];

  File? selectedImage;
  bool loading = false;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  Future<void> sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty && selectedImage == null) return;

    setState(() {
      _messages.add(ChatMessage(
        text: text.isEmpty ? "(image)" : text,
        isUser: true,
        image: selectedImage,
      ));
      loading = true;
      _controller.clear();
    });

    await Future.delayed(const Duration(milliseconds: 100));
    _scrollToBottom();

    try {
      String aiReply = "";

      if (selectedImage != null) {
        final bytes = selectedImage!.readAsBytesSync();
        final result = await Gemini.instance.textAndImage(
          text: text.isEmpty ? "Explain this image." : text,
          images: [bytes],
        );
        aiReply = result?.output ?? "No output.";
      } else {
        conversation.add(Content(parts: [Part.text(text)], role: "user"));
        final result = await Gemini.instance.chat(conversation);
        aiReply = result?.output ?? "No output.";
        conversation.add(Content(parts: [Part.text(aiReply)], role: "model"));
      }

      setState(() {
        _messages.add(ChatMessage(text: aiReply, isUser: false));
      });

      selectedImage = null;
      _scrollToBottom();
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(text: "Error: $e", isUser: false));
      });
    } finally {
      setState(() => loading = false);
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 50,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gemini AI")),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFB3D8FF)),
              child: Text(
                "Menu",
                style: TextStyle(fontSize: 24, fontFamily: 'Poppins'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text("Information",
                  style: TextStyle(fontFamily: 'Poppins')),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ListInfoPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text("About",
                  style: TextStyle(fontFamily: 'Poppins')),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AboutPage()));
              },
            ),
          ],
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Hello! How’s your day?",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF72A8FF),
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Ready to explore ideas with your Gemini AI?",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF72A8FF),
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment:
                      msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: msg.isUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      if (msg.image != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          width: 180,
                          height: 180,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(msg.image!, fit: BoxFit.cover),
                          ),
                        ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: msg.isUser
                              ? const Color(0xFFB3D8FF)
                              : Colors.white,
                          border: Border.all(color: const Color(0xFF72B4FF)),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          msg.text,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.image),
                  onPressed: pickImage,
                ),
                if (selectedImage != null)
                  const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 6),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: selectedImage != null
                          ? "Send image with optional text..."
                          : "Type message...",
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: loading ? null : sendMessage,
                  child: loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Send"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
