import 'package:flutter/material.dart';

void main() => runApp(const MangaEmpireApp());

enum Role { owner, headAdmin, superAdmin, adminMonth, admin, translator, editor, member, guest }

class VipPackage {
  final String name;
  final String perks;
  final int points;
  final Color color;
  VipPackage(this.name, this.perks, this.points, this.color);
}

class MangaEmpireApp extends StatefulWidget {
  const MangaEmpireApp({Key? key}) : super(key: key);
  @override
  State<MangaEmpireApp> createState() => _MangaEmpireAppState();
}

class _MangaEmpireAppState extends State<MangaEmpireApp> {
  Role currentRole = Role.guest;
  String currentUser = "ضيف BENZO";
  bool isLoggedIn = false;
  String appName = "BENZO";
  String logoUrl = "https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=400";
  int userPoints = 1000;
  bool doublePoints = false;
  bool triplePoints = false;
  bool browserUnlocked = false;
  bool exclusiveUnlocked = false;
  bool offlineUnlocked = false;
  String discordUrl = "https://discord.gg/manga-alarab";
  String? broadcastNotice;

  final List<VipPackage> packages = [
    VipPackage("باقة المحارب الفضي ⚔️", "إزالة الإعلانات بالكامل + شارة فضية + قراءة غير محدودة.", 5000, Colors.blueGrey),
    VipPackage("باقة التنين الذهبي 🐉", "فتح مصادر سوات ومانجاليك + هالة ذهبية للبروفايل + خصم نقاط.", 12000, const Color(0xFFFFB703)),
    VipPackage("باقة إمبراطور المانجا 👑", "دبل نقاط دائم (1000 نقطة لكل 5 فصول) + خط ملون متوهج + فصول تيم إكس.", 25000, Colors.purpleAccent),
    VipPackage("باقة حاكم الظلال الأبدي ⚡", "تحميل الفصول وقراءتها بدون إنترنت + طلب ترجمة أعمال حصرية + شارة نارية.", 50000, Colors.cyanAccent),
    VipPackage("باقة العرش الإلهي 🪐", "تربل نقاط (1500 نقطة / 3 فصول) + ثيم ملكي + متصفح أدوات المانجا + شات كبار الشخصيات.", 100000, Colors.redAccent),
  ];

  final List<String> comments = [
    "👑 BENZO (الفاوندر): مرحبًا بكم في إمبراطورية BENZO الرسمية!",
    "✍️ محرر سوات: تم رفع فصول سولو ليفلينج بدقة عالية.",
    "⚡ حاكم الظلال: ميزة التحميل بدون إنترنت ممتازة وسريعة.",
  ];

  String getRoleTag(Role r) {
    switch (r) {
      case Role.owner: return "👑 BENZO (الفاوندر والمالك)";
      case Role.headAdmin: return "⚡ هيد ادمن";
      case Role.superAdmin: return "🛡️ سوبر ادمن";
      case Role.adminMonth: return "⭐ ادمن الشهر";
      case Role.admin: return "🔰 ادمن";
      case Role.translator: return "✍️ مترجم";
      case Role.editor: return "🎨 محرر";
      case Role.member: return "👤 عضو";
      case Role.guest: return "👀 ضيف (قراءة مقفلة)";
    }
  }

  void handleLogin(String username) {
    setState(() {
      currentUser = username;
      isLoggedIn = true;
      if (username.toUpperCase() == "BENZO" || username.toLowerCase() == "owner" || username == "الفاوندر") {
        currentRole = Role.owner;
        userPoints = 999999;
        doublePoints = true;
        triplePoints = true;
        browserUnlocked = true;
        exclusiveUnlocked = true;
        offlineUnlocked = true;
      } else {
        currentRole = Role.member;
      }
    });
  }

  void handleLogout() {
    setState(() {
      currentRole = Role.guest;
      currentUser = "ضيف BENZO";
      isLoggedIn = false;
      browserUnlocked = false;
      doublePoints = false;
      triplePoints = false;
      exclusiveUnlocked = false;
      offlineUnlocked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF07070C),
        cardColor: const Color(0xFF12121E),
        primaryColor: const Color(0xFFFFB703),
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: HomeScreenWidget(
          appName: appName,
          logoUrl: logoUrl,
          currentUser: currentUser,
          currentRole: currentRole,
          isLoggedIn: isLoggedIn,
          userPoints: userPoints,
          doublePoints: doublePoints,
          triplePoints: triplePoints,
          browserUnlocked: browserUnlocked,
          exclusiveUnlocked: exclusiveUnlocked,
          offlineUnlocked: offlineUnlocked,
          discordUrl: discordUrl,
          broadcastNotice: broadcastNotice,
          packages: packages,
          comments: comments,
          roleTag: getRoleTag(currentRole),
          onLogin: handleLogin,
          onLogout: handleLogout,
          onAddPoints: (p) => setState(() => userPoints += p),
          onUpdateName: (n) => setState(() => appName = n),
          onUpdateLogo: (l) => setState(() => logoUrl = l),
          onUpdateDiscord: (d) => setState(() => discordUrl = d),
          onToggleBrowser: (v) => setState(() => browserUnlocked = v),
          onToggleDouble: (v) => setState(() => doublePoints = v),
          onToggleExclusive: (v) => setState(() => exclusiveUnlocked = v),
          onSendBroadcast: (b) => setState(() => broadcastNotice = b),
          onAddPackage: (pkg) => setState(() => packages.add(pkg)),
          onAddComment: (c) => setState(() => comments.insert(0, c)),
        ),
      ),
    );
  }
}

class HomeScreenWidget extends StatefulWidget {
  final String appName;
  final String logoUrl;
  final String currentUser;
  final Role currentRole;
  final bool isLoggedIn;
  final int userPoints;
  final bool doublePoints;
  final bool triplePoints;
  final bool browserUnlocked;
  final bool exclusiveUnlocked;
  final bool offlineUnlocked;
  final String discordUrl;
  final String? broadcastNotice;
  final List<VipPackage> packages;
  final List<String> comments;
  final String roleTag;
  final Function(String) onLogin;
  final VoidCallback onLogout;
  final Function(int) onAddPoints;
  final Function(String) onUpdateName;
  final Function(String) onUpdateLogo;
  final Function(String) onUpdateDiscord;
  final Function(bool) onToggleBrowser;
  final Function(bool) onToggleDouble;
  final Function(bool) onToggleExclusive;
  final Function(String) onSendBroadcast;
  final Function(VipPackage) onAddPackage;
  final Function(String) onAddComment;

  const HomeScreenWidget({
    Key? key,
    required this.appName,
    required this.logoUrl,
    required this.currentUser,
    required this.currentRole,
    required this.isLoggedIn,
    required this.userPoints,
    required this.doublePoints,
    required this.triplePoints,
    required this.browserUnlocked,
    required this.exclusiveUnlocked,
    required this.offlineUnlocked,
    required this.discordUrl,
    this.broadcastNotice,
    required this.packages,
    required this.comments,
    required this.roleTag,
    required this.onLogin,
    required this.onLogout,
    required this.onAddPoints,
    required this.onUpdateName,
    required this.onUpdateLogo,
    required this.onUpdateDiscord,
    required this.onToggleBrowser,
    required this.onToggleDouble,
    required this.onToggleExclusive,
    required this.onSendBroadcast,
    required this.onAddPackage,
    required this.onAddComment,
  }) : super(key: key);

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  int _tab = 0;

  bool get showBrowser => widget.currentRole == Role.owner || widget.browserUnlocked;

  @override
  Widget build(BuildContext context) {
    List<Widget> views = [
      _buildHomeTab(),
      if (showBrowser) _buildBrowserTab(),
      _buildPackagesTab(),
      _buildSupportersTab(),
      _buildProfileTab(),
      if (widget.currentRole == Role.owner) _buildOwnerRoomTab(),
    ];

    List<BottomNavigationBarItem> navItems = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
      if (showBrowser)
        const BottomNavigationBarItem(icon: Icon(Icons.language), label: "المتصفح"),
      const BottomNavigationBarItem(icon: Icon(Icons.star), label: "الباقات الـ 5"),
      const BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: "الداعمين"),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: "بروفايلي"),
      if (widget.currentRole == Role.owner)
        const BottomNavigationBarItem(icon: Icon(Icons.build), label: "غرفة BENZO"),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F1A),
        elevation: 6,
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFFB703), width: 2),
                image: DecorationImage(image: NetworkImage(widget.logoUrl), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.appName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFFFFB703))),
                Text(widget.roleTag, style: const TextStyle(fontSize: 10, color: Colors.white70)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(widget.isLoggedIn ? Icons.logout : Icons.login, color: const Color(0xFFFFB703)),
            onPressed: () {
              if (widget.isLoggedIn) {
                widget.onLogout();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم تسجيل الخروج بنجاح.")));
              } else {
                _showAuthDialog();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (widget.broadcastNotice != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: Colors.redAccent.shade700,
              child: Text(
                "إشعار من BENZO: ${widget.broadcastNotice}",
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(child: views[_tab >= views.length ? 0 : _tab]),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF5865F2),
        icon: const Icon(Icons.forum, color: Colors.white),
        label: const Text("ديسكورد"),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("رابط ديسكورد: ${widget.discordUrl}")),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab >= navItems.length ? 0 : _tab,
        onTap: (i) => setState(() => _tab = i),
        backgroundColor: const Color(0xFF090910),
        selectedItemColor: const Color(0xFFFFB703),
        unselectedItemColor: Colors.white30,
        type: BottomNavigationBarType.fixed,
        items: navItems,
      ),
    );
  }

  Widget _buildHomeTab() {
    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        Container(
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(image: NetworkImage(widget.logoUrl), fit: BoxFit.cover),
          ),
          alignment: Alignment.bottomRight,
          paddi
