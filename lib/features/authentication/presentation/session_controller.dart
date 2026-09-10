
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/features/authentication/domain/auth_state.dart';

class SessionController extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthStateUnknown(); 

  // TODO: Implement session restoration logic here.
}


final sessionControllerProvider =
    NotifierProvider<SessionController, AuthState>(SessionController.new);