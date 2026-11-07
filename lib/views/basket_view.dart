import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

class BasketView extends StatefulWidget {
  const BasketView({super.key});

  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends State<BasketView> {
  String _confirmationMessage = '';

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.0),
        child: Text(
          'Your basket is empty',
          style: TextStyle(fontSize: 16, color: cinemaFontMuted),
        ),
      ),
    );
  }

  Widget _buildLineItem(BasketRepository basket, BasketItem item, int index) {
    return Card(
      color: cinemaSurface,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item.quantity} x ${item.movie.title}',
                    style: const TextStyle(
                      color: cinemaFontWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.movie.screeningTime,
                    style: const TextStyle(color: cinemaFontMuted),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '£${item.lineTotal.toStringAsFixed(2)}',
                    style: const TextStyle(color: cinemaFontWhite),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () {
                setState(() {
                  basket.removeItem(index);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow(String label, String value, {bool emphasise = false}) {
    final TextStyle style;
    if (emphasise) {
      style = const TextStyle(
        color: cinemaFontWhite,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      );
    } else {
      style = const TextStyle(color: cinemaFontWhite);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }

  Widget _buildBasketList(BasketRepository basket, List<BasketItem> items) {
    final List<Widget> children = [];

    children.add(
      const Text(
        'Your basket',
        style: TextStyle(
          color: cinemaFontWhite,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    children.add(const SizedBox(height: 16));

    for (int index = 0; index < items.length; index++) {
      children.add(_buildLineItem(basket, items[index], index));
    }

    children.add(const SizedBox(height: 24));
    children.add(
      _buildTotalRow('Tickets', '${basket.getTotalTickets()}'),
    );
    children.add(
      _buildTotalRow(
        'Total to pay',
        '£${basket.getTotal().toStringAsFixed(2)}',
        emphasise: true,
      ),
    );
    children.add(const SizedBox(height: 24));

    children.add(
      SizedBox(
        width: double.infinity,
        child: PrimaryButton(
          label: 'Checkout',
          onPressed: () {
            setState(() {
              basket.clear();
              _confirmationMessage = 'Thanks, your tickets are booked';
            });
          },
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    final BasketRepository basket = BasketRepository.instance;
    final List<BasketItem> items = basket.getItems();

    final Widget content;
    if (items.isEmpty) {
      content = Column(
        children: [
          _buildEmptyState(),
          if (_confirmationMessage.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              _confirmationMessage,
              style: const TextStyle(
                color: cinemaFontWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      );
    } else {
      content = _buildBasketList(basket, items);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: content,
      ),
    );
  }
}
