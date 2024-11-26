import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase=Supabase.instance.client;

  //sign with email and password
  Future<AuthResponse> signInwithEmailPassword(String email, String password)async {
    return await _supabase.auth.signInWithPassword(password:password ,email: email);
  }

  //sigUp with email and password
  Future<AuthResponse> signUpwithEmailPassword(String email,String password)async {
    return await _supabase.auth.signUp(password: password,email: email);
  }

  //sigout 
  Future<void>signOut()async {
    await _supabase.auth.signOut();
  }

  //get useremail
String? getcurrentUserEmail() {
  final session = _supabase.auth.currentUser;
  return session?.email;
}

}