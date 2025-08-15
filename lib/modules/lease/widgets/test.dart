import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FullscreenLottieDialog extends StatefulWidget {
  const FullscreenLottieDialog(
      {super.key, required this.asset, required this.content});
  final String asset;
  final String content;

  @override
  State<FullscreenLottieDialog> createState() => _FullscreenLottieDialogState();
}

class _FullscreenLottieDialogState extends State<FullscreenLottieDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pop(); // Automatically close dialog
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.white,
      child: SizedBox.expand(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        widget.asset,
                        controller: _controller,
                        onLoaded: (composition) {
                          _controller.duration = composition.duration;
                          _controller.forward();
                        },
                        repeat: false,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.content,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
