class AuthLoginResponse {
  AuthLoginResponse({
    required this.access,
    required this.refresh,
    required this.role,
    required this.approvalStatus,
  });

  final String access;
  final String refresh;
  final String role;
  final String approvalStatus;

  factory AuthLoginResponse.fromJson(Map<String, dynamic> json) {
    return AuthLoginResponse(
      access: json['access']?.toString() ?? '',
      refresh: json['refresh']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      approvalStatus: json['approval_status']?.toString() ?? '',
    );
  }
}
