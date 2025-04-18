import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pokedex/app/core/application/enums/pokemon_type_enum.dart';
import 'package:pokedex/app/core/application/theme/palettes.dart';
import 'package:pokedex/app/modules/pokemon_details/pokemon_details_page/pokemon_details_page_controller.dart';
import 'package:pokedex/app/modules/pokemon_details/widgets/characteristic_box.dart';
import 'package:pokedex/app/modules/widgets/text_pokemon.dart';
import 'package:pokedex/app/modules/widgets/type_badge.dart';

class PokemonDetailsPage extends GetView<PokemonDetailsPageController> {
  const PokemonDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palettes.backgroundColor,
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.pokemonModel.value?.gifUrl != null)
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        height: 360,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color:
                              controller.pokemonModel.value?.types.first.color,
                          gradient: LinearGradient(
                            colors: [
                              controller
                                      .pokemonModel.value?.types.first.color ??
                                  Colors.transparent,
                              controller.pokemonModel.value?.types.first.color
                                      .withValues(alpha: 0.5) ??
                                  Colors.transparent,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(100000),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: ShaderMask(
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white,
                                    Colors.white.withValues(alpha: 0.05),
                                  ]).createShader(bounds);
                            },
                            blendMode: BlendMode.srcIn,
                            child: SvgPicture.asset(
                              controller.pokemonModel.value?.types.first
                                      .iconPath ??
                                  '',
                              key: Key(
                                  'background_type_${controller.pokemonModel.value?.types.first.name}'),
                              width: Get.width * 0.6,
                              height: Get.width * 0.6,
                              colorFilter: ColorFilter.mode(
                                  Colors.transparent, BlendMode.color),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Image.network(
                        controller.pokemonModel.value!.gifUrl!,
                        key: Key(
                            'pokemon_gif_${controller.pokemonModel.value?.pokemonPreviewModel.id}'),
                        width: Get.width,
                        height: 290,
                        alignment: Alignment.bottomCenter,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox(
                            width: Get.width,
                            height: 290,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 15,
                      child: InkWell(
                        onTap: controller.goBack,
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Palettes.backButtonColor,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TextPokemon(
                  text: controller.pokemonModel.value?.pokemonPreviewModel
                          .formattedName ??
                      '',
                  fontSize: 29,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TextPokemon(
                  text:
                      'Nº${controller.pokemonModel.value?.pokemonPreviewModel.formattedId}',
                  fontSize: 20,
                  color: Palettes.grayTextColor,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.pokemonModel.value?.types.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TypeBadge(
                        key: Key(
                            'type_badge_${controller.pokemonModel.value?.types[index].name}'),
                        onTap: () => controller.onTapType(
                          controller.pokemonModel.value?.types[index] ??
                              PokemonTypeEnum.unknown,
                        ),
                        type: controller.pokemonModel.value?.types[index] ??
                            PokemonTypeEnum.unknown,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextPokemon(
                    key: Key('description'),
                    text: controller.pokemonModel.value?.flavorTextModel
                            ?.flavorTextFormatted ??
                        '',
                    maxLines: 10,
                    fontSize: 18),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: CharacteristicBox.svg(
                      key: Key('weight'),
                      boxTitle: 'Peso',
                      boxValue:
                          controller.pokemonModel.value?.weightFormatted ?? '',
                      boxSvgIcon: 'assets/icons/weight_icon.svg',
                      boxWidth: Get.width / 2 - 15 - 7.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: CharacteristicBox(
                      key: Key('height'),
                      boxTitle: 'Altura',
                      boxValue:
                          controller.pokemonModel.value?.heightFormatted ?? '',
                      boxIcon: Icons.height_rounded,
                      boxWidth: Get.width / 2 - 15 - 7.5,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: CharacteristicBox.svg(
                      key: Key(
                          'ability_${controller.pokemonModel.value?.abilities.firstOrNull}'),
                      onTapBox: () => controller.onTapAbility(
                        controller.pokemonModel.value?.abilities.firstOrNull ??
                            '',
                      ),
                      boxTitle: 'Habilidade',
                      boxValue: controller
                              .pokemonModel.value?.abilities.firstOrNull ??
                          '',
                      boxSvgIcon: 'assets/icons/poke_ball_icon.svg',
                      boxWidth: Get.width / 2 - 15 - 7.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: CharacteristicBox.svg(
                      key: Key(
                          'ability_${controller.pokemonModel.value?.abilities.lastOrNull}'),
                      onTapBox: () => controller.onTapAbility(
                        controller.pokemonModel.value?.abilities.lastOrNull ??
                            '',
                      ),
                      boxTitle: 'Habilidade',
                      boxValue:
                          controller.pokemonModel.value?.abilities.lastOrNull ??
                              '',
                      boxSvgIcon: 'assets/icons/poke_ball_icon.svg',
                      boxWidth: Get.width / 2 - 15 - 7.5,
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
