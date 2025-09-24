import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AppUpdatePage extends StatelessWidget {
  final String currentVersion;
  final String requiredVersion;

  const AppUpdatePage({
    super.key,
    required this.currentVersion,
    required this.requiredVersion,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.system_update, size: 80, color: Colors.orange[800]),
              const SizedBox(height: 24),
              Text(
                'Update Required',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(color: Colors.orange[900]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Your app version ($currentVersion) is outdated.\nPlease update to version $requiredVersion to continue.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  // Open Play Store / App Store (optional)
                },
                icon: const Icon(Icons.open_in_new),
                label: const Text('Update Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
