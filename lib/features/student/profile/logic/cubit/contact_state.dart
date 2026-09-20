part of 'contact_cubit.dart';

sealed class ContactState {
  const ContactState();
}

final class ContactInitial extends ContactState {
  const ContactInitial();
}

final class ContactSending extends ContactState {
  const ContactSending();
}

final class ContactSent extends ContactState {
  const ContactSent();
}

final class ContactFailure extends ContactState {
  const ContactFailure(this.kind, this.message);

  final FailureKind kind;
  final String message;
}
