import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:team_hack/models/user_model.dart';

class SupaBaseDB {
  late final SupabaseClient supaBaseInstance;

  initializeSupa() async {
    await Supabase.initialize(
      url: dotenv.env['URL']!,
      anonKey: dotenv.env['KEY']!,
    );
  }

  bool isTokenExpired() {
    return Supabase.instance.client.auth.currentSession?.isExpired ?? true;
  }

  signOut() async {
    await Supabase.instance.client.auth.signOut();
  }

  login({required String email, required String password}) async {
    try {
      supaBaseInstance = Supabase.instance.client;

      final currentUser =
          await supaBaseInstance.auth.signInWithPassword(email: email, password: password);

      return "ok";
    } catch (err) {
      return err.toString();
    }
  }

  signUp({required String email, required String password, required String name}) async {
    try {
      supaBaseInstance = Supabase.instance.client;

      await supaBaseInstance.auth
          .signUp(
            email: email,
            password: password,
          )
          .then((value) async => await supaBaseInstance.from("users").upsert(
                {
                  "user_id": supaBaseInstance.auth.currentUser!.id,
                  "email": supaBaseInstance.auth.currentUser!.email,
                  "role": "",
                  "name": name,
                  "bio": "",
                  "skills": [],
                },
              ));

      return "ok";
    } on PostgrestException catch (err) {
      return err.message.toString();
    } catch (err) {
      return err.toString();
    }
  }

  Future<dynamic> getCurrentUser() async {
    try {
      final client = Supabase.instance.client;
      final user = await client.from("users").select().eq('user_id', client.auth.currentUser!.id);
      final userInfo = UserModel.fromJson(user.first);
      return userInfo;
    } catch (err) {
      return err;
    }
  }
}
