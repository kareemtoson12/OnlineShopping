import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:online_shopping/features/search/serch_by_text_view.dart';

class SearchBarr extends StatefulWidget {
  const SearchBarr({Key? key}) : super(key: key);

  @override
  _SearchBarrState createState() => _SearchBarrState();
}

class _SearchBarrState extends State<SearchBarr> {
  final TextEditingController searchController = TextEditingController();
  late stt.SpeechToText _speech;
  bool isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  Future<void> _startListening() async {
    if (!_speech.isAvailable) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          setState(() {});
          print('Status: $status');
        },
        onError: (error) {
          print('Error: $error');
        },
      );

      if (!available) {
        print('Speech recognition not available.');
        return;
      }
    }

    setState(() {
      isListening = true;
    });

    _speech.listen(onResult: (result) {
      setState(() {
        searchController.text = result.recognizedWords;
      });

      if (!_speech.isListening) {
        setState(() {
          isListening = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchResultsScreen(
              searchQuery: result.recognizedWords,
            ),
          ),
        );
      }
    });
  }

  void _stopListening() {
    _speech.stop();
    setState(() {
      isListening = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: '   Search for products...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 0.w,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              final query = searchController.text.trim();
              if (query.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SearchResultsScreen(searchQuery: query),
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: Icon(
              isListening ? Icons.mic : Icons.mic_none,
              color: isListening ? Colors.red : Colors.black,
            ),
            onPressed: isListening ? _stopListening : _startListening,
          ),
        ],
      ),
    );
  }
}
