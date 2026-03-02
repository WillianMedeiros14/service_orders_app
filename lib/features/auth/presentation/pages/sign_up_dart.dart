import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:service_orders_app/features/auth/data/model/signUp_model.dart';
import 'package:service_orders_app/features/auth/presentation/stores/auth_store.dart';
import 'package:service_orders_app/features/home/presentation/pages/home_page.dart';
import 'package:service_orders_app/shared/theme/app_colors.dart';
import 'package:service_orders_app/shared/widgets/button_widget.dart';
import 'package:service_orders_app/shared/widgets/header_widget.dart';
import 'package:service_orders_app/shared/widgets/show_app_snack_bar_message.dart';
import 'package:service_orders_app/shared/widgets/textForm_field_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _inputUserNameController = TextEditingController();
  final _inputEmailController = TextEditingController();
  final _inputPasswordController = TextEditingController();
  final _inputPasswordConfirmationController = TextEditingController();

  void _realTimeValidation(String? value) {
    _formKey.currentState!.validate();
    setState(() {});
  }

  void _handleSignUp(BuildContext context) async {
    final AuthStore authStore = Provider.of<AuthStore>(context, listen: false);

    SignUpModel dataSignUp = SignUpModel(
      username: _inputUserNameController.text,
      email: _inputEmailController.text,
      password: _inputPasswordController.text,
      rePassword: _inputPasswordConfirmationController.text,
    );

    try {
      final response = await authStore.signUp(dataSignUp);

      if (response != null) {
        showAppSnackBarMessage(
          context,
          "Cadastro criado com sucesso!",
          ShowAppSnackBarMessageType.success,
        );

        await Future.delayed(const Duration(seconds: 1));
        Navigator.of(context).pop();
      } else {
        showAppSnackBarMessage(
          context,
          "Erro ao criar cadastro",
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
    final AuthStore authStore = Provider.of<AuthStore>(context, listen: false);

    return Scaffold(
      appBar: HeaderWidget(showBackButton: true),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/signup_image_initial.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),

                Center(
                  child: const Text(
                    "Criar Conta",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Tenha acesso a todas as suas ordems de serviços que precisam ser realizados",
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),

                TextFormFieldWidget(
                  controller: _inputUserNameController,
                  prefixIcon: Icons.person_2_outlined,
                  labelText: 'Nome de usuário (obs: sem espaço)',
                  hintText: 'Insira seu nome de usuário',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira o seu nome';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    String newValue = (value ?? "").replaceAll(' ', '');
                    if (newValue != value) {
                      _inputUserNameController.text = newValue;
                      _inputUserNameController.selection =
                          TextSelection.fromPosition(
                            TextPosition(offset: newValue.length),
                          );
                    }
                    _realTimeValidation(newValue);
                  },
                ),

                const SizedBox(height: 16),

                TextFormFieldWidget(
                  controller: _inputEmailController,
                  prefixIcon: Icons.email_outlined,
                  labelText: 'E-mail',
                  hintText: 'Insira o e-mail',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira o e-mail';
                    }

                    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegExp.hasMatch(value)) {
                      return 'Insira um e-mail válido';
                    }
                    return null;
                  },
                  onChanged: _realTimeValidation,
                ),

                const SizedBox(height: 16),

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

                const SizedBox(height: 16),

                TextFormFieldWidget(
                  controller: _inputPasswordConfirmationController,
                  labelText: 'Confirme a senha',
                  hintText: 'Confirme a senha',
                  prefixIcon: Icons.lock_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirme a senha';
                    }
                    return null;
                  },
                  onChanged: _realTimeValidation,
                ),

                const SizedBox(height: 24),

                Observer(
                  builder: (_) {
                    return ButtonWidget(
                      title: "Cadastrar",
                      icon: Icons.login,
                      type: ButtonWidgetType.primary,
                      isLoading: authStore.isLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _handleSignUp(context);
                        }
                      },
                    );
                  },
                ),

                const SizedBox(height: 40),

                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Não tem uma conta? ',
                        style: TextStyle(color: Colors.black, fontSize: 15),
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
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Entre',
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
        ),
      ),
    );
  }
}
