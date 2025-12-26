import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Purchases.setLogLevel(LogLevel.debug);
  if (Platform.isAndroid) {
    await Purchases.configure(PurchasesConfiguration(""));
  }

  runApp(const ProviderScope(child: MainApp()));
}

void showPaywall(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Permite que el modal use más espacio
    backgroundColor:
        Colors.transparent, // Para bordes redondeados personalizados
    builder: (context) => const CustomPaywallModal(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp.router(
    //   routerConfig: appRouter,
    //   theme: AppTheme().getTheme(context),
    //   debugShowCheckedModeBanner: false,
    // );

    return MaterialApp(home: MyWidget(), debugShowCheckedModeBanner: false);
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: () => showPaywall(context),
          child: const Text("Subscribe"),
        ),
      ),
    );
  }
}

class CustomPaywallModal extends StatefulWidget {
  const CustomPaywallModal({super.key});

  @override
  State<CustomPaywallModal> createState() => _CustomPaywallModalState();
}

class _CustomPaywallModalState extends State<CustomPaywallModal> {
  Offering? _currentOffering;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOfferings();
  }

  Future<void> _loadOfferings() async {
    try {
      Offerings offerings = await Purchases.getOfferings();

      final specificOffering = offerings.all["default"];

      if (specificOffering != null) {
        setState(() {
          _currentOffering = specificOffering;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error loading offerings: $e");
      setState(() => _isLoading = false);
    }
  }

  Future<void> _purchase(Package package) async {
    try {
      final PurchaseParams params = PurchaseParams.package(package);
      final purchaseResult = await Purchases.purchase(params);
      if (purchaseResult.customerInfo.entitlements.all["premium"]?.isActive ??
          false) {
        if (mounted) Navigator.pop(context);
      }
    } catch (e) {
      debugPrint("Error en la compra: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        height: 300,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_currentOffering == null) {
      return const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text("There are no offerings available"),
      );
    }

    final dynamicImageUrl =
        (_currentOffering!.metadata["image_url"] as String?) ??
        "https://upload.wikimedia.org/wikipedia/commons/c/c0/SoaD-2013-2.jpg";
    final package = _currentOffering!.monthly;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF121212), // Fondo oscuro para Cinemapedia
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 5,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          AspectRatio(
            aspectRatio: 16 / 9,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  dynamicImageUrl,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.white24,
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            child: Column(
              children: [
                Text(
                  package!.storeProduct.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Access to all the content for only ${package.storeProduct.priceString}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () => _purchase(package),
                  child: const Text(
                    "SUBSCRIBE NOW",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Maybe later",
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
