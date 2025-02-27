import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_buddy/colors.dart';
import 'package:flex_buddy/view/bottom_nav_bar/community/community_screen.dart';
import 'package:flex_buddy/controller/sessions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CommunityPostDetail extends StatefulWidget {
  final CommunityModel post;
  final String postId;

  const CommunityPostDetail({
    super.key,
    required this.post,
    required this.postId,
  });

  @override
  State<CommunityPostDetail> createState() => _CommunityPostDetailState();
}

class _CommunityPostDetailState extends State<CommunityPostDetail> {
  final TextEditingController _commentController = TextEditingController();
  late String _currentUserEmail;
  late String _currentUserName;
  
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    await SessionData.getSessionData();
    setState(() {
      _currentUserEmail = SessionData.emailId;
    });

    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(_currentUserEmail)
          .get();
      
      setState(() {
        _currentUserName = userDoc.get('name') ?? 'Anonymous';
      });
    } catch (e) {
      setState(() {
        _currentUserName = 'Anonymous';
      });
    }
  }

  Future<void> _submitComment() async {
    String commentText = _commentController.text.trim();
    if (commentText.isEmpty) return;

    try {
      final now = DateTime.now();
      String formattedDate = DateFormat('dd-MM-yyyy').format(now);
      String formattedTime = DateFormat('HH:mm').format(now);

      Map<String, dynamic> commentData = {
        'email': _currentUserEmail,
        'name': _currentUserName,
        'description': commentText,
        'date': formattedDate,
        'time': formattedTime,
      };

      await FirebaseFirestore.instance
          .collection('All Community Posts')
          .doc(widget.postId)
          .collection('Comments')
          .add(commentData);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(_currentUserEmail)
          .collection('My Community Posts')
          .doc(widget.postId)
          .collection('Comments')
          .add(commentData);

      _commentController.clear();
      setState(() {});
    } catch (e) {
      // ignore: avoid_print
      print('Error submitting comment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 70,
                      alignment: Alignment.center,
                      child: Icon(Icons.arrow_back_ios_new_rounded, color: MyColors.yellow),
                    ),
                  ),
                  Text(
                    "Post Details",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: MyColors.yellow,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: CustomScrollView(
                
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // Post Header
                        
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withOpacity(0.1),
                                Colors.white.withOpacity(0.1),
                              ],
                            ),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color.fromRGBO(137, 108, 254, 1),
                                      Colors.purple.shade200,
                                    ],
                                  ),
                                ),
                                child: const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.transparent,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.post.name,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Posted • ${widget.post.date} ${widget.post.time}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        _buildSectionTitle("Title"),
                        _buildGradientContainer(
                          child: Text(
                            widget.post.title,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        _buildSectionTitle("Description"),
                        _buildGradientContainer(
                          child: Text(
                            widget.post.description,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        _buildSectionTitle("Comments"),
                        
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('All Community Posts')
                              .doc(widget.postId)
                              .collection('Comments')
                              .orderBy('date', descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }

                            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                              return _buildNoCommentsWidget();
                            }

                            return Column(
                              children: snapshot.data!.docs.map((doc) {
                                return _buildCommentCard(doc);
                              }).toList(),
                            );
                          },
                        ),
                        // Add extra padding at the bottom for content to scroll above the comment input
                        const SizedBox(height: 80),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      
      bottomSheet: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 10,            
          ),
          child: _buildCommentInput(),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: const Color.fromRGBO(137, 108, 254, 1),
        ),
      ),
    );
  }

  Widget _buildGradientContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.1),
          ],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: child,
    );
  }

  Widget _buildCommentCard(DocumentSnapshot commentDoc) {
    Map<String, dynamic> commentData = commentDoc.data() as Map<String, dynamic>;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.purple.shade200,
                child: const Icon(Icons.person, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 10),
              Text(
                commentData['name'] ?? 'Anonymous',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '${commentData['date']} • ${commentData['time']}',
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            commentData['description'],
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoCommentsWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Text(
        'No comments yet. Be the first to comment!',
        style: GoogleFonts.poppins(
          color: Colors.white.withOpacity(0.7),
          fontStyle: FontStyle.italic,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: CircleAvatar(
              radius: 20,
              child: Icon(Icons.account_circle),
            ),
          ),
          Expanded(
            child: TextField(
              controller: _commentController,
              style: GoogleFonts.poppins(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: "Add a comment...",
                hintStyle: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.5),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromRGBO(137, 108, 254, 1),
                  Colors.purple.shade200,
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ),
              onPressed: _submitComment,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}