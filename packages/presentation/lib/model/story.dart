import 'mission.dart';

class Story {
  final String id;
  final String name;
  final String description;
  final List<Mission> missions;

  Story({required this.id, required this.name, required this.description, required this.missions});
}

// TODO
final List<Story> storiesDataTmp = [
  Story(
    id: 'first-story',
    name: 'First Steps of the King Sds asd as d',
    description: 'lorem ipsum...',
    missions: [
      GameMission(
        id: 'Uno',
        name: 'First mission',
        description: 'The description of the first mission goes here, yeye.',
      ),
      GameMission(
        id: 'Dos',
        name: 'Second',
        description: 'The description of the S-E-C-O-N-D mission.',
      ),
      GameMission(
        id: 'Tres',
        name: 'The Third Mission',
        description: 'Yep, 3rd.',
      ),
    ],
  ),
  Story(
    id: 'the-story-continues',
    name: 'Labyrinth of Recursion',
    description: 'blah blah some description here',
    missions: [
      StoryMission(
        id: 'x1',
        name: 'Alpha',
        description: 'Uno uno uno.',
        data: [
          'Some first text.',
          'And here is another.',
          'Third text here.',
          'Lorem ipsum...',
          'and dolor sit amet, yup.',
        ],
      ),
      StoryMission(
        id: 'x2',
        name: 'Bravo',
        description: 'Uno uno uno.',
        data: [
          'Once upon a time',
          'one boy lived a good life',
          'but then',
          'he died...',
        ],
      ),
      GameMission(
        id: 'x3',
        name: 'Charlie',
        description: 'Uno uno uno.',
      ),
      GameMission(
        id: 'x4',
        name: 'Delta',
        description: 'Uno uno uno.',
      ),
      LearningMission(
        id: 'x5',
        name: 'Echo',
        description: 'Uno uno uno.',
        data: "# Fieri armos\n\n## Ab manus lapsa\n\nLorem markdownum [ferebat](http://miseri.org/orion.html): ignemque dictis,\nveneris nympha, ducitur locus tendens, sed. Artus cerae velocibus puto; si sic\nuni colorem Cumarum perosus! Sacerdotis messoris suas Laomedonque sensit ut post\ninquit *de* parientem dixit: cornu nunc.\n\n1. Legit deterior translata superbum tuta nec parenti\n2. Crater poste feres huius\n3. Vix mihi audierit\n4. Agmenque exanimes loqui liquescunt in\n5. Est cepit mersaeque o pomaque pellis tamquam\n6. Precaris concutio age",
      ),
      GameMission(
        id: 'x6',
        name: 'Foxtrot',
        description: 'Uno uno uno.',
      ),
    ],
  ),
];
