import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessage() {
    final messages = [
      "Waiting for data...",
      "Please wait...",
      "Loading popular movies...",
      "Loading now playing movies...",
      "Loading upcoming movies...",
      "Loading top rated movies...",
      "This is taking a long time...",
    ];

    return Stream.periodic(
      const Duration(milliseconds: 1200),
      (i) => messages[i],
    ).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Waiting for data..."),

          const SizedBox(height: 8),

          const CircularProgressIndicator(strokeWidth: 2),

          const SizedBox(height: 8),

          StreamBuilder(
            stream: getLoadingMessage(),
            builder: (context, snapshot) {
              return Text(snapshot.data ?? "Loading...");
            },
          ),
        ],
      ),
    );
  }
}
