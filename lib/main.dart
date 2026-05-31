import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ));

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const yellow = Color(0xFFE9C832);
  static const bg = Color(0xFFF2F1F6);

  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _selectedNav = 0;

  final List<_BannerData> _banners = const [
    _BannerData(
      imagePath: 'assets/images/img1.jpg',
      overlayColor: Color(0xFF0D2137),
      accentColor: Color(0xFFF5C542),
      eyebrow: 'Get',
      percent: '20%',
      suffix: 'OFF',
      sub: 'On all domestic routes',
    ),
    _BannerData(
      imagePath: 'assets/images/img2.jpg',
      overlayColor: Color(0xFF063020),
      accentColor: Color(0xFF6EE7B7),
      eyebrow: 'Fly',
      percent: 'Away',
      suffix: 'Today',
      sub: 'Your favorite flights await',
    ),
    _BannerData(
      imagePath: 'assets/images/img3.jpg',
      overlayColor: Color(0xFF3B1460),
      accentColor: Color(0xFFF9A8D4),
      eyebrow: 'Book',
      percent: 'Now',
      suffix: '& Save',
      sub: 'Top international destinations',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    final screenW = MediaQuery.of(context).size.width;
    final scale = screenW / 390.0;

    return Scaffold(
      backgroundColor: bg,
      body: Column(children: [
        // User Bar
        Container(
          color: yellow,
          padding: EdgeInsets.fromLTRB(
              16 * scale, topPad + 10 * scale, 16 * scale, 12 * scale),
          child: Row(children: [
            Container(
              width: 44 * scale,
              height: 44 * scale,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(11 * scale),
              ),
              child: Icon(Icons.person,
                  size: 24 * scale, color: const Color(0xFF6B5200)),
            ),
            SizedBox(width: 10 * scale),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Nurfadly Raditya',
                  style: TextStyle(
                      fontSize: 13 * scale,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3A2E00))),
              Text('nurfadlyraditya@gmail.com',
                  style: TextStyle(
                      fontSize: 10 * scale, color: const Color(0xFF7A6000))),
            ]),
            const Spacer(),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text('POINT',
                  style: TextStyle(
                      fontSize: 9 * scale,
                      color: const Color(0xFF7A6000),
                      letterSpacing: 0.8)),
              Text('999',
                  style: TextStyle(
                      fontSize: 22 * scale,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF3A2E00))),
            ]),
          ]),
        ),

        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 160 * scale,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _banners.length,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemBuilder: (_, i) =>
                      _BannerSlide(data: _banners[i], scale: scale),
                ),
              ),

              // Dots
              Container(
                color: bg,
                padding: EdgeInsets.symmetric(vertical: 8 * scale),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_banners.length, (i) {
                    final active = i == _currentPage;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3 * scale),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: active ? 18 * scale : 5 * scale,
                        height: 5 * scale,
                        decoration: BoxDecoration(
                          color: active ? yellow : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // LAYANAN UTAMA
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14 * scale),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  SizedBox(height: 10 * scale),
                  _buildGrid(scale, [
                    _ServiceItem(Icons.flight,
                        const Color(0xFF4DABF7), 'Penerbangan', scale),
                    _ServiceItem(Icons.location_on,
                        const Color(0xFFF59E0B), 'Destinasi', scale),
                    _ServiceItem(Icons.business,
                        const Color(0xFF22C55E), 'Hotel', scale),
                    _ServiceItem(Icons.directions_car,
                        const Color(0xFFEF4444), 'Sewa Mobil', scale),
                    _ServiceItem(Icons.train,
                        const Color(0xFF8B5CF6), 'Kereta', scale),
                    _ServiceItem(Icons.restaurant,
                        const Color(0xFFF97316), 'Kuliner', scale),
                    _ServiceItem(Icons.verified_user,
                        const Color(0xFF3B5BDB), 'Asuransi', scale),
                    _ServiceItem(Icons.confirmation_number,
                        const Color(0xFF495057), 'Kupon', scale),
                    _ServiceItem(Icons.celebration,
                        const Color(0xFFE91E8C), 'Event', scale),
                  ]),
                ]),
              ),
            ]),
          ),
        ),
      ]),

      // Bottom Nav
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE0E0E0), width: 0.5)),
        ),
        padding: EdgeInsets.fromLTRB(
            8 * scale, 10 * scale, 8 * scale, 16 * scale),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(0, Icons.home, 'Beranda', scale),
            _navItem(1, Icons.search, 'Cari', scale),
            _navItem(2, Icons.bookmark_border, 'Tersimpan', scale),
            _navItem(3, Icons.person_outline, 'Profil', scale),
          ],
        ),
      ),
    );
  }

  static Widget _buildGrid(double scale, List<Widget> items) =>
      GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: 10 * scale,
        crossAxisSpacing: 10 * scale,
        childAspectRatio: 1.05,
        children: items,
      );

  Widget _navItem(int idx, IconData icon, String label, double scale) {
    final active = _selectedNav == idx;
    final color = active ? yellow : const Color(0xFFBBBBBB);
    return GestureDetector(
      onTap: () => setState(() => _selectedNav = idx),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8 * scale),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 24 * scale, color: color),
          SizedBox(height: 3 * scale),
          Text(label,
              style: TextStyle(
                  fontSize: 10 * scale,
                  color: color,
                  fontWeight:
                      active ? FontWeight.w600 : FontWeight.normal)),
        ]),
      ),
    );
  }
}

// Banner Data

class _BannerData {
  final String imagePath, eyebrow, percent, suffix, sub;
  final Color overlayColor, accentColor;
  const _BannerData({
    required this.imagePath,
    required this.overlayColor,
    required this.accentColor,
    required this.eyebrow,
    required this.percent,
    required this.suffix,
    required this.sub,
  });
}

// Banner Slide

class _BannerSlide extends StatelessWidget {
  final _BannerData data;
  final double scale;
  const _BannerSlide({required this.data, required this.scale});

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Image.asset(
        data.imagePath,
        fit: BoxFit.cover,
      ),

      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              data.overlayColor.withValues(alpha: 0.50),
              data.overlayColor.withValues(alpha: 0.88),
            ],
          ),
        ),
      ),

      Positioned(
        right: 20 * scale,
        top: 0,
        bottom: 0,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
          Text(data.eyebrow,
              style: TextStyle(
                  color: data.accentColor.withValues(alpha: 0.9),
                  fontSize: 11 * scale,
                  fontWeight: FontWeight.w500)),
          SizedBox(height: 2 * scale),
          Text(data.percent,
              style: TextStyle(
                  color: data.accentColor,
                  fontSize: 46 * scale,
                  fontWeight: FontWeight.w800,
                  height: 1.0)),
          Text(data.suffix,
              style: TextStyle(
                  color: data.accentColor,
                  fontSize: 22 * scale,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 4 * scale),
          Text(data.sub,
              textAlign: TextAlign.end,
              style: TextStyle(
                  color: data.accentColor.withValues(alpha: 0.75),
                  fontSize: 9 * scale)),
        ]),
      ),
    ]);
  }
}

// Service Item

class _ServiceItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final double scale;
  const _ServiceItem(this.icon, this.color, this.label, this.scale);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14 * scale),
        border: Border.all(
            color: Colors.black.withValues(alpha: 0.06), width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4 * scale,
            offset: Offset(0, 2 * scale),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
          vertical: 10 * scale, horizontal: 6 * scale),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 50 * scale,
          height: 50 * scale,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14 * scale)),
          child: Icon(icon, size: 27 * scale, color: Colors.white),
        ),
        SizedBox(height: 7 * scale),
        Text(label,
            style: TextStyle(
                fontSize: 11 * scale,
                color: const Color(0xFF444444),
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
      ]),
    );
  }
}