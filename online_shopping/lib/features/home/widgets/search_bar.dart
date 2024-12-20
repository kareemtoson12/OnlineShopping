import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:online_shopping/features/search/serch_by_text_view.dart';

// A Stateful widget for the search bar, which supports both text-based and voice-based search
class SearchBarr extends StatefulWidget {
  const SearchBarr({Key? key}) : super(key: key);

  @override
  _SearchBarrState createState() => _SearchBarrState();
}

class _SearchBarrState extends State<SearchBarr> {
  // Text controller for managing the search input field
  final TextEditingController searchController = TextEditingController();

  // SpeechToText object for handling voice recognition
  late stt.SpeechToText _speech;

  // Boolean to track whether the app is currently listening to the user's voice
  bool isListening = false;

  @override
  void initState() {
    super.initState();
    // Initialize the SpeechToText object
    _speech = stt.SpeechToText();
  }

  // Method to start listening to the user's voice input
  Future<void> _startListening() async {
    // Check if speech recognition is available
    if (!_speech.isAvailable) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          // Update UI based on status changes
          setState(() {});
          print('Status: $status');
        },
        onError: (error) {
          // Handle error during speech recognition
          print('Error: $error');
        },
      );

      // If speech recognition is not available, display a message and return
      if (!available) {
        print('Speech recognition not available.');
        return;
      }
    }

    // Change state to indicate listening has started
    setState(() {
      isListening = true;
    });

    // Start listening and capture the speech result
    _speech.listen(onResult: (result) {
      setState(() {
        // Update the search text field with the recognized words
        searchController.text = result.recognizedWords;
      });

      // Once speech recognition is done, navigate to the search results screen
      if (!_speech.isListening) {
        setState(() {
          // Stop listening
          isListening = false;
        });

        // Navigate to the SearchResultsScreen with the recognized words as the search query
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

  // Method to stop listening when the mic icon is pressed again
  void _stopListening() {
    _speech.stop();
    setState(() {
      isListening = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h, // Height of the search bar
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the search bar
        borderRadius: BorderRadius.circular(20.r), // Rounded corners
      ),
      child: Row(
        children: [
          // Search text field
          Expanded(
            child: TextField(
              controller: searchController, // Link the text controller
              decoration: InputDecoration(
                hintText: '   Search for products...', // Placeholder text
                border: InputBorder.none, // No border for the text field
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.h, // Vertical padding
                  horizontal: 0.w, // Horizontal padding
                ),
              ),
            ),
          ),
          // Search icon button: Trigger a search when tapped
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              final query = searchController.text.trim(); // Get the trimmed query
              if (query.isNotEmpty) {
                // Navigate to SearchResultsScreen with the query if it's not empty
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchResultsScreen(searchQuery: query),
                  ),
                );
              }
            },
          ),
          // Microphone icon button: Toggle between listening and not listening
          IconButton(
            icon: Icon(
              isListening ? Icons.mic : Icons.mic_none, // Change icon based on listening state
              color: isListening ? Colors.red : Colors.black, // Change color based on state
            ),
            onPressed: isListening ? _stopListening : _startListening, // Start/stop listening on press
          ),
        ],
      ),
    );
  }
}
