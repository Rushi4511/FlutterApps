import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum SnackbarType { success, error, info }

class CustomSnackbar {
  static void showCustomSnackbar({
    required String message,
    required BuildContext context,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 1),
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      duration: duration,
      content: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _getGradientColors(type),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _getGradientColors(type)[0].withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            _getIcon(type),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getTitle(type),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      dismissDirection: DismissDirection.horizontal,
      animation: CurvedAnimation(
        parent: const AlwaysStoppedAnimation(1),
        curve: Curves.easeOutCirc,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static List<Color> _getGradientColors(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return [
          const Color(0xFF00B09B),
          const Color(0xFF96C93D),
        ];
      case SnackbarType.error:
        return [
          const Color(0xFFFF416C),
          const Color(0xFFFF4B2B),
        ];
      case SnackbarType.info:
        return [
          const Color(0xFF896CFE),
          const Color(0xFF6C63FF),
        ];
    }
  }

  static Widget _getIcon(SnackbarType type) {
    IconData iconData;
    switch (type) {
      case SnackbarType.success:
        iconData = Icons.check_circle_outline;
        break;
      case SnackbarType.error:
        iconData = Icons.error_outline;
        break;
      case SnackbarType.info:
        iconData = Icons.info_outline;
        break;
    }

    return Icon(
      iconData,
      color: Colors.white,
      size: 28,
    );
  }

  static String _getTitle(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return 'Success';
      case SnackbarType.error:
        return 'Error';
      case SnackbarType.info:
        return 'Information';
    }
  }
}