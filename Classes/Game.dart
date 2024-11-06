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
    // need to check if all monsters have been defeated
    int totalMonsters = monsters.length;
    print("게임을 시작합니다!");
    character.showStatus();
    print("\n");

    // loop until character HP is 0 or less
    while (character.HP > 0) {
      // create a monster
      print("새로운 몬스터가 나타났습니다!");
      Monster m = getRandomMonster();
      m.showStatus();
      print("\n");

      // run battle with the monster and save result to result int
      int result = battle(m);

      // check if the result is 0, if so, print defeat message and break
      if (result == 0) {
        print("패배했습니다.");
        break;
        // else print victory message and increment defeatedMonsters
      } else {
        print("${m.name} 을(를) 물리쳤습니다!\n");
        defeatedMonsters++;
        // if all monsters have been defeated, print victory message and break
        if (defeatedMonsters == totalMonsters) {
          print("축하합니다! 모든 몬스터를 물리쳤습니다!");
          break;
        } else {
          while (true) {
            print("다음 몬스터와 싸우시겠습니까?(y/n)");
            String? next = stdin.readLineSync();
            if (next == "y") {
              break;
            } else if (next == "n") {
              print("게임을 종료합니다.");
              break;
            } else {
              print("잘못된 입력입니다.");
              continue;
            }
          }
        }
      }
    }
    // after all the battles, ask if the user wants to save the result
    print("결과를 저장하시겠습니까?(y/n)");
    while (true) {
      try {
        String? save = stdin.readLineSync();
        if (save == "y") {
          String gameResult = character.name +
              "," +
              character.HP.toString() +
              "," +
              (defeatedMonsters == totalMonsters ? "WIN" : "LOSE");
          File file = File('Assets/result.txt');
          file.writeAsStringSync("${gameResult}\n", mode: FileMode.append);
          break;
        } else if (save == "n") {
          print("게임을 종료합니다");
          break;
        } else {
          throw FormatException("잘못된 입력입니다");
        }
      } catch (e) {
        continue;
      }
    }
  }

  int battle(Monster monster) {
    // keeping track of turns
    int turn = 0;
    // Keeping track of item usage
    int itemUsed = 0;
    // loop until character HP is 0 or less
    // if character HP is 0 or less, it means the character is defeated
    // then return 0
    while (character.HP > 0) {
      // changing turns between character and monster
      if (turn % 2 == 0) {
        print('${character.name}의 턴');
        print("행동을 선택하세요 (1. 공격 2. 방어 3.아이템)");
        String? choice = stdin.readLineSync();
        if (choice == "1") {
          character.attackMonster(
              monster, Random.secure().nextInt(character.AP));
          // ADVANCED FEATURE - using an item
          // if item is used reset the AP
          // note that if itemUsed is 1, it means the item has been used
          // and 2 means the item has been used and AP has been reset
          if (itemUsed == 1) {
            character.AP ~/= 2;
            itemUsed++;
          }
          if (monster.HP <= 0) {
            return 1;
          }
        } else if (choice == "2") {
          character.defend(Random.secure().nextInt(character.DP));
          // ADVANCED FEATURE - using an item
        } else if (choice == "3") {
          if (itemUsed == 0) {
            character.AP *= 2;
            itemUsed++;
            print("아이템을 사용했습니다. 공격력이 2배가 됩니다. 현재 공격력: ${character.AP}");
          } else {
            print("아이템은 한 번만 사용할 수 있습니다.");
          }
        } else {
          print("잘못된 입력입니다.");
        }
      } else {
        print('${monster.name}의 턴');
        monster.attackCharacter(character, Random.secure().nextInt(monster.AP));
        character.showStatus();
        monster.showStatus();
      }
      turn++;
      print("\n");
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
