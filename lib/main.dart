import 'package:flutter/material.dart';

void main() => runApp(const BenzoMangaApp());

class BenzoMangaApp extends StatelessWidget {
  const BenzoMangaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BENZO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF07070C),
        cardColor: const Color(0xFF12121E),
        primaryColor: const Color(0xFFFFB703),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: BenzoHomeScreen(),
      ),
    );
  }
}

class BenzoHomeScreen extends StatefulWidget {
  const BenzoHomeScreen({Key? key}) : super(key: key);

  @override
  State<BenzoHomeScreen> createState() => _BenzoHomeScreenState();
}

class _BenzoHomeScreenState extends State<BenzoHomeScreen> {
  int _currentTab = 0;
  String appName = "BENZO";
  String logoUrl = "https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=400";
  String currentUser = "ضيف BENZO";
  String currentRole = "👀 ضيف (قراءة مقفلة)";
  bool isOwner = false;
  int userPoints = 1000;
  bool doublePoints = false;
  bool triplePoints = false;
  bool browserUnlocked = false;
  bool exclusiveUnlocked = false;
  bool offlineUnlocked = false;
  String discordUrl = "https://discord.gg/manga-alarab";
  String? broadcastMessage;

  final List<Map<String, dynamic>> packages = [
    {
      "name": "باقة المحارب الفضي ⚔️",
      "perks": "إزالة الإعلانات بالكامل + شارة فضية + قراءة غير محدودة.",
      "points": 5000,
      "color": Colors.blueGrey,
    },
    {
      "name": "باقة التنين الذهبي 🐉",
      "perks": "فتح مصادر سوات ومانجاليك + هالة ذهبية للبروفايل + خصم نقاط.",
      "points": 12000,
      "color": const Color(0xFFFFB703),
    },
    {
      "name": "باقة إمبراطور المانجا 👑",
      "perks": "دبل نقاط دائم (1000 نقطة لكل 5 فصول) + خط ملون متوهج + فصول تيم إكس.",
      "points": 25000,
      "color": Colors.purpleAccent,
    },
    {
      "name": "باقة حاكم الظلال الأبدي ⚡",
      "perks": "تحميل الفصول وقراءتها بدون إنترنت + طلب ترجمة أعمال حصرية + شارة نارية.",
      "points": 50000,
      "color": Colors.cyanAccent,
    },
    {
      "name": "باقة العرش الإلهي 🪐",
      "perks": "تربل نقاط (1500 نقطة / 3 فصول) + ثيم ملكي + متصفح أدوات المانجا + شات كبار الشخصيات.",
      "points": 100000,
      "color": Colors.redAccent,
    },
  ];

  final List<String> comments = [
    "👑 BENZO (الفاوندر): مرحبًا بكم في إمبراطورية BENZO الرسمية!",
    "✍️ محرر سوات: تم رفع فصول سولو ليفلينج بدقة عالية.",
    "⚡ حاكم الظلال: ميزة التحميل بدون إنترنت ممتازة وسريعة.",
  ];

  void _login(String name) {
    setState(() {
      currentUser = name;
      if (name.toUpperCase() == "BENZO" || name.toLowerCase() == "owner" || name == "الفاوندر") {
        isOwner = true;
        currentRole = "👑 BENZO (الفاوندر والمالك)";
        userPoints = 999999;
        doublePoints = true;
        triplePoints = true;
        browserUnlocked = true;
        exclusiveUnlocked = true;
        offlineUnlocked = true;
      } else {
        isOwner = false;
        currentRole = "👤 عضو";
      }
    });
  }

  void _logout() {
    setState(() {
      currentUser = "ضيف BENZO";
      currentRole = "👀 ضيف (قراءة مقفلة)";
      isOwner = false;
      doublePoints = false;
      triplePoints = false;
      browserUnlocked = false;
      exclusiveUnlocked = false;
      offlineUnlocked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final showBrowser = isOwner || browserUnlocked;

    final List<Widget> pages = [
      _buildHomeView(),
      if (showBrowser) _buildBrowserView(),
      _buildPackagesView(),
      _buildSupportersView(),
      _buildProfileView(),
      if (isOwner) _buildOwnerRoomView(),
    ];

    final List<BottomNavigationBarItem> navItems = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
      if (showBrowser)
        const BottomNavigationBarItem(icon: Icon(Icons.language), label: "المتصفح"),
      const BottomNavigationBarItem(icon: Icon(Icons.star), label: "الباقات الـ 5"),
      const BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: "الداعمين"),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: "بروفايلي"),
      if (isOwner)
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
                image: DecorationImage(image: NetworkImage(logoUrl), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFFFFB703))),
                Text(currentRole, style: const TextStyle(fontSize: 10, color: Colors.white70)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(currentUser != "ضيف BENZO" ? Icons.logout : Icons.login, color: const Color(0xFFFFB703)),
            onPressed: () {
              if (currentUser != "ضيف BENZO") {
                _logout();
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
          if (broadcastMessage != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: Colors.redAccent.shade700,
              child: Text(
                "إشعار من BENZO: $broadcastMessage",
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(child: pages[_currentTab >= pages.length ? 0 : _currentTab]),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF5865F2),
        icon: const Icon(Icons.forum, color: Colors.white),
        label: const Text("ديسكورد"),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("رابط ديسكورد: $discordUrl")),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab >= navItems.length ? 0 : _currentTab,
        onTap: (i) => setState(() => _currentTab = i),
        backgroundColor: const Color(0xFF090910),
        selectedItemColor: const Color(0xFFFFB703),
        unselectedItemColor: Colors.white30,
        type: BottomNavigationBarType.fixed,
        items: navItems,
      ),
    );
  }

  Widget _buildHomeView() {
    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        Container(
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(image: NetworkImage(logoUrl), fit: BoxFit.cover),
          ),
          alignment: Alignment.bottomRight,
          padding: const EdgeInsets.all(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.amber)),
            child: const Text("إمبراطورية BENZO الرسمية 👑", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("رصيدك: $userPoints نقطة 🪙", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
            if (currentUser == "ضيف BENZO")
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: _showAuthDialog,
                child: const Text("تسجيل كمالك / عضو", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
          ],
        ),
        const SizedBox(height: 16),
        const Text("الأعمال الحصرية (سوات - تيم إكس - مانجاليك) 🔥", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _buildMangaCard("سولو ليفلينج: راجناروك", "الفصل 35 (سوات مانجا)", true),
        _buildMangaCard("تيم إكس: الحاكم المطلق", "الفصل 114 (تيم إكس)", true),
        _buildMangaCard("مانجاليك: الصياد الأسطوري", "الفصل 82 (مانجاليك)", false),
      ],
    );
  }

  Widget _buildMangaCard(String title, String src, bool isExclusive) {
    final canRead = !isExclusive || isOwner || exclusiveUnlocked;

    return Card(
      color: const Color(0xFF131322),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Colors.white10)),
      child: ListTile(
        leading: const Icon(Icons.menu_book, color: Colors.amber, size: 34),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(src, style: TextStyle(color: isExclusive ? Colors.redAccent : Colors.greenAccent, fontSize: 11)),
        trailing: Wrap(
          spacing: 4,
          children: [
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline, color: Colors.cyanAccent, size: 20),
              onPressed: () => _showComments(title),
            ),
            IconButton(
              icon: const Icon(Icons.download, color: Colors.purpleAccent, size: 22),
              onPressed: () {
                if (isOwner || offlineUnlocked) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("تم حفظ $title بدون إنترنت!")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("التحميل بدون نت ميزة حصرية لحاكم الظلال والمالك BENZO!")),
                  );
                }
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: canRead ? Colors.amber : Colors.grey.shade800),
              onPressed: () {
                if (currentUser == "ضيف BENZO") {
                  _showGuestDialog();
                } else if (!canRead) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("هذا المصدر محجوب! خاص بالمالك والمشتركين.")),
                  );
                } else {
                  final earned = triplePoints ? 1500 : (doublePoints ? 1000 : 500);
                  setState(() => userPoints += earned);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => Scaffold(
                        backgroundColor: Colors.black,
                        appBar: AppBar(
                          backgroundColor: const Color(0xFF0F0F1A),
                          title: Text(title, style: const TextStyle(fontSize: 14)),
                          actions: [
                            IconButton(
                              icon: const Icon(Icons.favorite, color: Colors.redAccent),
                              onPressed: () {
                                setState(() => userPoints = (userPoints >= 1000 ? userPoints - 1000 : 0));
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم التبرع بـ 1000 نقطة للمترجمين!")));
                              },
                            )
                          ],
                        ),
                        body: ListView(
                          children: [
                            Image.network("https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=800", fit: BoxFit.cover),
                            Image.network("https://images.unsplash.com/photo-1578632767115-351597cf2477?w=800", fit: BoxFit.cover),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
              child: Text(canRead ? "قراءة" : "مقفل 🔒", style: TextStyle(color: canRead ? Colors.black : Colors.white60)),
            ),
          ],
        ),
      ),
    );
  }

  void _showComments(String title) {
    final textCtrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF10101C),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheet) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 16, right: 16, top: 16),
          child: SizedBox(
            height: 420,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("تعليقات: $title", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.amber)),
                    IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (ctx, i) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: const Color(0xFF161626), borderRadius: BorderRadius.circular(10)),
                      child: Text(comments[i], style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textCtrl,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(hintText: "أضف تعليقك...", border: InputBorder.none),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.amber),
                      onPressed: () {
                        if (textCtrl.text.isNotEmpty) {
                          setState(() => comments.insert(0, "$currentRole $currentUser: ${textCtrl.text}"));
                          setSheet(() {});
                          textCtrl.clear();
                        }
                      },
                    )
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showGuestDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF141424),
        title: const Text("تنبيه الضيف ⛔"),
        content: const Text("رتبة الضيف تتيح تصفح القوائم فقط. يرجى تسجيل الدخول للقراءة."),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            onPressed: () {
              Navigator.pop(ctx);
              _showAuthDialog();
            },
            child: const Text("تسجيل الدخول الآن", style: TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }

  void _showAuthDialog() {
    final userCtrl = TextEditingController();
    final passCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF121220),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("تسجيل الدخول إلى BENZO"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "💡 اكتب 'BENZO' أو 'owner' لتفعيل رتبة المالك فوراً!",
              style: TextStyle(color: Colors.cyanAccent, fontSize: 11),
            ),
            const SizedBox(height: 12),
            TextField(controller: userCtrl, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "اسم المستخدم")),
            const SizedBox(height: 8),
            TextField(controller: passCtrl, obscureText: true, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "كلمة المرور")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("إلغاء")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            onPressed: () {
              String name = userCtrl.text.trim();
              if (name.isEmpty) name = "عضو أسطوري";
              _login(name);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("أهلاً بك $name في تطبيق BENZO!")),
              );
            },
            child: const Text("دخول", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _buildBrowserView() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text("المتصفح وأدوات الوكيل (خاص بالمالك BENZO) 🤖", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              ActionChip(label: const Text("سحب فصول سوات"), onPressed: () {}),
              ActionChip(label: const Text("تبييض الفقاعات"), onPressed: () {}),
              ActionChip(label: const Text("ترجمة OCR"), onPressed: () {}),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: const Color(0xFF10101C), borderRadius: BorderRadius.circular(12)),
              alignment: Alignment.center,
              child: const Text("المتصفح السري نشط ويعمل بأوامر BENZO فقط.", style: TextStyle(color: Colors.white54)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPackagesView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("باقات الاشتراك والدلع الملكية 💎", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.amber)),
            if (isOwner)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                icon: const Icon(Icons.add, size: 18),
                label: const Text("إنشاء باقة", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                onPressed: _showCreatePackageDialog,
              ),
          ],
        ),
        const SizedBox(height: 14),
        ..
