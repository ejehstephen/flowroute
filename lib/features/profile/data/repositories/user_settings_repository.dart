import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_settings_model.dart';

class UserSettingsRepository {
  final SupabaseClient _supabase = Supabase.instance.client;
  static const String _cacheKey = 'user_settings_cache';

  Future<UserSettingsModel?> getSettings(String userId) async {
    // Try to get from cache first
    final cachedSettings = await _getCachedSettings(userId);
    if (cachedSettings != null) {
      // Return cached data immediately, but fetch fresh data in background
      _fetchAndCacheSettings(userId);
      return cachedSettings;
    }

    // If no cache, fetch from Supabase
    return await _fetchAndCacheSettings(userId);
  }

  Future<UserSettingsModel?> _fetchAndCacheSettings(String userId) async {
    try {
      final data = await _supabase
          .from('user_settings')
          .select()
          .eq('user_id', userId)
          .single();
      final settings = UserSettingsModel.fromJson(data);

      // Cache the settings
      await _cacheSettings(settings);

      return settings;
    } catch (e) {
      return null;
    }
  }

  Future<UserSettingsModel?> _getCachedSettings(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedJson = prefs.getString('${_cacheKey}_$userId');
      if (cachedJson != null) {
        final json = jsonDecode(cachedJson);
        return UserSettingsModel.fromJson(json);
      }
    } catch (e) {
      // Ignore cache errors
    }
    return null;
  }

  Future<void> _cacheSettings(UserSettingsModel settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(settings.toJson());
      await prefs.setString('${_cacheKey}_${settings.userId}', jsonString);
    } catch (e) {
      // Ignore cache errors
    }
  }

  Future<void> updateSettings(UserSettingsModel settings) async {
    // Save to cache immediately (optimistic update)
    await _cacheSettings(settings);

    // Then sync to Supabase in background
    try {
      await _supabase.from('user_settings').upsert(settings.toJson());
    } catch (e) {
      // If sync fails, we still have the cached version
      // Could implement retry logic here
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
}
