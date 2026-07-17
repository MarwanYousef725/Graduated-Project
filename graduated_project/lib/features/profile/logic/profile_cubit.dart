import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void loadProfile() async {
    emit(ProfileLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(
      ProfileLoaded(
        name: 'oohnathan Doe',
        phone: '+1 (555) 000-1234',
        gender: 'Male',
        dob: 'Jan 15, 1995',
        notificationCount: 3,
      ),
    );
  }

  void updatePersonalInfo({
    required String name,
    required String phone,
    required String gender,
    required String dob,
  }) async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      emit(ProfileLoading());
      FirebaseAuth.instance.currentUser!.updateProfile(
        displayName: name,
        photoURL: currentState.profileImage,
      );
      emit(
        ProfileLoaded(
          name: name,
          phone: phone,
          gender: gender,
          dob: dob,
          notificationCount: currentState.notificationCount,
          profileImage: currentState.profileImage,
        ),
      );
    }
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> updateProfileImage() async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        emit(
          ProfileLoaded(
            name: FirebaseAuth.instance.currentUser!.displayName ?? '',
            phone: currentState.phone,
            gender: currentState.gender,
            dob: currentState.dob,
            notificationCount: currentState.notificationCount,
            profileImage: image.path,
          ),
        );
      }
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
  }
}
