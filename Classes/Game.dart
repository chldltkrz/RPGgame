import 'dart:io';
import 'dart:math';

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
  void startGame() {
    int totalMonsters = monsters.length;
    print("게임을 시작합니다!");
    character.showStatus();

    while (character.HP > 0) {
      print("새로운 몬스터가 나타났습니다!");
      Monster m = getRandomMonster();
      m.showStatus();

      int result = battle(m);

      if (result == 0) {
        print("패배했습니다.");
        break;
      } else {
        print("${m.name} 을(를) 물리쳤습니다!");
        defeatedMonsters++;
        if (defeatedMonsters == totalMonsters) {
          print("축하합니다! 모든 몬스터를 물리쳤습니다!");
          break;
        } else {
          print("다음 몬스터와 싸우시겠습니까?(y/n)");
          String? next = stdin.readLineSync();
          if (next == "n") {
            print("게임을 종료합니다.");
            break;
          }
        }
      }
    }
    print("결과를 저장하시겠습니까?(y/n)");
    String? save = stdin.readLineSync();
    if (save == "y") {
      String gameResult = character.name +
          "," +
          character.HP.toString() +
          "," +
          (defeatedMonsters == totalMonsters ? "WIN" : "LOSE");
      File file = File('Assets/result.txt');
      file.writeAsStringSync("${gameResult}\n", mode: FileMode.append);
    } else {
      print("게임을 종료합니다.");
    }
  }

  int battle(Monster monster) {
    int turn = 0;
    while (character.HP > 0) {
      if (turn % 2 == 0) {
        print("행동을 선택하세요 (1. 공격 2. 방어)");
        String? choice = stdin.readLineSync();
        if (choice == "1") {
          character.attackMonster(
              monster, Random.secure().nextInt(character.AP));
          if (monster.HP <= 0) {
            return 1;
          }
        } else if (choice == "2") {
          character.defend(Random.secure().nextInt(character.DP));
        } else {
          print("잘못된 입력입니다.");
        }
      } else {
        monster.attackCharacter(character, Random.secure().nextInt(monster.AP));
        character.showStatus();
        monster.showStatus();
      }
      turn++;
    }
    return 0;
  }

  Monster getRandomMonster() {
    int randomMonsterIndex = Random.secure().nextInt(monsters.length);
    Monster m = monsters.elementAt(randomMonsterIndex);
    monsters.removeAt(randomMonsterIndex);
    return m;
  }
}
