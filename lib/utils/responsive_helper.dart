class ResponsiveHelper {
  // Standard breakpoints
  static const double mobileBreakpoint = 768;
  static const double tabletBreakpoint = 1024;
  static const double desktopBreakpoint = 1200;
  
  // Check device types
  static bool isMobile(double width) => width < mobileBreakpoint;
  static bool isTablet(double width) => width >= mobileBreakpoint && width < tabletBreakpoint;
  static bool isDesktop(double width) => width >= tabletBreakpoint;
  
  // Get responsive values
  static T getResponsiveValue<T>({
    required double screenWidth,
    required T mobile,
    required T tablet,
    required T desktop,
  }) {
    if (isMobile(screenWidth)) return mobile;
    if (isTablet(screenWidth)) return tablet;
    return desktop;
  }
  
  // Get responsive padding
  static double getHorizontalPadding(double screenWidth) {
    return getResponsiveValue(
      screenWidth: screenWidth,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );
  }
  
  // Get responsive font sizes
  static double getHeadingSize(double screenWidth, {double baseSize = 48}) {
    return getResponsiveValue(
      screenWidth: screenWidth,
      mobile: baseSize * 0.7,
      tablet: baseSize * 0.85,
      desktop: baseSize,
    );
  }
  
  static double getBodySize(double screenWidth, {double baseSize = 16}) {
    return getResponsiveValue(
      screenWidth: screenWidth,
      mobile: baseSize * 0.9,
      tablet: baseSize * 0.95,
      desktop: baseSize,
    );
  }
  
  static double getVerticalPadding(double screenWidth) {
    return getResponsiveValue(
      screenWidth: screenWidth,
      mobile: 12.0,
      tablet: 16.0,
      desktop: 20.0,
    );
  }
  
  // Get responsive spacing
  static double getVerticalSpacing(double screenWidth, {double baseSpacing = 80}) {
    return getResponsiveValue(
      screenWidth: screenWidth,
      mobile: baseSpacing * 0.6,
      tablet: baseSpacing * 0.8,
      desktop: baseSpacing,
    );
  }
  
  // Get responsive container constraints
  static double getMaxWidth(double screenWidth) {
    return getResponsiveValue(
      screenWidth: screenWidth,
      mobile: screenWidth,
      tablet: 900.0,
      desktop: 1200.0,
    );
  }
  
  // Get responsive grid columns
  static int getGridColumns(double screenWidth) {
    return getResponsiveValue(
      screenWidth: screenWidth,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );
  }
  
  // Get responsive aspect ratio
  static double getCardAspectRatio(double screenWidth) {
    return getResponsiveValue(
      screenWidth: screenWidth,
      mobile: 1.2,
      tablet: 1.3,
      desktop: 1.4,
    );
  }
}