import 'package:flutter/material.dart';
import 'package:sri_cuisine/components/user_info_tile.dart';
import 'package:sri_cuisine/pages/updateprofilepage.dart';
import 'package:sri_cuisine/pages/welcomepage.dart';
import 'package:sri_cuisine/services/UserApi.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person),
              SizedBox(width: 10),
              Text('Profile')
            ]),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: 130,
                height: 130,
                child: ClipRect(
                  child: Image.asset('assets/images/profile.jpg'),
                ),
              ),
              const SizedBox(height: 20),
              Text(UserApi.user.userName.toString(),
                  style: const TextStyle(
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 25)),
              Text(UserApi.user.email.toString(),
                  style: const TextStyle(
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 15)),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UpdateProfilePage()),
                    );
                  },
                  child: const Text('Edit Profile'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),

              UserInfoTile(
                  label: "Height", value: UserApi.user.height.toString()),
              UserInfoTile(
                  label: "Weight", value: UserApi.user.weight.toString()),
              // UserInfoTile(label: "Gender", value: "Male"),
              UserInfoTile(label: "Age", value: UserApi.user.age.toString()),
              UserInfoTile(
                  label: "Allergies", value: UserApi.user.allergens.toString()),
              ProfileMenuWidget(
                title: "Logout",
                icon: Icons.logout_sharp,
                onPress: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomePage()),
                    (Route<dynamic> route) => false,
                  );
                },
                endIcon: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    required this.endIcon,
    this.textColor,
  });
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.yellow[100],
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(Icons.person, color: Colors.black),
      ),
      title: Text(
        title,
        style: const TextStyle(),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.black),
            )
          : null,
    );
  }
}
