import 'dart:math';

import 'Monster.dart';

class Character {
  String name;
  int HP;
  int AP;
  int DP;

  Character(this.name, this.HP, this.AP, this.DP);

  void attackMonster(Monster monster, int damage) {
    // ADVANCED FEATURE - monster DP is subtracted from the damage
    monster.HP = monster.HP - (damage) + Random.secure().nextInt(monster.DP);
  }

  void defend(int point) {
    this.HP += point;
  }

  showStatus() {
    print("${this.name} - 체력: ${this.HP} 공격력: ${this.AP} 방어력: ${this.DP}");
  }
}
