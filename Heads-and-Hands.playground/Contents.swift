let maxHealth = 100

protocol Creature {
    var attack: Int { get set }
    var protection: Int { get set }
    var health: Int { get set }
    var name: String { get set }
    
    func getRandom() -> Int
    func damage() -> Int
}


class Player: Creature {
    
    private var counterOfHeal = 3
    var name: String
    var attack: Int
    var protection: Int
    var health: Int
    
    init(name: String) {
        self.attack = Int.random(in: 1...20)
        self.protection = Int.random(in: 1...20)
        self.health = maxHealth
        self.name = name
    }
    
    func getRandom() -> Int {
        return Int.random(in: 1...20)
    }
    
    func damage() -> Int {
        return Int.random(in: 20..<maxHealth)
    }
    
    func heal() {
        if self.counterOfHeal > 0 {
            self.health += maxHealth / 2
            if self.health > 100 {
                self.health = 100
            }
            self.counterOfHeal -= 1
        } else {
            print("Heal spell is empty!")
        }
    }
}

class Monster: Creature {
    
    var name: String
    var attack: Int
    var protection: Int
    var health: Int
    
    init() {
        self.attack = Int.random(in: 1...20)
        self.protection = Int.random(in: 1...20)
        self.health = maxHealth
        self.name = "Monster"
    }
    
    func getRandom() -> Int {
        return Int.random(in: 1...20)
    }
    
    func damage() -> Int {
        return Int.random(in: 20..<maxHealth)
    }
    
}

class Game {
    
    var attacker: Creature
    var defender: Creature
    
    init(attacker: Creature, defender: Creature) {
        self.attacker = attacker
        self.defender = defender
    }
    
    private func getModificator() -> Int {
        if ((self.attacker.attack - self.defender.protection) + 1) < 1 {
            return 1
        } else {
            return (self.attacker.attack - self.defender.protection) + 1
        }
    }
    
    func swapAttacker() {
        let attacker = self.attacker
        self.attacker = self.defender
        self.defender = attacker
    }
    
    func getAttack() {
        if getSuccess() {
            let damage = self.attacker.damage()
            print("Damage dealt: \(damage)")
            self.defender.health -= damage
            self.getInfo()
        } else {
            print("Attack is missed")
            self.getInfo()
        }
    }
    
    func getSuccess() -> Bool {
        let modificator = self.getModificator()
        for _ in 1...modificator {
            let random = Int.random(in: 1..<7)
            if  random > 4 {
                return true
            }
        }
        return false
    }
    
    func getInfo() {
        print("""
            Attacker Info:
            name: \(self.attacker.name)
            protection: \(self.attacker.protection)
            attack: \(self.attacker.attack)
            health: \(self.attacker.health)
            
            Defender Info:
            name: \(self.defender.name)
            protection: \(self.defender.protection)
            attack: \(self.defender.attack)
            health: \(self.defender.health)
            """
        )
    }
}


let player = Player(name: "Olga Gurtueva")
let monster = Monster()
let game = Game(attacker: player, defender: monster)

//Game check
var flag: Bool = false
while player.health > 0 {
    if monster.health < 1 {
        flag = true
        break
    } else {
        print(game.getAttack())
        game.swapAttacker()
    }
}
if flag {
    print("\(player.name) win!")
} else {
    print("\(monster.name) win!")
}
