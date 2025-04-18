abstract class Endpoints {
  static const pokemon = 'pokemon';
  static const pokemonSpecies = 'pokemon-species';
  static const type = 'type';
  static const ability = 'ability';
}

abstract class API {
  static const String _path = 'https://pokeapi.co/api/';
  static const String _version = 'v2/';

  static const url = _path + _version;
}
