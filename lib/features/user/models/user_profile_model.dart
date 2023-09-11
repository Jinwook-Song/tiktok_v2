class UserProfileModel {
  final String uid, email, name, bio, link;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.bio,
    required this.link,
  });

  UserProfileModel.empty()
      : uid = '',
        email = '',
        name = '',
        bio = '',
        link = '';

  Map<String, String> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'bio': bio,
      'link': link,
    };
  }
}
