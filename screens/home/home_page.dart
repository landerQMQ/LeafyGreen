import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leafygreen_flutternet/screens/home/search_screen.dart';
import 'package:leafygreen_flutternet/screens/home/splash_screen.dart';
import 'package:leafygreen_flutternet/screens/offers/offers_list.dart';
import 'package:leafygreen_flutternet/screens/posts/create_post_screen.dart';
import 'package:leafygreen_flutternet/screens/profile_screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../Groups/groups_list.dart';
import 'package:leafygreen_flutternet/screens/plant_health/imagesearchscreens.dart';
import 'package:leafygreen_flutternet/screens/plant_searcher/plant_search.dart';
import 'package:leafygreen_flutternet/screens/posts/create_post_screen.dart';
import '../groups/groups_page.dart';
import '../posts/posts_screens.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await _auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SplashScreen()));

    // Clear route history
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreen()),
        (route) => false);
  }

  void _navigateToSearchPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchPage()),
    );
  }

  void _navigateToProfilePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
  }

  void _navigateToGroupsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GroupsPage()),
    );
  }

  void _navigateToPostsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PostsScreen()),
    );
  }

  Future<bool> redirectto() async {
    //exit app
    return true;
  }

  void _navigateToCreatePostScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewPostScreen()),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Home Page'),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => _logout(context),
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => _navigateToSearchPage(context),
        ),
        IconButton(
          icon: const Icon(Icons.plus_one),
          onPressed: () => _navigateToProfilePage(context),
        ),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      //make it blue
      selectedItemColor: const Color.fromARGB(255, 43, 114, 7),
      unselectedItemColor: Color.fromARGB(255, 158, 158, 158),
      //make the bar color blue
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/plant_search.png',
            width: 25,
            height: 25,
          ),
          label: 'search',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/camera.png',
            width: 25,
            height: 25,
          ),
          label: 'blog',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/blog.png',
            width: 25,
            height: 25,
          ),
          label: 'blog',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/vegetable.png',
            width: 25,
            height: 25,
          ),
          label: 'vegetable',
        ),
      ],
      onTap: (index) {
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlantSearchScreen()),
          );
        }
        if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ImageSearchScreen()),
          );
        }
        if (index == 3) {
          _navigateToPostsPage(context);
        }
        if (index == 4) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OffersList()),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: WillPopScope(
        onWillPop: redirectto,
        child: const Center(
          child: Text('Hello World'),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }
}
