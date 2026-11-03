class AppData {
  static const String name = "Sreerag PS";
  static const String tagline = "Flutter Developer | Cross-Platform Engineer";
  static const String heroSubtitle =
      "I craft high-performance, responsive cross-platform applications with Flutter & Dart across Mobile, Web, Tablet, and Windows — backed by Clean Architecture, BLoC, GoRouter, RESTful APIs, Node.js, and offline-first persistence.";

  static const String aboutText =
      "I'm a dedicated Flutter Developer with over 3 years of professional experience building and scaling production-grade enterprise applications at Exaware Solutions Private Limited.\n\n"
      "My core expertise focuses on clean and testable architectures (Clean Architecture, MVVM), robust state management (BLoC, Cubit, GetX, Provider), responsive design across multi-factor screens (Mobile, Tablet, Web, Windows), declarative routing with GoRouter, and offline-first data persistence (Hive, SQLite).\n\n"
      "I have architected and deployed diverse enterprise solutions including real-time handheld warehouse management (PDA) applications, intelligent ATS resume and job-matching platforms with dynamic PDF compilation, machinery fitness inspection and certification systems, housing management modules, and modern financial expense trackers. On the backend, I seamlessly integrate with Node.js services, Oracle DB, and Firebase Cloud Firestore.\n\n"
      "Combined with an analytical mindset shaped by trading and financial markets, I engineer performant, reliable, and aesthetically refined digital experiences.";

  static const List<Map<String, String>> skills = [
    {'name': 'Flutter', 'icon': 'assets/fltr.png', 'level': '95'},
    {'name': 'Dart', 'icon': 'assets/Dart.png', 'level': '92'},
    {'name': 'BLoC / Cubit', 'icon': 'assets/fltr.png', 'level': '92'},
    {'name': 'Clean Architecture', 'icon': 'assets/defaultimage.webp', 'level': '90'},
    {'name': 'REST APIs', 'icon': 'assets/defaultimage.webp', 'level': '90'},
    {'name': 'GoRouter', 'icon': 'assets/fltr.png', 'level': '88'},
    {'name': 'Firebase & Firestore', 'icon': 'assets/defaultimage.webp', 'level': '85'},
    {'name': 'Node.js', 'icon': 'assets/nodejs1.png', 'level': '78'},
    {'name': 'Oracle DB & SQL', 'icon': 'assets/defaultimage.webp', 'level': '78'},
    {'name': 'Hive / Local Sync', 'icon': 'assets/defaultimage.webp', 'level': '85'},
    {'name': 'fl_chart & Analytics', 'icon': 'assets/defaultimage.webp', 'level': '88'},
    {'name': 'Cross-Platform UI', 'icon': 'assets/fltr.png', 'level': '92'},
    {'name': 'Git & CI/CD / FVM', 'icon': 'assets/defaultimage.webp', 'level': '85'},
    {'name': 'UI/UX & Animations', 'icon': 'assets/defaultimage.webp', 'level': '88'},
  ];

  static const List<Map<String, dynamic>> projects = [
    {
      'title': 'Resumo — ATS Resume & Job Matcher',
      'category': 'Productivity & Utilities',
      'featured': true,
      'badge': 'ATS & AI Matcher',
      'accentColor': 0xFF06B6D4,
      'description':
          'Intelligent ATS resume builder and live job-description analyzer platform. Features real-time keyword matching with scoring breakdown, interactive JD tailoring modal, dual visual rendering (Modern Glassmorphic vs. Classic Clean ATS), and dynamic vector PDF generation with one-click cross-platform export.',
      'highlights': [
        'Real-Time JD Match Score Engine',
        'Dynamic Multi-Page Vector PDF Generation',
        'Dual Presentation: Modern & Classic ATS',
        'Interactive Live Resume Editor & Tailor',
      ],
      'tags': ['Flutter', 'PDF Engine', 'ATS Matcher', 'Web & Desktop', 'Clean Arch'],
      'images': <String>[],
      'github': 'https://github.com/iamsreeragsreedhar',
    },
    {
      'title': 'StockFlow — Inventory & Logistics',
      'category': 'Enterprise & Logistics',
      'featured': true,
      'badge': 'Flagship Project',
      'accentColor': 0xFF087F5B,
      'description':
          'Enterprise-grade responsive warehouse & inventory management platform. Features emerald SaaS styling, camera barcode/QR scanner with laser reticle, inbound PO receiving, outbound picking checklist, cycle count auditing with variance reconciliation, multi-facility spatial tree (Facility > Zone > Aisle > Rack > Shelf > Bin), and interactive fl_chart metrics.',
      'highlights': [
        'Offline-First & Local Caching',
        'Barcode/QR Camera Scanner',
        'Multi-Warehouse Hierarchy',
        'Cycle Auditing & Discrepancies',
      ],
      'tags': ['Flutter', 'BLoC', 'GoRouter', 'fl_chart', 'Offline-First', 'Clean Architecture'],
      'images': <String>[],
      'github': 'https://github.com/iamsreeragsreedhar',
    },
    {
      'title': 'OutSplitIn — Expense & Budget Tracker',
      'category': 'Fintech & Utilities',
      'featured': true,
      'badge': 'Fintech Solution',
      'accentColor': 0xFF6366F1,
      'description':
          'Modern personal expense and budget management application. Features real-time cashflow analytics (interactive donut charts, monthly income vs expenses, and spending trend curves), category budget caps with threshold warnings, multi-currency support (INR, USD, EUR, etc.), and Firebase cloud synchronization.',
      'highlights': [
        'Interactive fl_chart Analytics',
        'Monthly Budget & Threshold Alerts',
        'Multi-Currency Support',
        'Firebase Auth & Cloud Firestore',
      ],
      'tags': ['Flutter', 'BLoC', 'Firebase Auth', 'Firestore', 'fl_chart', 'GoRouter'],
      'images': <String>[],
      'github': 'https://github.com/iamsreeragsreedhar',
    },
    {
      'title': 'PDA Warehouse Management App',
      'category': 'Enterprise & Logistics',
      'featured': false,
      'badge': 'Enterprise Solution',
      'accentColor': 0xFF0EA5E9,
      'description':
          'Real-time industrial warehouse application engineered for rugged PDA devices for Inbound & Outbound operations. Enables rapid barcode scanning, physical stock verifications, batch tracking, and seamless inventory synchronization with central enterprise databases.',
      'highlights': [
        'Rugged Industrial PDA Optimization',
        'Instant Barcode Processing',
        'Inbound & Outbound Logistics',
        'Oracle DB Integration',
      ],
      'tags': ['Flutter', 'REST API', 'Oracle DB', 'Industrial PDA', 'Barcoding'],
      'images': ['assets/PDA1.jpeg', 'assets/PDA2.jpeg', 'assets/PDA3.jpeg'],
      'github': 'https://github.com/iamsreeragsreedhar',
    },
    {
      'title': 'Flat Track — Property Operations',
      'category': 'Fintech & Real Estate',
      'featured': false,
      'badge': 'Commercial Platform',
      'accentColor': 0xFFF59E0B,
      'description':
          'Comprehensive housing and property management platform for tracking tenant units, maintenance workflows, operational dues, and generating detailed audit reports with role-based access control (RBAC).',
      'highlights': [
        'Tenancy & Maintenance Workflow',
        'Role-Based Access Control',
        'Automated Billing & Reporting',
        'Full REST API Integration',
      ],
      'tags': ['Flutter', 'Node.js', 'Oracle DB', 'RBAC', 'Mobile & Web'],
      'images': ['assets/Flattrack.jpeg', 'assets/fl2.jpeg', 'assets/fl3.jpeg'],
      'github': 'https://github.com/iamsreeragsreedhar',
    },
    {
      'title': 'DocGen — Machinery Inspection & Certs',
      'category': 'Enterprise & Logistics',
      'featured': false,
      'badge': 'Field Engineering',
      'accentColor': 0xFFEC4899,
      'description':
          'Enterprise document generation and field inspection system for heavy machinery fitness certificates and audit reports. Empowers field engineers and supervisors with validation checklists, photo attachments, and instant high-fidelity PDF report compilation.',
      'highlights': [
        'Dynamic Multi-Page PDF Generation',
        'Field Inspection Checklists',
        'Supervisor Approval Sign-off',
        'Offline Inspection Forms',
      ],
      'tags': ['Flutter', 'Node.js', 'PDF Generation', 'Field Inspection'],
      'images': [
        'assets/WMT.jpeg',
        'assets/WMT1.jpeg',
        'assets/WMT2.jpeg',
        'assets/WMT3.jpeg'
      ],
      'github': 'https://github.com/iamsreeragsreedhar',
    },
  ];

  static const List<Map<String, String>> experience = [
    {
      'role': 'Flutter Developer',
      'company': 'Exaware Solutions Private Limited',
      'period': 'Nov 2022 – June 2026',
      'description':
          'Architected, developed, and deployed 4+ scalable, multi-platform applications using Flutter with Node.js backends, maintaining high reliability and sub-second API response times. Delivered responsive cross-platform mobile apps optimized for Android and iOS with smooth 60fps animations. Engineered automated CI/CD pipelines via GitHub Actions cutting release cycle time by 40%. Followed Clean Architecture and MVVM patterns, integrated Firebase suite, developed dynamic client-side PDF report generation, and configured declarative routing with GoRouter.',
    },
  ];

  static const List<String> animatedRoles = [
    'Flutter Developer',
    'Cross-Platform Engineer',
    'Clean Architecture Specialist',
    'BLoC / State Management Pro',
    'Enterprise Mobile & Web Engineer',
    'UI/UX & Animations Enthusiast',
  ];
}
