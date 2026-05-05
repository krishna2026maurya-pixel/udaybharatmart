import 'package:flutter/material.dart';

class ScheduleDeliveryPage extends StatefulWidget {
  const ScheduleDeliveryPage({Key? key}) : super(key: key);
  @override
  State<ScheduleDeliveryPage> createState() => _ScheduleDeliveryPageState();
}
class _ScheduleDeliveryPageState extends State<ScheduleDeliveryPage>
    with SingleTickerProviderStateMixin {
  int selectedPeriod = 0;
  String selectedSlot = "";
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  final List<String> morningSlots = [
    "08:00 - 09:00",
    "09:00 - 10:00",
    "10:00 - 11:00",
    "11:00 - 12:00",
  ];
  final List<String> afternoonSlots = [
    "12:00 - 01:00",
    "01:00 - 02:00",
    "02:00 - 03:00",
    "03:00 - 04:00",
  ];

  final List<String> eveningSlots = [
    "04:00 - 05:00",
    "05:00 - 06:00",
    "06:00 - 07:00",
    "07:00 - 08:00",
  ];

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 400));

    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<String> getCurrentSlots() {
    if (selectedPeriod == 0) return morningSlots;
    if (selectedPeriod == 1) return afternoonSlots;
    return eveningSlots;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      appBar: AppBar(
        title: const Text("Schedule Delivery"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      body: FadeTransition(
        opacity: _fadeAnim,
        child: Column(
          children: [
            scheduleInfoBanner(),
            const SizedBox(height: 15),

            _buildPeriodTabs(),

            const SizedBox(height: 20),

            Expanded(child: _buildSlots()),

            _buildConfirmButton()
          ],
        ),
      ),
    );
  }

  // ---------------- PERIOD TABS ----------------

  Widget _buildPeriodTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
            )
          ],
        ),
        child: Row(
          children: [

            _tabItem("Morning", 0),
            _tabItem("Afternoon", 1),
            _tabItem("Evening", 2),

          ],
        ),
      ),
    );
  }

  Widget _tabItem(String title, int index) {
    bool isSelected = selectedPeriod == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedPeriod = index;
            selectedSlot = "";
          });
          _controller.reset();
          _controller.forward();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.deepPurple : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- TIME SLOTS ----------------

  Widget _buildSlots() {
    final slots = getCurrentSlots();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        itemCount: slots.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.6,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final slot = slots[index];
          bool isSelected = selectedSlot == slot;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedSlot = slot;
              });

            },
            child: AnimatedScale(
              scale: isSelected ? 1.05 : 1,
              duration: const Duration(milliseconds: 250),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? Colors.deepPurple : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    slot,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------- CONFIRM BUTTON ----------------

  Widget _buildConfirmButton() {

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: selectedSlot.isEmpty
                ? null
                : () {
      
              // 👉 SEND TO API
              print("Selected Slot: $selectedSlot");
      
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Delivery Scheduled at $selectedSlot"),
                ),
              );
              Navigator.pop(context,'$selectedSlot');
            },
            child:  Text(
              "Confirm Delivery Time",

              style: TextStyle(fontSize: 16,color: selectedSlot.isNotEmpty?Colors.white:Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
  Widget scheduleInfoBanner() {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 700),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.deepPurple.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
        ),
        child: Row(
          children: [

            const Icon(Icons.schedule, color: Colors.deepPurple),

            const SizedBox(width: 10),

            Expanded(
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black87),
                  children: [
                    TextSpan(
                      text: "Delivery service is closed right now.\n",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "Please schedule your order between 8 AM – 8 PM.",
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}
