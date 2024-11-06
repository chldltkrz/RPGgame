import 'dart:io';
import 'dart:math';

import 'Classes/Character.dart';
import 'Classes/Game.dart';
import 'Classes/Monster.dart';

void main() {
  print("Enter Character Name: ");
  Character c = loadCharacterStats();
  List<Monster> m = loadMonsters(c.DP);
  // c.showStatus();
  // m.forEach((monster) => monster.showStatus());
  Game g = Game(c, m);
  g.startGame();
}

Character loadCharacterStats() {
  try {
    final file = File('Assets/character.txt');
    final contents = file.readAsStringSync();
    final stats = contents.split(',');
    if (stats.length != 3) throw FormatException('Invalid character data');

    int health = int.parse(stats[0]);
    int attack = int.parse(stats[1]);
    int defense = int.parse(stats[2]);
    print("캐릭터의 이름을 입력하세요: ");
    String name = stdin.readLineSync()!;
    RegExp(r'^[a-zA-Z가-힣]+$').allMatches(name).isEmpty
        ? {print("Invalid Name, Exit Game."), exit(1)}
        : "";
    return Character(name, health, attack, defense);
  } catch (e) {
    print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
    exit(1);
  }
}

List<Monster> loadMonsters(int characterDefense) {
  List<Monster> monsters = [];
  try {
    final file = File('Assets/monsters.txt');
    for (final line in file.readAsStringSync().split('\n')) {
      final stats = line.split(',');
      if (stats.length != 3) throw FormatException('Invalid monster data');

      String name = stats[0].toString();
      int health = int.parse(stats[1]);
      int attack = int.parse(stats[2]);
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
