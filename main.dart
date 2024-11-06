import 'dart:io';
import 'dart:math';

import 'Classes/Character.dart';
import 'Classes/Game.dart';
import 'Classes/Monster.dart';

void main() {
  // get character name and read character stat from file and create character object
  print("Enter Character Name: ");
  Character c = loadCharacterStats();
  // read monster stats from file and create monster objects
  List<Monster> m = loadMonsters(c.DP);

  // initiate game object and start game
  Game g = Game(c, m);
  g.startGame();
}

Character loadCharacterStats() {
  // read character stats from file
  try {
    final file = File('Assets/character.txt');
    final contents = file.readAsStringSync();
    final stats = contents.split(',');
    // check if the character data is valid
    // if num of column is not 3, throw exception
    if (stats.length != 3) throw FormatException('Invalid character data');

    // initialize character object
    int health = int.parse(stats[0]);
    int attack = int.parse(stats[1]);
    int defense = int.parse(stats[2]);
    String name;

    // check until the user enters a valid name
    while (true) {
      print("캐릭터의 이름을 입력하세요: ");
      name = stdin.readLineSync()!;
      bool nameConvention = RegExp(r'^[a-zA-Z가-힣]+$').allMatches(name).isEmpty;
      if (nameConvention) {
        print("Invalid Name, retry");
        continue;
      } else {
        break;
      }
    }
    // ADVANCED FEATURE
    // give extra 10 points of health to the character on 30% of chance
    if (Random.secure().nextDouble() < 0.3) {
      health += 10;
      print("보너스 체력을 얻었습니다! 현재 체력: ${health}");
    }

    // return character object
    return Character(name, health, attack, defense);
  } catch (e) {
    print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
    exit(1);
  }
}

// note that there is characterDefense parameter for setting monster AP
List<Monster> loadMonsters(int characterDefense) {
  List<Monster> monsters = [];
  try {
    final file = File('Assets/monsters.txt');
    // there are mnultiple monster data in the file so run it in for loop
    for (final line in file.readAsStringSync().split('\n')) {
      final stats = line.split(',');
      if (stats.length != 3) throw FormatException('Invalid monster data');

      String name = stats[0].toString();
      int health = int.parse(stats[1]);
      int attack = int.parse(stats[2]);
      // AP should be at least the same as character's DP
      attack = max(characterDefense, Random.secure().nextInt(attack));
      monsters.add(Monster(name, health, attack));
      monsters.toString();
    }
    return monsters;
  } catch (e) {
    print('몬스터 데이터를 불러오는 데 실패했습니다: $e');
    exit(1);
  }
}
