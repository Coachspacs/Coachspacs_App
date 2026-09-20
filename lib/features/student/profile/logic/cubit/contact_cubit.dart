import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/repo/support_repository.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit(SupportRepository repository)
      : _repository = repository,
        super(const ContactInitial());

  final SupportRepository _repository;

  Future<bool> send({
    required String message,
    required String subject,
    required String category,
  }) async {
    emit(const ContactSending());
    try {
      await _repository.sendContactMessage(
        message: message,
        subject: subject,
        category: category,
      );
      emit(const ContactSent());
      return true;
    } on NetworkException catch (error) {
      emit(ContactFailure(error.kind, error.message));
      return false;
    } catch (_) {
      emit(const ContactFailure(FailureKind.unknown, _fallbackMessage));
      return false;
    }
  }
}

const String _fallbackMessage = 'حدث خطأ، حاول مرة أخرى';
