import 'package:delivery_app/pages/home_page.dart';
import 'package:delivery_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGet extends StatelessWidget {
  const AuthGet({super.key});
  
  get onTap => null;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
     
      builder: ( context,  snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){ 
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(),),
          );
        }
        final Session=snapshot.hasData?snapshot.data!.session:null;
        if(Session!=null){
          return HomePage();
        }else{
          return LoginPage(onTap: onTap);
        }
      },
    );
  }
}