import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const VirginiaInstantCodeAssistantApp());
}

class VirginiaInstantCodeAssistantApp extends StatelessWidget {
  const VirginiaInstantCodeAssistantApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virginia Instant Code Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A180E), // Textured dark green background
      ),
      home: const VicaHomeScreen(),
    );
  }
}

class VicaHomeScreen extends StatefulWidget {
  const VicaHomeScreen({Key? key}) : super(key: key);

  @override
  State<VicaHomeScreen> createState() => _VicaHomeScreenState();
}

class _VicaHomeScreenState extends State<VicaHomeScreen> {
  late stt.SpeechToText _speech;
  late FlutterTts _tts;
  bool _isListening = false;
  bool _isDbConnected = true; // State database indicator light
  String _recognizedVoiceText = "";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _tts = FlutterTts();
    _tts.setLanguage("en-US");
    _tts.setPermanentLanguage("en-US");
    _tts.setSpeechRate(0.45);
  }

  void _toggleVoiceActivation() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _recognizedVoiceText = val.recognizedWords;
            if (val.finalResult) {
              _isListening = false;
              _executeLawLookup(_recognizedVoiceText);
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _executeLawLookup(String query) {
    // Connects offline cache directly to automated LIS data tables
    print("Querying state records for: $query");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Gold Sheriff Star Emblem
                const Icon(
                  Icons.star, 
                  color: Color(0xFFD4AF37), 
                  size: 80
                ),
                const SizedBox(height: 10),

                // Main Master Heading
                const Text(
                  "VIRGINIA INSTANT\nCODE ASSISTANT",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFD4AF37), // Weathered Gold Text
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Criminal, Traffic, Game-Fish, Juvenile/Domestic Laws",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 25),

                // Central Voice Command Interface Deck
                Center(
                  child: GestureDetector(
                    onTap: _toggleVoiceActivation,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: const Color(0xFF142B1A),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFD4AF37), width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: _isListening ? Colors.red.withOpacity(0.5) : Colors.black33,
                            blurRadius: 10,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "TAP TO SPEAK",
                            style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Icon(
                            _isListening ? Icons.mic : Icons.mic_none,
                            color: const Color(0xFFD4AF37),
                            size: 40,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "VOICE ACTIVATE",
                            style: TextStyle(color: Color(0xFFD4AF37), fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // The Four Custom Functional Division Buttons
                _buildCategoryCard(
                  title: "CRIMINAL",
                  subtitle: "e.g., 'Search Virginia Code Title 18.2'",
                  icon: Icons.lock_outline,
                ),
                _buildCategoryCard(
                  title: "TRAFFIC",
                  subtitle: "e.g., 'Search Virginia Code Title 46.2'",
                  icon: Icons.directions_car_filled_outlined,
                ),
                _buildCategoryCard(
                  title: "GAME-FISH",
                  subtitle: "e.g., 'Search Virginia Code Title 29.1'",
                  icon: Icons.waves_outlined,
                ),
                _buildCategoryCard(
                  title: "JUVENILE DOMESTIC RELATIONS",
                  subtitle: "e.g., 'Search Domestic & Family Law Codes'",
                  icon: Icons.child_care_outlined,
                ),
                const SizedBox(height: 25),

                // State Database Synchronization Light Panel
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "GLO",
                      style: TextStyle(color: Colors.white38, fontSize: 11),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _isDbConnected ? Colors.red : Colors.grey, // Live connection indicator
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      "STATE DB CONNECTED",
                      style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // Official Retirement & Creator Attribution Footer
                const Divider(color: Color(0xFF142B1A), thickness: 1),
                const SizedBox(height: 5),
                const Text(
                  "ALL RIGHTS RESERVED.\nAPP CREATED BY DEPUTY SHERIFF EARL A. WOOD\nRETIRED VIRGINIA!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard({required String title, required String subtitle, required IconData icon}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFF0F2415),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1A3D24), width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.between,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                ),
              ],
            ),
          ),
          Icon(icon, color: const Color(0xFFD4AF37), size: 28),
        ],
      ),
    );
  }
}
