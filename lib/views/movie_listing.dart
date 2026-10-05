import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
  const MovieListing({super.key});

  @override
  State<MovieListing> createState() => _MovieListingState();
}

class _MovieListingState extends State<MovieListing> {
  int _ticketQuantity = 0;
  String _orderMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DUNE PART II (2024) (PG-13)',
                    style: TextStyle(
                      color: cinemaFontWhite,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
                    style: TextStyle(color: cinemaFontWhite),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Southsea Cinema Room',
              style: TextStyle(color: cinemaFontWhite),
            ),
            const SizedBox(height: 12),
            const Text(
              'Thursday 22 Oct 2026, 18:00 - ends at 20:30',
              style: TextStyle(color: cinemaFontWhite),
            ),
            const SizedBox(height: 32),
            const Text(
              'Please note that Discounts / Membership Benefits will be applied once you have selected your tickets',
              style: TextStyle(color: cinemaFontWhite),
            ),
          ],
        ),
      ),
    );
  }
}
