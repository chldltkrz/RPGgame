import 'Monster.dart';

class Character {
  String name;
  int HP;
  int AP;
  int DP;

  Character(this.name, this.HP, this.AP, this.DP);

  void attackMonster(Monster monster) {
    monster.HP -= this.AP;
  }

  void defend() {
    this.DP += 10;
  }

  showStatus() {
    print("Name: ${this.name}");
    print("HP: ${this.HP}");
    print("AP: ${this.AP}");
    print("DP: ${this.DP}");
  }
}
