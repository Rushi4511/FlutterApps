import 'package:flex_buddy/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final List<PolicySection> sections = [
    PolicySection(
      title: "Information Collection",
      content:
          "We collect information that you provide directly to us, including but not limited to your name, email address, and workout data. This information is used to improve your experience and provide personalized services.",
      icon: Icons.info_outline,
    ),
    PolicySection(
      title: "Data Usage",
      content:
          "Your data is used to provide and improve our services, analyze usage patterns, and enhance the overall user experience. We do not sell your personal information to third parties.",
      icon: Icons.data_usage,
    ),
    PolicySection(
      title: "Data Protection",
      content:
          "We implement robust security measures to protect your personal information from unauthorized access, alteration, disclosure, or destruction. Your data is encrypted and stored securely.",
      icon: Icons.security,
    ),
    PolicySection(
      title: "User Rights",
      content:
          "You have the right to access, correct, or delete your personal information at any time. You can also opt-out of certain data collection features while still using basic app functionality.",
      icon: Icons.person_outline,
    ),
    PolicySection(
      title: "Updates to Policy",
      content:
          "We may update this privacy policy from time to time. We will notify you of any changes by posting the new privacy policy on this page and updating the effective date.",
      icon: Icons.update,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: MyColors.yellow,
                    )),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  "Privacy Policy",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: MyColors.yellow),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "Last updated: November 2024",
                style: GoogleFonts.montserrat(
                  color: Colors.grey[300],
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: sections.length,
                itemBuilder: (context, index) {
                  return _buildPolicySection(sections[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicySection(PolicySection section) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[900]!,
            Colors.grey[850]!,
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          expansionTileTheme: ExpansionTileThemeData(
            backgroundColor: Colors.transparent,
            collapsedBackgroundColor: Colors.transparent,
            iconColor: MyColors.purple,
            collapsedIconColor: Colors.grey[400],
            tilePadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: ExpansionTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(137, 108, 254, 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                section.icon,
                color: MyColors.purple,
                size: 24,
              ),
            ),
            title: Text(
              section.title,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.grey[900]!,
                      Colors.grey[850]!,
                    ],
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                  top: 8,
                ),
                child: Text(
                  section.content,
                  style: GoogleFonts.montserrat(
                    color: Colors.grey[300],
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PolicySection {
  final String title;
  final String content;
  final IconData icon;

  PolicySection({
    required this.title,
    required this.content,
    required this.icon,
  });
}
