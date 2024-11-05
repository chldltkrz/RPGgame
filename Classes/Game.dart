import 'Character.dart';
import 'Monster.dart';

class Game {
  late Character character;
  late List<Monster> monsters;
  late int defeatedMonsters;

  void startGame() {}
  void battle() {}
  Monster getRandomMonster() {
    return Monster("Goblin", 100, 10);
  }
  
}
