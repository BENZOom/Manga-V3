import 'package:flutter/material.dart';

void main() => runApp(const BenzoApp());

class BenzoApp extends StatelessWidget {
  const BenzoApp({Key? key}) : super(key: key);

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
        child: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;
  String currentUser = 'ضيف BENZO';
  String roleName = 'ضيف';
  bool isOwner = false;
  int points = 1000;
  bool doublePoints = false;
  bool offlineUnlocked = false;

  final List<Map<String, dynamic>> packages = [
    {'name': 'باقة المحارب الفضي ⚔️', 'points': 5000, 'color': Colors.blueGrey, 'desc': 'إزالة الإعلانات وشارة فضية'},
    {'name': 'باقة التنين الذهبي 🐉', 'points': 12000, 'color': Color(0xFFFFB703), 'desc': 'فتح مصادر سوات ومانجاليك'},
    {'name': 'باقة إمبراطور المانجا 👑', 'points': 25000, 'color': Colors.purpleAccent, 'desc': 'دبل نقاط دائم وفصول تيم إكس'},
    {'name': 'باقة حاكم الظلال ⚡', 'points': 50000, 'color': Colors.cyanAccent, 'desc': 'تحميل الفصول بدون إنترنت'},
    {'name': 'باقة العرش الإلهي 🪐', 'points': 100000, 'color': Colors.redAccent, 'desc': 'تربل نقاط وثيم ملكي خاص'},
  ];

  final List<String> comments = [
    'BENZO (الفاوندر): مرحباً بكم في إمبراطورية BENZO الرسمية!',
    'محرر سوات: فصول سولو ليفلينج راجناروك متوفرة بدقة عالية.',
  ];

  void _login(String name) {
    setState(() {
      currentUser = name;
      if (name.toUpperCase() == 'BENZO' || name.toLowerCase() == 'owner' || name == 'الفاوندر') {
        isOwner = true;
        roleName = 'الفاوندر والمالك BENZO';
        points = 999999;
        doublePoints = true;
        offlineUnlocked = true;
      } else {
        isOwner = false;
        roleName = 'عضو';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _homePage(),
      _packagesPage(),
      _profilePage(),
      if (isOwner) _ownerPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F1A),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFFFFB703),
              radius: 18,
              child: Icon(Icons.star, color: Colors.black),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('BENZO', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFFFFB703))),
                Text(roleName, style: const TextStyle(fontSize: 10, color: Colors.white70)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(currentUser != 'ضيف BENZO' ? Icons.logout : Icons.login, color: const Color(0xFFFFB703)),
            onPressed: () {
              if (currentUser != 'ضيف BENZO') {
                setState(() {
                  currentUser = 'ضيف BENZO';
                  roleName = 'ضيف';
                  isOwner = false;
                });
              } else {
                _showLogin();
              }
            },
          ),
        ],
      ),
      body: pages[_tab >= pages.length ? 0 : _tab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab >= pages.length ? 0 : _tab,
        onTap: (i) => setState(() => _tab = i),
        backgroundColor: const Color(0xFF090910),
        selectedItemColor: const Color(0xFFFFB703),
        unselectedItemColor: Colors.white30,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          const BottomNavigationBarItem(icon: Icon(Icons.star), label: 'الباقات الـ 5'),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'بروفايلي'),
          if (isOwner)
            const BottomNavigationBarItem(icon: Icon(Icons.build), label: 'غرفة BENZO'),
        ],
      ),
    );
  }

  Widget _homePage() {
    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        Container(
          height: 130,
          decoration: BoxDecoration(
            color: const Color(0xFF6A040F),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.amber),
          ),
          alignment: Alignment.center,
          child: const Text('إمبراطورية BENZO الرسمية 👑', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber)),
        ),
        const SizedBox(height: 14),
        Text('رصيدك: $points نقطة 🪙', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber)),
        const SizedBox(height: 14),
        const Text('الأعمال الحصرية (سوات - تيم إكس - مانجاليك)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _card('سولو ليفلينج: راجناروك', 'الفصل 35 (سوات مانجا)'),
        _card('تيم إكس: الحاكم المطلق', 'الفصل 114 (تيم إكس)'),
        _card('مانجاليك: الصياد الأسطوري', 'الفصل 82 (مانجاليك)'),
      ],
    );
  }

  Widget _card(String title, String src) {
    return Card(
      color: const Color(0xFF131322),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.menu_book, color: Colors.amber),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(src, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
          onPressed: () {
            if (currentUser == 'ضيف BENZO') {
              _showLogin();
            } else {
              final earn = doublePoints ? 1000 : 500;
              setState(() => points += earn);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم فتح $title وكسبت $earn نقطة!')));
            }
          },
          child: const Text('قراءة', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _packagesPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('باقات الدلع والاشتراكات الملكية 💎', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
        const SizedBox(height: 12),
        ...packages.map((pkg) => Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: const Color(0xFF131322), borderRadius: BorderRadius.circular(12), border: Border.all(color: pkg['color'] as Color)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(pkg['name'] as String, style: TextStyle(fontWeight: FontWeight.bold, color: pkg['color'] as Color, fontSize: 16)),
                  Text('${pkg['points']} نقطة 🪙', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              Text(pkg['desc'] as String, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _profilePage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ListTile(
          tileColor: const Color(0xFF131322),
          leading: const CircleAvatar(backgroundColor: Colors.amber, child: Icon(Icons.person, color: Colors.black)),
          title: Text(currentUser, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
          subtitle: Text('الرتبة: $roleName | الرصيد: $points 🪙'),
        ),
        const SizedBox(height: 12),
        const ListTile(tileColor: Color(0xFF131322), title: Text('ساعات القراءة'), trailing: Text('140 ساعة', style: TextStyle(color: Colors.amber))),
        const SizedBox(height: 6),
        const ListTile(tileColor: Color(0xFF131322), title: Text('الفصول المنجزة'), trailing: Text('1,500 فصل', style: TextStyle(color: Colors.cyanAccent))),
      ],
    );
  }

  Widget _ownerPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('غرفة التحكم الشامل للمالك BENZO ⚙️👑', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent)),
        const SizedBox(height: 14),
        SwitchListTile(
          tileColor: const Color(0xFF141424),
          title: const Text('مضاعفة النقاط (دبل نقاط)'),
          value: doublePoints,
          onChanged: (v) => setState(() => doublePoints = v),
        ),
        const SizedBox(height: 8),
        ListTile(
          tileColor: const Color(0xFF141424),
          title: const Text('شحن 50,000 نقطة لمحفظتك'),
          trailing: const Icon(Icons.add_circle, color: Colors.greenAccent),
          onTap: () {
            setState(() => points += 50000);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم شحن 50,000 نقطة بنجاح 🪙')));
          },
        ),
      ],
    );
  }

  void _showLogin() {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF121220),
        title: const Text('تسجيل الدخول إلى BENZO'),
        content: TextField(controller: ctrl, decoration: const InputDecoration(labelText: 'اكتب BENZO أو اسمك')),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            onPressed: () {
              if (ctrl.text.isNotEmpty) _login(ctrl.text.trim());
              Navigator.pop(ctx);
            },
            child: const Text('دخول', style: TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }
}
