import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:service_orders_app/features/auth/data/model/login_model.dart';
import 'package:service_orders_app/features/auth/presentation/pages/sign_up_dart.dart';
import 'package:service_orders_app/features/auth/presentation/stores/auth_store.dart';
import 'package:service_orders_app/features/home/presentation/pages/home_page.dart';
import 'package:service_orders_app/shared/theme/app_colors.dart';
import 'package:service_orders_app/shared/widgets/button_widget.dart';
import 'package:service_orders_app/shared/widgets/show_app_snack_bar_message.dart';
import 'package:service_orders_app/shared/widgets/textForm_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _inputUserNameController = TextEditingController();
  final _inputPasswordController = TextEditingController();

  bool rememberMe = false;
  bool obscure = true;

  void _realTimeValidation(String? value) {
    _formKey.currentState!.validate();
    setState(() {});
  }

  void _handleLogin(BuildContext context) async {
    final AuthStore authStore = Provider.of<AuthStore>(context, listen: false);

    LoginModel dataLogin = LoginModel(
      username: _inputUserNameController.text.trim(),
      password: _inputPasswordController.text.trim(),
    );

    try {
      final response = await authStore.login(dataLogin);

      if (response != null) {
        showAppSnackBarMessage(
          context,
          "Login realizado com sucesso!",
          ShowAppSnackBarMessageType.success,
        );
      } else {
        showAppSnackBarMessage(
          context,
          "Usuário ou senha incorretos!",
          ShowAppSnackBarMessageType.error,
        );
      }
    } catch (e) {
      showAppSnackBarMessage(
        context,
        "Ocorreu um erro inesperado. Tente novamente mais tarde.",
        ShowAppSnackBarMessageType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(blurRadius: 20, color: Colors.black12),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F0FE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.engineering,
                          size: 40,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Ordems de Serviços",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Tenha acesso a todos os seus serviços que precisam ser realizados",
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormFieldWidget(
                              controller: _inputUserNameController,
                              labelText: 'Nome de Usuário',
                              hintText: 'Insira o seu nome de usuário',
                              prefixIcon: Icons.person_2_outlined,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Insira o seu nome de usuário';
                                }

                                return null;
                              },
                              onChanged: _realTimeValidation,
                            ),

                            const SizedBox(height: 24),

                            TextFormFieldWidget(
                              controller: _inputPasswordController,
                              labelText: 'Senha',
                              hintText: 'Insira a senha',
                              prefixIcon: Icons.lock_outline,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Insira a senha';
                                }
                                return null;
                              },
                              onChanged: _realTimeValidation,
                            ),

                            const SizedBox(height: 8),

                            Row(
                              children: [
                                Checkbox(
                                  value: rememberMe,
                                  onChanged: (value) {
                                    setState(() => rememberMe = value!);
                                  },
                                ),
                                const Text("Lembrar de mim"),
                              ],
                            ),

                            const SizedBox(height: 16),

                            Observer(
                              builder: (_) {
                                return ButtonWidget(
                                  title: "Entrar",
                                  icon: Icons.login,
                                  type: ButtonWidgetType.primary,
                                  isLoading: authStore.isLoading,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _handleLogin(context);
                                    }
                                  },
                                );
                              },
                            ),

                            const SizedBox(height: 20),

                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Não tem uma conta? ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const SignUpPage(),
                                        ),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      'Criar conta',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  "Suporte Técnico: 0800 123 4567",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/login_footer.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
