import 'package:flutter/widgets.dart';
import 'package:responsive_framework/responsive_framework.dart';

double getResponsiveValue(BuildContext context, double baseValue) {
  final screenWidth = MediaQuery.of(context).size.width;

  // Define scaling factors for different screen widths
  // Adjust these values to suit your design preferences
  if (screenWidth < 600) {
    // Small screen size
    return baseValue * 0.8;
  } else if (screenWidth >= 600 && screenWidth < 1920) {
    // Medium screen size
    return baseValue;
  } else {
    // Large screen size
    return baseValue * 1.2;
  }
}

class ResponsiveView extends StatelessWidget {
  const ResponsiveView({
    required this.mobile,
    super.key,
    this.desktop,
    this.tablet,
  });

  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).isTablet) {
      return tablet ??
          mobile ??
          const Center(
            child: Text('Tablet View'),
          );
    } else if (ResponsiveBreakpoints.of(context).isDesktop) {
      return desktop ?? tablet ?? const Center(child: Text('Desktop View'));
    } else {
      return mobile ??
          const Center(
            child: Text('Mobile View'),
          );
    }
  }
}
