import 'Character.dart';
import 'Monster.dart';

class Game {
  late Character character;
  late List<Monster> monsters;
  late int defeatedMonsters;

  Game(Character c, List<Monster> m) {
    this.character = c;
    this.monsters = m;
    this.defeatedMonsters = 0;
  }
  void startGame() {}
  void battle() {}
  Monster getRandomMonster() {
    return Monster("Goblin", 100, 10);
  }
}
