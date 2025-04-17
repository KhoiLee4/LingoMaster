import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingo_master/src/ui/features/auth/bloc/signup/signup_event.dart';
import 'package:lingo_master/src/ui/features/auth/bloc/signup/sigup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInit()) {
    on<SignupSubmitted>((event, emit) => _submit(event, emit));
  }

  _submit(SignupSubmitted event, Emitter emit) async {
    final birthday = event.birthday;
    final email = event.email;
    final password = event.password;

// Kiểm tra tuổi (trên 5 tuổi)
    final now = DateTime.now();
    final age = now.year -
        birthday!.year -
        ((now.month < birthday.month ||
                (now.month == birthday.month && now.day < birthday.day))
            ? 1
            : 0);

    if (age < 5) {
      emit(SignupFailure('Tuổi phải lớn hơn 5'));
      return;
    }

// Kiểm tra định dạng email
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(email)) {
      emit(SignupFailure('Email không hợp lệ'));
      return;
    }

// Kiểm tra mật khẩu phức tạp
    final passwordRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{3,15}$');
    if (!passwordRegex.hasMatch(password)) {
      emit(SignupFailure(
          'Mật khẩu phải từ 3-15 ký tự, có chữ hoa, thường, số và ký tự đặc biệt'));
      return;
    }

    emit(SignupLoading());
    await Future.delayed(const Duration(seconds: 2));
    emit(SignupSuccess());
  }
}
