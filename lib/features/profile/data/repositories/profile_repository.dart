import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile_model.dart';

class ProfileRepository {
  final SupabaseClient _supabase = Supabase.instance.client;
  static const String _cacheKey = 'user_profile_cache';

  Future<ProfileModel?> getProfile(String userId) async {
    // Try to get from cache first
    final cachedProfile = await _getCachedProfile(userId);
    if (cachedProfile != null) {
      // Return cached data immediately, but fetch fresh data in background
      _fetchAndCacheProfile(userId);
      return cachedProfile;
    }

    // If no cache, fetch from Supabase
    return await _fetchAndCacheProfile(userId);
  }

  Future<ProfileModel?> _fetchAndCacheProfile(String userId) async {
    try {
      final data = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      final profile = ProfileModel.fromJson(data);

      // Cache the profile
      await _cacheProfile(profile);

      return profile;
    } catch (e) {
      return null;
    }
  }

  Future<ProfileModel?> _getCachedProfile(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedJson = prefs.getString('${_cacheKey}_$userId');
      if (cachedJson != null) {
        final json = jsonDecode(cachedJson);
        return ProfileModel.fromJson(json);
      }
    } catch (e) {
      // Ignore cache errors
    }
    return null;
  }

  Future<void> _cacheProfile(ProfileModel profile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode({
        'id': profile.id,
        'username': profile.username,
        'avatar_url': profile.avatarUrl,
        'email': profile.email,
        'private_mode_enabled': profile.privateModeEnabled,
      });
      await prefs.setString('${_cacheKey}_${profile.id}', jsonString);
    } catch (e) {
      // Ignore cache errors
    }
  }

  Future<void> clearCache(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('${_cacheKey}_$userId');
    } catch (e) {
      // Ignore cache errors
    }
  }

  Future<void> updatePrivacyMode(String userId, bool enabled) async {
    await _supabase
        .from('profiles')
        .update({'private_mode_enabled': enabled})
        .eq('id', userId);

    // Clear cache to force refresh
    await clearCache(userId);
  }
}
