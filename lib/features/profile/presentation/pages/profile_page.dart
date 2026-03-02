import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_orders_app/features/auth/presentation/stores/auth_store.dart';
import 'package:service_orders_app/features/profile/presentation/widget/profile_button_options_widget.dart';
import 'package:service_orders_app/shared/theme/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const SizedBox(height: 24),

          Stack(
            children: [
              CircleAvatar(
                radius: 55,
                backgroundImage: const NetworkImage(
                  'https://media.licdn.com/dms/image/v2/D4D03AQFJ1zA7p3Jc4g/profile-displayphoto-shrink_800_800/B4DZODdNa7HUAc-/0/1733077294633?e=1773878400&v=beta&t=VD0Mp4vvsCDO6J_TCF9esrOrtsqPTe940x6ouT2pjG4', // 👈 link da imagem
                ),
                backgroundColor: Colors.grey.shade200,
              ),
              Positioned(
                bottom: 0,
                right: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            authStore.user!.userName,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          const Text(
            "Técnico de Manutenção Sênior",
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: const [
                  ProfileButtonOptionsWidget(
                    icon: Icons.manage_accounts_outlined,
                    title: "Configurações da conta",
                  ),
                  Divider(height: 1),

                  ProfileButtonOptionsWidget(
                    icon: Icons.notifications_none,
                    title: "Notificações",
                  ),
                  Divider(height: 1),
                  ProfileButtonOptionsWidget(
                    icon: Icons.help_outline,
                    title: "Central de Ajuda",
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout, color: Colors.red),
                label: Text(
                  "Sair",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                onPressed: () async => {await authStore.logOut()},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 233, 237, 240),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
