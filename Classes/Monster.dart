import 'Character.dart';

class Monster {
  String name;
  int HP;
  int AP;
  int DP = 0;

  Monster(this.name, this.HP, this.AP);

  attackCharacter(Character character, int damage) {
    character.HP -= damage;
  }

  void showStatus() {
    print("${this.name} - 체력: ${this.HP}, 공격력 ${this.AP}, 방어력 ${this.DP}");
  }
}
