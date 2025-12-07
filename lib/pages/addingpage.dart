import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  // Amount handled as string for digit-by-digit input
  String amount = "20.00";
  bool isExpense = true;

  // Date selector
  late List<DateTime> days; // will contain today-2 .. today+2
  int selectedDayIndex = 2; // center -> today

  // Category / emoji / note
  String selectedEmoji = "🍔";
  String categoryName = "burger king";
  String categoryNote = "";

  // Controllers used inside bottom sheet
  final TextEditingController _catNameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  // Emoji list
  final List<String> _emojis = [
    "🍔",
    "🍕",
    "🍟",
    "🍗",
    "☕",
    "🛒",
    "🚕",
    "🎁",
    "🏠",
    "📱",
    "💊",
    "🎬",
    "📚",
    "💼",
    "🔧",
    "💡",
    "🍻",
    "🎵",
    "🛍️",
    "🧾",
    "➕", // others
  ];

  @override
  void initState() {
    super.initState();

    // Build days: today -2 .. today +2
    DateTime today = DateTime.now();
    days = List.generate(5, (i) => today.add(Duration(days: i - 2)));
    selectedDayIndex = 2;

    // initialize controllers
    _catNameController.text = categoryName;
    _noteController.text = categoryNote;
  }

  @override
  void dispose() {
    _catNameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  // Helper to convert weekday to short string
  String _weekdayShort(int wd) {
    switch (wd) {
      case DateTime.monday:
        return "mon";
      case DateTime.tuesday:
        return "tue";
      case DateTime.wednesday:
        return "wed";
      case DateTime.thursday:
        return "thu";
      case DateTime.friday:
        return "fri";
      case DateTime.saturday:
        return "sat";
      case DateTime.sunday:
        return "sun";
      default:
        return "";
    }
  }

  // Numpad input logic with simple decimal validation (max 2 decimals)
  void _onKeyTap(String key) {
    setState(() {
      if (key == 'del') {
        if (amount.isNotEmpty) {
          amount = amount.substring(0, amount.length - 1);
        }
        if (amount == '') amount = '';
        return;
      }

      if (key == '.') {
        if (amount.contains('.')) return; // only one decimal
        if (amount.isEmpty) {
          amount = '0.';
        } else {
          amount += '.';
        }
        return;
      }

      // numeric key
      if (RegExp(r'^\d$').hasMatch(key)) {
        if (amount.contains('.')) {
          final parts = amount.split('.');
          // allow at most 2 decimals
          if (parts.length > 1 && parts[1].length >= 2) return;
        }
        // Prevent leading zeros like "00" — allow "0" then decimal
        if (amount == '0') {
          amount = key; // replace leading single zero
        } else {
          amount += key;
        }
        return;
      }
    });
  }

  // Format display amount: show 0.00 if empty or ends with '.'
  String _displayAmount() {
    if (amount.isEmpty) return "0.00";
    if (amount == ".") return "0.";
    // If ends with ".", show it
    if (amount.endsWith('.')) return amount;
    // If there's a decimal, keep as is (respecting user input)
    if (amount.contains('.')) return amount;
    // No decimal - show as integer
    return amount;
  }

  void _openCategoryBottomSheet() {
    _catNameController.text = categoryName;
    _noteController.text = categoryNote;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final mq = MediaQuery.of(context);
        return Padding(
          padding: EdgeInsets.only(
            bottom: mq.viewInsets.bottom,
            left: 16,
            right: 16,
            top: 12,
          ),
          child: Wrap(
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Select Category",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),

              // emoji grid
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 8,
                shrinkWrap: true,
                childAspectRatio: 1,
                children: _emojis.map((e) {
                  return InkWell(
                    onTap: () {
                      // If user taps "➕" (others), open simple dialog to enter emoji/text
                      if (e == '➕') {
                        Navigator.of(context).pop();
                        _openCustomEmojiDialog();
                      } else {
                        setState(() {
                          selectedEmoji = e;
                        });
                        Navigator.of(context).pop();
                        // reopen sheet to allow editing name/note with new emoji
                        Future.delayed(const Duration(milliseconds: 150),
                                () => _openCategoryBottomSheet());
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: selectedEmoji == e
                            ? Colors.black.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: selectedEmoji == e
                              ? Colors.black
                              : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(e, style: const TextStyle(fontSize: 20)),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 12),

              // Category name field
              TextField(
                controller: _catNameController,
                decoration: const InputDecoration(
                  labelText: "Category name",
                  hintText: "e.g., Starbucks, Grocery",
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const SizedBox(height: 12),

              // Note field
              TextField(
                controller: _noteController,
                decoration: const InputDecoration(
                  labelText: "Add note (optional)",
                  hintText: "e.g., Lunch with Sam",
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                minLines: 1,
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Save row
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          categoryName = _catNameController.text.trim().isEmpty
                              ? "Others"
                              : _catNameController.text.trim();
                          categoryNote = _noteController.text.trim();
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text("Save"),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _openCustomEmojiDialog() {
    final TextEditingController _emojiController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add custom emoji or icon"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Paste an emoji or short text to represent the icon"),
              const SizedBox(height: 8),
              TextField(
                controller: _emojiController,
                decoration: const InputDecoration(
                  hintText: "e.g., 🥤 or 🧾",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final input = _emojiController.text.trim();
                if (input.isNotEmpty) {
                  setState(() {
                    selectedEmoji = input;
                  });
                }
                Navigator.of(context).pop();
                // reopen bottom sheet to continue editing other fields
                Future.delayed(const Duration(milliseconds: 150),
                        () => _openCategoryBottomSheet());
              },
              child: const Text("Add"),
            )
          ],
        );
      },
    );
  }

  Widget _buildNumPad(double size) {
    final keys = [
      ["1", "2", "3"],
      ["4", "5", "6"],
      ["7", "8", "9"],
      [".", "0", "del"],
    ];

    double btnSize = size; // square size

    return Column(
      children: [
        ...keys.map((row) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: row.map((k) {
                final bool isDelete = k == 'del';
                return GestureDetector(
                  onTap: () {
                    if (isDelete) {
                      _onKeyTap('del');
                    } else {
                      _onKeyTap(k);
                    }
                  },
                  child: Container(
                    width: btnSize,
                    height: btnSize,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    alignment: Alignment.center,
                    child: isDelete
                        ? const Icon(Icons.backspace_outlined)
                        : Text(
                      k,
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),

        const SizedBox(height: 8),

        // Tick button row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // confirmation action
                _onConfirm();
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: EdgeInsets.all(btnSize * 0.3),
                minimumSize: Size(btnSize, btnSize),
              ),
              child: const Icon(Icons.check, size: 28),
            ),
          ],
        )
      ],
    );
  }

  void _onConfirm() {
    // On confirm; here we simply show a snackbar with the details.
    final selectedDate = days[selectedDayIndex];
    final dateStr = DateFormat.yMMMd().format(selectedDate);

    // Ensure amount is well-formed; if empty treat as 0.00
    String displayAmount = _displayAmount();
    if (displayAmount == '' || displayAmount == '.') displayAmount = '0.00';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          "${isExpense ? 'Expense' : 'Income'} saved: \$$displayAmount — $categoryName ($selectedEmoji) on $dateStr\nNote: ${categoryNote.isEmpty ? '—' : categoryNote}",
          style: TextStyle(
            color: Colors.red,
            // fontWeight: FontWeight.w500
          ),),
        duration: const Duration(seconds: 3),
      ),
    );

    // Reset or keep state as you want. We'll keep current values.
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final padding = 20.0;
    final numPadBtnSize = (width - padding * 2) / 5; // responsive

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
          child: Column(
            children: [
              const SizedBox(height: 26,),
              Text("Add Expenses",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),),
              const SizedBox(height: 30),

              // Expense / Income toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _modeButton("expenses", isExpense, () {
                    setState(() => isExpense = true);
                  }),
                  const SizedBox(width: 10),
                  _modeButton("income", !isExpense, () {
                    setState(() => isExpense = false);
                  }),
                ],
              ),

              const SizedBox(height: 24),

              // Date selector: shows today-2 .. today+2
              SizedBox(
                height: 92,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    final date = days[index];
                    final isSelected = index == selectedDayIndex;

                    // Show day number and weekday (short)
                    return GestureDetector(
                      onTap: () {
                        setState(() => selectedDayIndex = index);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 160),
                        width: 72,
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              date.day.toString(),
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            // const SizedBox(height: ),
                            Text(
                              _weekdayShort(date.weekday),
                              style: TextStyle(
                                color:
                                isSelected ? Colors.white70 : Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            if (_isSameDate(date, DateTime.now()))
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  "Today",
                                  style: TextStyle(
                                      color: isSelected
                                          ? Colors.white70
                                          : Colors.blueGrey,
                                      fontSize: 12),
                                ),
                              )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),

              // Amount display
              Text(
                "\$${_displayAmount()}",
                style: const TextStyle(
                    fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: 0.5),
              ),

              const SizedBox(height: 12),

              // Category pill (tap to open bottom sheet)
              GestureDetector(
                onTap: _openCategoryBottomSheet,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(selectedEmoji, style: const TextStyle(fontSize: 18)),
                      const SizedBox(width: 8),
                      Text(
                        categoryName,
                        style:
                        const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_drop_down, color: Colors.white),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Numpad area
              _buildNumPad(numPadBtnSize),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Widget _modeButton(String text, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

