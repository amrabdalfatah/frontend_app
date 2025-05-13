import 'package:fashion_app/models/user.dart';
import 'package:fashion_app/providers/auth_provider.dart';
import 'package:fashion_app/screens/chat/chat_screen.dart';
import 'package:fashion_app/screens/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: Text('AI Fashion Stylist'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => context.read<AuthProvider>().logout(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserHeader(user),
            SizedBox(height: 20),
            _buildActionCard(
              icon: Icons.chat,
              title: 'Chat with Stylist',
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ChatScreen()),
                  ),
            ),
            _buildActionCard(
              icon: Icons.person,
              title: 'Edit Profile',
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditProfileScreen()),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserHeader(Customer? customer) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage:
                  customer?.photoUrl != null
                      ? NetworkImage(customer!.photoUrl!)
                      : AssetImage('assets/default_avatar.png')
                          as ImageProvider,
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer?.name ?? 'Guest',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Skin Tone: ${customer?.skinTone ?? 'Not set'}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 30),
              SizedBox(width: 16),
              Text(title, style: TextStyle(fontSize: 16)),
              Spacer(),
              Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
