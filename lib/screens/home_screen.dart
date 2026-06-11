import 'package:flutter/material.dart';
import '../models/banner_data.dart';
import '../widgets/banner_slide.dart';
import '../widgets/service_item.dart';

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

  final List<BannerData> _banners = const [
    BannerData(
      imagePath: 'assets/images/img1.jpg',
      overlayColor: Color(0xFF0D2137),
      accentColor: Color(0xFFF5C542),
      eyebrow: 'Get',
      percent: '20%',
      suffix: 'OFF',
      sub: 'On all domestic routes',
    ),
    BannerData(
      imagePath: 'assets/images/img2.jpg',
      overlayColor: Color(0xFF063020),
      accentColor: Color(0xFF6EE7B7),
      eyebrow: 'Fly',
      percent: 'Away',
      suffix: 'Today',
      sub: 'Your favorite flights await',
    ),
    BannerData(
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
                      BannerSlide(data: _banners[i], scale: scale),
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

              // Service Grid
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14 * scale),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  SizedBox(height: 10 * scale),
                  _buildGrid(scale, [
                    ServiceItem(Icons.flight,
                        const Color(0xFF4DABF7), 'Penerbangan', scale),
                    ServiceItem(Icons.location_on,
                        const Color(0xFFF59E0B), 'Destinasi', scale),
                    ServiceItem(Icons.business,
                        const Color(0xFF22C55E), 'Hotel', scale),
                    ServiceItem(Icons.directions_car,
                        const Color(0xFFEF4444), 'Sewa Mobil', scale),
                    ServiceItem(Icons.train,
                        const Color(0xFF8B5CF6), 'Kereta', scale),
                    ServiceItem(Icons.restaurant,
                        const Color(0xFFF97316), 'Kuliner', scale),
                    ServiceItem(Icons.verified_user,
                        const Color(0xFF3B5BDB), 'Asuransi', scale),
                    ServiceItem(Icons.confirmation_number,
                        const Color(0xFF495057), 'Kupon', scale),
                    ServiceItem(Icons.celebration,
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