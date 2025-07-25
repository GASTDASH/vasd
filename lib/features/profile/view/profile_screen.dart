import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vasd/bloc/auth/auth_bloc.dart';
import 'package:vasd/ui/ui.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final emailController = TextEditingController();
  late final AuthBloc authBloc;

  @override
  void initState() {
    super.initState();

    authBloc = context.read<AuthBloc>();
    usernameController.text = authBloc.authRepo.user?.name ?? "";
    phoneController.text = authBloc.authRepo.user?.phone ?? "";
    emailController.text = authBloc.authRepo.user?.email ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const LoadingDialog(),
          );
        } else if (state is AuthChangedUserInfoState) {
          Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
        } else if (state is AuthAuthorizedState) {
          setState(() {});
        }
      },
      listenWhen: (previous, current) {
        if (previous is AuthLoadingState) {
          Navigator.pop(context);
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.chevron_left_rounded, size: 40),
            ),
            title: Text(
              "Профиль",
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            centerTitle: true,
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(18),
            child: ButtonBase(
              onTap: () {
                authBloc.add(AuthChangeUserInfo(username: usernameController.text, phone: phoneController.text));
              },
              text: "Сохранить",
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () async {
                          final bloc = context.read<AuthBloc>();

                          final picker = ImagePicker();
                          final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                          if (image == null) return;
                          final imageBytes = await image.readAsBytes();
                          bloc.add(
                            AuthUploadPhotoEvent(imageBytes: imageBytes),
                          );
                        },
                        child: Hero(
                          tag: "avatar",
                          child: Stack(
                            children: [
                              AvatarContainer(
                                photoUrl: authBloc.authRepo.user!.photoUrl,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: theme.primaryColor,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: const Icon(
                                    Icons.edit_outlined,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFieldCustom(
                    hintText: "Имя пользователя",
                    label: "Имя пользователя",
                    controller: usernameController,
                  ),
                  const SizedBox(height: 12),
                  IntlPhoneFieldCustom(
                    controller: phoneController,
                  ),
                  const SizedBox(height: 12),
                  TextFieldCustom(
                    hintText: "Email",
                    label: "Эл. почта",
                    enabled: false,
                    controller: emailController,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
