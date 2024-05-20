import 'package:flutter/material.dart';
import 'game_screen.dart'; // Import the GameScreen file

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showRulesPopup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Set background color to blue
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50),
              Expanded(
                child: Center(
                  child: Text(
                    'Home Screen',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to the GameScreen when Play button is pressed
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GameScreen()),
                            );
                          },
                          child: Text('Play'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _showRulesPopup = true; // Show the rules popup
                            });
                          },
                          child: Text('Rules'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_showRulesPopup)
            Container(
              color: Colors.black.withOpacity(0.5), // Semi-transparent black background
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
                  height: MediaQuery.of(context).size.height * 0.5, // 50% of screen height
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Game Rules',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'The game Rules for Civ-Hex are fairly simple. '+
                        'When u join the game u are asked to select three starting tiles, '+
                        'You can only own tiles that are touching eachother. '+
                        'The goal of the game is to reach 50 Victory Points, '+
                        'You earn 1 victory point for each tile you own, once you reach 5 tiles u get a bonus 5 VP, '+
                        'the same applies for population. ' +
                        'Tile price will increase based on how many tiles you own, '+
                        'Population will cost you 1 of each resource type. '+
                        'you role a dice and you earn the resources for the tiles that have the number the dice roled on. '+
                        'Also you can earn gold buy selling resources, one of any resource type will trade for one gold.',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _showRulesPopup = false; // Hide the rules popup
                          });
                        },
                        child: Text('Close'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
