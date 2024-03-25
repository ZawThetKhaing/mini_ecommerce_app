import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NotificationIcon extends StatelessWidget {
  final int? notiLength;
  const NotificationIcon({
    super.key,
    this.notiLength,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Stack(
        children: [
          const PhosphorIcon(
            PhosphorIconsRegular.bell,
          ),
          notiLength != null
              ? Positioned(
                  right: 1,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 6.5,
                    child: Text(
                      textAlign: TextAlign.center,
                      notiLength! >= 10 ? "9+" : notiLength.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.white, fontSize: 9),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
