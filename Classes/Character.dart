import 'Monster.dart';

class Character {
  String name;
  int HP;
  int AP;
  int DP;

  Character(this.name, this.HP, this.AP, this.DP);

  void attackMonster(Monster monster, int damage) {
    monster.HP -= damage;
  }

  void defend(int point) {
    this.HP += point;
  }

  showStatus() {
    print("${this.name} - 체력: ${this.HP} 공격력: ${this.AP} 방어력: ${this.DP}");
  }
}
