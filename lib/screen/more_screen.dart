import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salati/helper/functions.dart';
import 'package:salati/screen/about_screen.dart';

import '../providers/theme_provider.dart';
import 'widgets/settings_container.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Settings", style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SettingsContainer(
                    iconData: Provider.of<ThemeProvider>(context).isDarkMode
                        ? Icons.nightlight_round
                        : Icons.wb_sunny,
                    iconColor: Provider.of<ThemeProvider>(context).isDarkMode
                        ? Colors.deepPurple
                        : Colors.amber,
                    text: Provider.of<ThemeProvider>(context).isDarkMode
                        ? ('Darkmode')
                        : ('Light mode'),
                    additionalWidget: Switch(
                      value: Provider.of<ThemeProvider>(context).isDarkMode,
                      onChanged: (value) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () => navigateTo(context, const AboutScreen()),
                    child: SettingsContainer(
                      iconData: Icons.info,
                      iconColor: Theme.of(context).colorScheme.secondary,
                      text: 'About',
                      additionalWidget: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
