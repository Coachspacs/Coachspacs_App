import 'package:flutter/material.dart';

import 'package:coach_space/core/auth/guest_session.dart';
import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/models/user_profile_model.dart';
import 'package:coach_space/features/student/profile/data/repo/profile_repository.dart';

/// Circular avatar that lazily loads the signed-in user's profile
/// (`GET /api/users/me`) to show the uploaded `avatar` image or the initials
/// of the user's full name. Falls back to a neutral person glyph whenever the
/// user is a guest or the profile request fails, so it is safe to place in
/// any top bar.
class UserAvatar extends StatefulWidget {
  const UserAvatar({
    super.key,
    this.size = 34,
  });

  final double size;

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  UserProfileModel? _profile;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    if (GuestSession.isGuest) {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
      return;
    }

    try {
      final profile = await getIt<ProfileRepository>().getProfile();
      if (!mounted) return;
      setState(() {
        _profile = profile;
      });
    } on NetworkException {
      // Ignore: fall back to the neutral avatar.
    } catch (_) {
      // Ignore: fall back to the neutral avatar.
    }
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? avatarUrl = _profile?.avatar?.trim();
    final String fullName = (_profile?.fullName ?? '').trim();
    final String initials = _initials(fullName);

    if (!_loading && avatarUrl != null && avatarUrl.isNotEmpty) {
      return SizedBox(
        width: widget.size,
        height: widget.size,
        child: ClipOval(
          child: Image.network(
            avatarUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) =>
                _fallback(context, initials),
          ),
        ),
      );
    }

    return _fallback(context, initials);
  }

  Widget _fallback(BuildContext context, String initials) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: const BoxDecoration(
        color: Color(0xFFE4F5F0),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: initials.isNotEmpty
          ? Text(
              initials,
              style: TextStyle(
                fontSize: widget.size * 0.36,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF075E4D),
              ),
            )
          : Icon(
              Icons.person_outline_rounded,
              size: widget.size * 0.53,
              color: const Color(0xFF075E4D),
            ),
    );
  }

  static String _initials(String fullName) {
    final parts = fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '';
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'
        .toUpperCase();
  }
}