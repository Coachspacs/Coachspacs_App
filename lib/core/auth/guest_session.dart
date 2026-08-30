class GuestSession {
  GuestSession._();

  static bool isGuest = false;

  static void continueAsGuest() {
    isGuest = true;
  }

  static void login() {
    isGuest = false;
  }

  static void logout() {
    isGuest = false;
  }
}