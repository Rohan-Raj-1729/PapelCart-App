class UserInfo {
  late String email;
  late int type; // 0 - user, 1 - manager
  UserInfo(String email, int type) {
    this.email = email;
    this.type = type;
  }
}

UserInfo globalSessionData = new UserInfo("", 0);

//Having a clear function is pretty handy
void clearSessionData() {
  globalSessionData = new UserInfo("", 0);
}
