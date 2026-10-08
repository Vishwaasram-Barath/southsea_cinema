import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie> getMovies() {
    return const [
      Movie(
        id: '1',
        title: 'Dune Part II',
        ageRating: 'PG-13',
        synopsis:
            'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
        screeningTime: 'Friday 9 OCT 18:00',
        imagePath: 'assets/images/Dune2.jpeg',
        price: 7.5,
      ),
      Movie(
        id: '2',
        title: 'Interstellar',
        ageRating: 'PG-13',
        synopsis:
            'When Earth becomes uninhabitable in the future, a farmer and ex-NASA pilot, Joseph Cooper, is tasked to pilot a spacecraft, along with a team of researchers, to find a new planet for humans.',
        screeningTime: 'Saturday 10 OCT 20:00',
        imagePath: 'assets/images/Interstellar.jpeg',
        price: 7.5,
      ),
    ];
  }
}
