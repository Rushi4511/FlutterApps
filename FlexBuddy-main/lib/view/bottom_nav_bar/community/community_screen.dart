import 'dart:developer';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_buddy/view/bottom_nav_bar/community/add_community_post.dart';
import 'package:flex_buddy/controller/sessions.dart';
import 'package:flex_buddy/view/bottom_nav_bar/community/community_post_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool visibleFloatingButton = true;
  List<CommunityModel> allCommunityList = [];
  List<CommunityModel> myCommunityList = [];
  bool isLoadingFirebase = true;
  Map<String, bool> userLikedPosts = {};

  late String email;
  String? name;
  bool isLoading = true;

  Future<void> getUserName(String email) async {
    try {
      final firestore = FirebaseFirestore.instance;
      DocumentSnapshot docSnapshot =
          await firestore.collection('Users').doc(email).get();

      if (docSnapshot.exists) {
        setState(() {
          name = docSnapshot.get('name');
          isLoading = false; // Data loaded
          log(name!);
        });
      } else {
        log('Document does not exist');
        setState(() {
          name = "Guest"; // Fallback name
          isLoading = false;
        });
      }
    } catch (e) {
      log('Error fetching name: $e');
      setState(() {
        name = "Error"; // Error fallback
        isLoading = false;
      });
    }
  }

  Future<void> collectData() async {
    email = SessionData.emailId;
    log(email);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        getMyCommunityPosts();
        visibleFloatingButton = _tabController.index == 0;
      });
    });

    // Modify this part
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await collectData();
      await getLikedPosts();
      await getCommunityPosts();
      await getMyCommunityPosts();
    });
  }

  Future<void> getLikedPosts() async {
    try {
      String userEmail = SessionData.emailId;
      
      QuerySnapshot likedPostsSnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userEmail)
          .collection('Liked Posts')
          .get();

      Map<String, bool> tempLikedPosts = {};
      for (var doc in likedPostsSnapshot.docs) {
        tempLikedPosts[doc.id] = true;
      }

      setState(() {
        userLikedPosts = tempLikedPosts;
      });
    } catch (e) {
      log('Error fetching liked posts: $e');
    }
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> getCommunityPosts() async {
    try {
      setState(() {
        isLoadingFirebase = true;
      });

      QuerySnapshot response = await FirebaseFirestore.instance
          .collection("All Community Posts")
          .get();

      List<CommunityModel> tempList = [];
      log('Total All Community Posts: ${response.docs.length}');
      for (var doc in response.docs) {
        log('Post Details: ${doc.data()}');
        tempList.add(
          CommunityModel(
            id: doc.id,
            name: doc['name'] ?? 'Unknown',
            title: doc['title'] ?? 'No Title',
            description: doc['description'] ?? 'No Description',
            date: doc['date'] ?? '',
            time: doc['time'] ?? '',
            likes: int.tryParse(doc['likes']?.toString() ?? '0') ?? 0,
          ),
        );
      }

      setState(() {
        allCommunityList = tempList;
        isLoadingFirebase = false;
      });
    } catch (e) {
      log('Error fetching community posts: $e');
      setState(() {
        isLoadingFirebase = false;
      });
    }
  }

  Future<void> getMyCommunityPosts() async {
    try {
      // Log session and email details
      log('Session Email: ${SessionData.emailId}');

      if (SessionData.emailId.isEmpty) {
        log('ERROR: No email found in session');
        return;
      }

      setState(() {
        isLoadingFirebase = true;
      });

      // Detailed Firestore query logging
      final collectionRef = FirebaseFirestore.instance
          .collection("Users")
          .doc(SessionData.emailId)
          .collection('My Community Posts');

      log('Collection Reference Path: ${collectionRef.path}');

      QuerySnapshot response = await collectionRef.get();

      log('Documents found: ${response.docs.length}');

      if (response.docs.isEmpty) {
        log('No documents found in My Community Posts');
      }

      List<CommunityModel> tempList = [];
      log('Total User Community Posts: ${response.docs.length}');
      for (var doc in response.docs) {
        log('Post Details: ${doc.data()}');
        log('Post id: ${doc.id}');

        tempList.add(
          CommunityModel(
            name: doc['name'] ?? 'Unknown',
            title: doc['title'] ?? 'No Title',
            description: doc['description'] ?? 'No Description',
            date: doc['date'] ?? '',
            time: doc['time'] ?? '',
            likes: doc['likes'] ?? '0',
            id : doc.id
          ),
        );
      }

      setState(() {
        myCommunityList = tempList;
        isLoadingFirebase = false;
      });
    } catch (e, stackTrace) {
      log('CRITICAL ERROR in getMyCommunityPosts: $e');
      log('Stack Trace: $stackTrace');

      setState(() {
        isLoadingFirebase = false;
      });
    }
  }

  Future<void> _likePost(CommunityModel post, bool isAllPosts) async {
    try {
      // Get the current user's email
      String userEmail = SessionData.emailId;

      // Reference to the user's liked posts document
      DocumentReference userLikedPostsRef = FirebaseFirestore.instance
          .collection("Users")
          .doc(userEmail)
          .collection('Liked Posts')
          .doc(post.id); // Use post title as unique identifier

      // Check if the user has already liked this post
      DocumentSnapshot likedPostSnapshot = await userLikedPostsRef.get();

      if (likedPostSnapshot.exists) {
        // User has already liked the post, so unlike it
        await userLikedPostsRef.delete();

        setState(() {
          post.likes--;
          userLikedPosts.remove(post.id);
        });
        // Update likes in Firebase
        await _updatePostLikes(post, isAllPosts, false);
      } else {
        // User is liking the post for the first time
        await userLikedPostsRef.set(
            {'postId': post.id, 'likedAt': FieldValue.serverTimestamp()});

        setState(() {
          post.likes++;
          userLikedPosts[post.id] = true;
        });

        // Update likes in Firebase
        await _updatePostLikes(post, isAllPosts, true);
      }
    } catch (e) {
      log('Error toggling like: $e');
      // Revert local likes if update fails
      setState(() {
        post.likes = post.likes;
      });
    }
  }

  Future<void> _updatePostLikes(
      CommunityModel post, bool isAllPosts, bool isLiking) async {
    try {
      // Update in All Community Posts
      if (isAllPosts) {
        await FirebaseFirestore.instance
            .collection("All Community Posts")
            .where('title', isEqualTo: post.title)
            .where('name', isEqualTo: post.name)
            .get()
            .then((querySnapshot) {
          for (var doc in querySnapshot.docs) {
            doc.reference.update({'likes': post.likes});
          }
        });
      }

      // Update in User's My Community Posts
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(SessionData.emailId)
          .collection('My Community Posts')
          .where('title', isEqualTo: post.title)
          .where('name', isEqualTo: post.name)
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.update({'likes': post.likes});
        }
      });
    } catch (e) {
      log('Error updating likes: $e');
    }
  }

  Widget buildPostItem(
      CommunityModel post, BuildContext context, bool isAllPosts) {
        bool isLiked = userLikedPosts[post.id] ?? false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: GestureDetector(
        onTap: () {
          
          PersistentNavBarNavigator.pushNewScreen(context,withNavBar: false,
              screen: CommunityPostDetail(post: post, postId:post.id));
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey.shade900,
                Colors.grey.shade800,
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Info Row with improved styling
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color.fromRGBO(137, 108, 254, 1),
                          width: 2,
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.transparent,
                        child: Icon(Icons.account_circle,
                            size: 50, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.name,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${post.date} at ${post.time}',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Like Button with more interactive design
                    GestureDetector(
                      onTap: () {
                        _likePost(post, isAllPosts);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: isLiked
                              ? Colors.red.withOpacity(0.2)
                              : Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: isLiked ? Colors.red : Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              post.likes.toString(),
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Title with more emphasis
                Text(
                  post.title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(137, 108, 254, 1),
                  ),
                ),
                const SizedBox(height: 10),

                // Description with improved readability
                Text(
                  post.description,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget allCommunityPosts() {
    if (isLoadingFirebase) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color.fromRGBO(137, 108, 254, 1),
        ),
      );
    }
    if (allCommunityList.isEmpty) {
      return Center(
        child: Text(
          'No posts available',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      );
    }
    return Column(
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: RefreshIndicator(
            onRefresh: getCommunityPosts,
            child: ListView.builder(
              itemCount: allCommunityList.length,
              itemBuilder: (context, index) {
                final post = allCommunityList[index];
                return buildPostItem(post, context, true);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget myCommunityPosts() {
    if (isLoadingFirebase) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color.fromRGBO(137, 108, 254, 1),
        ),
      );
    }
    if (myCommunityList.isEmpty) {
      return Center(
        child: Text(
          'No posts available',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      );
    }
    return Column(
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: RefreshIndicator(
            onRefresh: getMyCommunityPosts,
            child: ListView.builder(
              itemCount: myCommunityList.length,
              itemBuilder: (context, index) {
                final post = myCommunityList[index];
                return buildPostItem(post, context, false);
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: visibleFloatingButton
          ? null :FloatingActionButton.extended(
              onPressed: ()async  {
               
               await  PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const AddCommunityPost(),
                  withNavBar: false,
                );
               setState(() {
                 
               }); 
              },
              backgroundColor: Colors.white,
              icon: const Icon(
                Icons.add,
                color: Colors.black,
                size: 25,
              ),
              label: Text(
                "Add Post",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.black,
        title: Text(
          "Community",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: const Color.fromRGBO(137, 108, 254, 1),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ButtonsTabBar(
              controller: _tabController,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(15),
              ),
              unselectedLabelStyle: GoogleFonts.leagueSpartan(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black,
              ),
              labelStyle: GoogleFonts.leagueSpartan(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black,
              ),
              height: 50,
              width: 200,
              contentCenter: true,
              unselectedDecoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              tabs: const [
                Tab(text: "All Posts"),
                Tab(text: "My Posts"),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[allCommunityPosts(), myCommunityPosts()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommunityModel {
  final String name;
  final String title;
  final String description;
  final String date;
  final String time;
  final String id;
  int likes;

  CommunityModel({
    required this.name,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.id,
    this.likes = 0,
  });
}
