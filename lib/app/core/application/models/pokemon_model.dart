import 'package:pokedex/app/core/application/enums/pokemon_type_enum.dart';
import 'package:pokedex/app/core/application/models/pokemon_flavor_text_model.dart';
import 'package:pokedex/app/core/application/models/pokemon_preview_model.dart';

class PokemonModel {
  final int weight;
  final int height;
  final String? gifUrl;
  final String? criesUrl;
  final int baseExperience;
  final List<PokemonTypeEnum> types;
  final PokemonPreviewModel pokemonPreviewModel;
  final List<String> abilities;
  PokemonFlavorTextModel? flavorTextModel;

  PokemonModel({
    this.flavorTextModel,
    required this.baseExperience,
    required this.abilities,
    required this.weight,
    required this.height,
    required this.gifUrl,
    required this.criesUrl,
    required this.types,
    required this.pokemonPreviewModel,
  });

  String get weightFormatted {
    return '${(weight / 10).toStringAsFixed(1)} KG'.replaceAll('.', ',');
  }

  String get heightFormatted {
    return '${(height / 10).toStringAsFixed(1)} M'.replaceAll('.', ',');
  }

  factory PokemonModel.fromJson(Map json) {
    return PokemonModel(
      pokemonPreviewModel: PokemonPreviewModel(
        name: json['name'],
        id: json['id'],
        imageUrl: json['sprites']?['front_default'],
      ),
      baseExperience: json['base_experience'],
      weight: json['weight'],
      height: json['height'],
      criesUrl: json['cries']?['latest'],
      gifUrl: json['sprites']?['other']?['showdown']?['front_default'],
      types: json['types'] != null
          ? (json['types'] as List)
              .map((type) => PokemonTypeEnum.fromJson(type))
              .toList()
          : [],
      abilities: json['abilities'] != null
          ? (json['abilities'] as List)
              .map((ability) => ability['ability']['name'] as String)
              .toList()
          : [],
    );
  }
}
