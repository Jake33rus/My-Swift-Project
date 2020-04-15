class Player {
    
    let name: String
    let game: String
    let age: Int
    
    var playerInfo: String {
        let playerInfo = """
        Player name is \(name).
        He playes \(game).
        He is \(age) years old.
        """
        return playerInfo
    }
    
    init(name: String, game: String, age: Int){
        self.name = name
        self.game = game
        self.age = age
    }
}

protocol PolitePlayer {
    var friends: [Player] { get }
    var haveAFriend: Bool { get }
    
    func smile()
    func apologize() -> String
}

class ProfessionalPlayer: Player {
    let exp: Int
    let retirementAge: Int
    
    init(name: String, game: String, age: Int, exp: Int, retirementAge: Int) {
        self.exp = exp
        self.retirementAge = retirementAge
        super.init(name: name, game: game, age: age)
    }
}

extension ProfessionalPlayer: PolitePlayer {
    var friends: [Player] {
        return [Player(name:"Alex", game: "Dota", age: 19)]
    }
    var haveAFriend: Bool {
        return !friends.isEmpty
    }
    
    func smile(){
        print("Улыбнемся вместе")
    }
    
    func apologize() -> String {
        return "Sorry, friend!"
    }
}

let player = Player(name: "Evgeny", game: "Dota2", age: 22)
print(player.playerInfo)



let proPlayer = ProfessionalPlayer(name: "Kostya", game: "Dota 2", age: 22, exp: 7, retirementAge: 35)
print(proPlayer.playerInfo)
proPlayer.smile()
proPlayer.apologize()
