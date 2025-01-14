import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vasd/bloc/auth/auth_bloc.dart';
import 'package:vasd/ui/widgets/photo_container.dart';

class AvatarContainer extends StatelessWidget {
  const AvatarContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var photoUrl = context.read<AuthBloc>().authRepo.user?.photoUrl;

      if (photoUrl != null) {
        return CachedNetworkImage(
          imageUrl: photoUrl,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          imageBuilder: (context, imageProvider) =>
              PhotoContainer(imageProvider: imageProvider),
        );
      } else {
        return const PhotoContainer(
            imageProvider: AssetImage("assets/images/guest.png"));
      }
    });
  }
}
