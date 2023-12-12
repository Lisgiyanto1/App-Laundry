import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryapp/config/app_assets.dart';
import 'package:laundryapp/config/app_color.dart';
import 'package:laundryapp/config/app_session.dart';
import 'package:laundryapp/config/nav.dart';
import 'package:laundryapp/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:laundryapp/pages/auth/login_page.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  logout(BuildContext context) {
    DInfo.dialogConfirmation(
      context,
      'Logout',
      'Are you sure want to logout?',
      textNo: 'Cancel',
    ).then((yes) {
      if (yes ?? false) {
        AppSession.removeUser();
        AppSession.removeBearerToken();
        Nav.replace(context, const LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppSession.getUser(),
      builder: (context, snapshot) {
        if (snapshot.data == null) return DView.loadingCircle();
        UserModel user = snapshot.data!;
        return ListView(
          padding: const EdgeInsets.all(0),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
              child: Text(
                'Account',
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 70,
                    child: AspectRatio(
                      aspectRatio: 3 / 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          AppAssets.profile,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  DView.spaceWidth(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Username',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DView.spaceHeight(4),
                        Text(
                          user.username,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                        DView.spaceHeight(12),
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DView.spaceHeight(4),
                        Text(
                          user.email,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            DView.spaceHeight(10),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              onTap: () {},
              dense: true,
              horizontalTitleGap: 0,
              leading: const Icon(Icons.image),
              title: const Text('Change Profile'),
              trailing: const Icon(Icons.navigate_next),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              onTap: () {},
              dense: true,
              horizontalTitleGap: 0,
              leading: const Icon(Icons.edit),
              title: const Text('Edit Account'),
              trailing: const Icon(Icons.navigate_next),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: OutlinedButton(
                onPressed: () => logout(context),
                child: const Text('Logout'),
              ),
            ),
            DView.spaceHeight(30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Settings',
                style: TextStyle(
                  height: 1,
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              onTap: () {},
              dense: true,
              horizontalTitleGap: 0,
              leading: const Icon(Icons.dark_mode),
              title: const Text('Dark Mode'),
              trailing: Switch(
                activeColor: AppColors.primary,
                value: false,
                onChanged: (value) {},
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              onTap: () {},
              dense: true,
              horizontalTitleGap: 0,
              leading: const Icon(Icons.translate),
              title: const Text('Language'),
              trailing: const Icon(Icons.navigate_next),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              onTap: () {},
              dense: true,
              horizontalTitleGap: 0,
              leading: const Icon(Icons.feedback),
              title: const Text('Feedback'),
              trailing: const Icon(Icons.navigate_next),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              onTap: () {},
              dense: true,
              horizontalTitleGap: 0,
              leading: const Icon(Icons.support_agent),
              title: const Text('Support'),
              trailing: const Icon(Icons.navigate_next),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationIcon: const Icon(
                    Icons.local_laundry_service,
                    size: 50,
                    color: AppColors.primary,
                  ),
                  applicationName: 'Laundry App',
                  applicationVersion: 'v1.0.0',
                  children: [
                    const Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Aplikasi ini dibuat untuk memudahkan pengguna dalam melakukan transaksi laundry secara online.',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                );
              },
              dense: true,
              horizontalTitleGap: 0,
              leading: const Icon(Icons.info),
              title: const Text('About'),
              trailing: const Icon(Icons.navigate_next),
            ),
          ],
        );
      },
    );
  }
}
