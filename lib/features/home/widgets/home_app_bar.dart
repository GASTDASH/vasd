import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vasd/bloc/auth/auth_bloc.dart';
import 'package:vasd/ui/widgets/avatar_container.dart';

class HomeAppBar extends StatelessWidget implements PreferredSize {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PreferredSize(
      preferredSize: preferredSize,
      child: Ink(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {},
                child: Ink(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      "assets/icons/map_marker.svg",
                      colorFilter:
                          ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width - 170,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Ваше местоположение"),
                    SizedBox(
                      child: Text(
                        "Орехово-Зуево, Московская обл.",
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox.expand()),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.pushNamed(context, "/profile");
                },
                child: Ink(
                  height: 50,
                  width: 50,
                  child: Hero(
                    tag: "avatar",
                    child: AvatarContainer(
                      photoUrl:
                          context.read<AuthBloc>().authRepo.user!.photoUrl,
                      margin: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget get child => const SizedBox.shrink();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
