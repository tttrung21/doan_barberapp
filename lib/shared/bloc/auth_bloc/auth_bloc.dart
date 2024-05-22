import 'package:doan_barberapp/shared/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/AuthRepository.dart';
import '../../repository/UserRepository.dart';
import 'auth_helper.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  AuthBloc({required this.authRepository, required this.userRepository}) : super(AuthInitial()) {
    on<AuthStartedEvent>(_onInit);
    on<GuestLoginEvent>(_onGuest);
    on<SignInRequestedEvent>(_onSignIn);
    on<SignUpRequestedEvent>(_onSignUp);
    on<LogOutRequestedEvent>(_onLogOut);
  }

  void _onInit(AuthStartedEvent event, Emitter<AuthState> emit) async {
    final bool auth = await isAuth();
    print('auth: $auth');
    if (!auth) {
      emit(UnauthenticatedState());
    } else {
      state.profile = await userRepository.fetchUser();
      emit(AuthSuccess(user: state.profile));
    }
  }

  void _onGuest(GuestLoginEvent event, Emitter<AuthState> emit) async {
    await authRepository.guestMode();
    emit(UnauthenticatedState());
    emit(AuthSuccess(user: state.profile));
  }

  Future<void> _onSignIn(
      SignInRequestedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      User? user = await authRepository
          .signIn(email:event.email,password:event.password);
      if(user != null){
        state.profile = await userRepository.fetchUser();
        emit(AuthSuccess(user: state.profile,message: 'Authentication success!'));
        setAuth(true);
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
  Future<void> _onSignUp(SignUpRequestedEvent event,
      Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      User? user = await authRepository.signUp(
          email: event.email, password: event.password);
      if (user != null) {
        emit(AuthSuccess());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  void _onLogOut(LogOutRequestedEvent event, Emitter<AuthState> emit) async{
    emit(AuthLoadingState());
    try{
      await authRepository.logOut();
      emit(UnauthenticatedState());
      setAuth(false);
    }
    on FirebaseAuthException catch(e){
      emit(AuthError(message: e.toString()));
    }
  }
}
