import 'Character.dart';

class Monster {
  String name;
  int HP;
  int AP;
  int DP = 0;

  Monster(this.name, this.HP, this.AP);

  attackCharacter(Character character) {
    character.HP -= this.AP;
  }

  void showStatus() {
    print("Name: ${this.name}");
    print("HP: ${this.HP}");
    print("AP: ${this.AP}");
    print("DP: ${this.DP}");
  }
}
