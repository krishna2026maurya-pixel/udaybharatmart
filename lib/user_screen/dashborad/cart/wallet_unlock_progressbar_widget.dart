import 'package:flutter/material.dart';
import 'package:uday_bharat/utils/cutom_text.dart';

class WalletUnlockProgressBar extends StatelessWidget {
  final double currentAmount;
  final double minAmount;
  final double fullAmount;
  final double partialWalletAmount;
  final String? walletMessage;

  const WalletUnlockProgressBar({
    Key? key,
    required this.currentAmount,
    required this.minAmount,
    required this.fullAmount,
    required this.partialWalletAmount,
    this.walletMessage,
  }) : super(key: key);

  double _progressPercent() {
    if (currentAmount <= 0) return 0;

    if (currentAmount < minAmount) {
      return (currentAmount / minAmount) * 0.5;
    } else if (currentAmount < fullAmount) {
      return 0.5 +
          ((currentAmount - minAmount) / (fullAmount - minAmount)) * 0.5;
    } else {
      return 1.0;
    }
  }

  Color _progressColor() {
    if (currentAmount < minAmount) {
      return Colors.orange;
    } else if (currentAmount < fullAmount) {
      return Colors.amber;
    } else {
      return Colors.green;
    }
  }

  String _titleText() {
    if (walletMessage != null && walletMessage!.isNotEmpty) {
      return walletMessage!;
    }

    if (currentAmount < minAmount) {
      return 'Add ₹${(minAmount - currentAmount).ceil()} to unlock wallet';
    } else if (currentAmount < fullAmount) {
      return '₹${partialWalletAmount.toInt()} wallet unlocked!';
    } else {
      return 'Full wallet balance unlocked';
    }
  }

  String _subText() {
    if (currentAmount < minAmount) {
      return 'Wallet unlocks at ₹${minAmount.toInt()} order value';
    } else if (currentAmount < fullAmount) {
      return 'Add ₹${(fullAmount - currentAmount).ceil()} more to unlock full wallet';
    } else {
      return 'You are using your full wallet balance';
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = _progressPercent();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          _titleText(),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 4),
        CustomText(
          _subText(),
          fontSize: 12,
          color: Colors.grey.shade600,
        ),
        const SizedBox(height: 10),

        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: progress),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) {
              return LinearProgressIndicator(
                value: value,
                minHeight: 8,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation(_progressColor()),
              );
            },
          ),
        ),

        const SizedBox(height: 6),

        // Milestones
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText('₹0', fontSize: 11),
            CustomText('₹${minAmount.toInt()}',
                fontSize: 11),
            CustomText('₹${fullAmount.toInt()}+',
                fontSize: 11),
          ],
        ),
      ],
    );
  }
}
