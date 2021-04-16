import SpriteKit

public class GameScene: SKScene {
    let label = SKLabelNode()
    var labelText = ["Hi, I'm Sarah and I work as a hardware engineer at Apple.\nThis year I'm responsible for presenting the basics of\nelectronics at WWDC!", "And for that I made a game that teaches the operation of\nLogic Gates. Can you help me to test it?"]
    
    let engenheira = SKSpriteNode(imageNamed: "Engenheira")
    let tipLabel = SKLabelNode()
    var tipText = ["Continue  ➡️", "Start the game️  ▶️"]
    let balaoFala = SKSpriteNode(imageNamed: "Balao de Fala Grande")

    override public func didMove(to view: SKView) {
        self.scene?.backgroundColor = .white
        
        engenheira.setScale(0.5)
        engenheira.position.x = self.frame.maxX - (engenheira.frame.width / 2) - 64
        engenheira.position.y = self.frame.minY + (engenheira.frame.height / 2) + 64
        engenheira.alpha = 1
        balaoFala.setScale(0.42)
        balaoFala.position.x = self.frame.midX - (balaoFala.frame.width / 2) + 100
        balaoFala.position.y = self.frame.midY + 175
        balaoFala.alpha = 1
        label.text = labelText.first
        label.numberOfLines = 0
        label.fontColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.fontName = "AvenirNext"
        label.fontSize = 18
        label.position.x = balaoFala.position.x
        label.position.y = balaoFala.position.y - (label.frame.height / 2)
        addChild(engenheira)
        addChild(balaoFala)
        addChild(label)
        
        
        tipLabel.text = tipText.first
        tipLabel.text?.data(using: String.Encoding.utf16)
        tipLabel.numberOfLines = 0
        tipLabel.fontColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tipLabel.fontName = "AvenirNext"
        tipLabel.fontSize = 18
        tipLabel.position.x = self.frame.maxX - (tipLabel.frame.width / 2) - 64
        tipLabel.position.y = self.frame.minY + (tipLabel.frame.height / 2) + 32
        addChild(tipLabel)
    }

    func touchDown(atPoint pos : CGPoint) {
        if labelText.count > 1 {
            labelText.removeFirst()
            tipText.removeFirst()
            
            label.text = labelText.first
            label.position.x = balaoFala.position.x
            label.position.y = balaoFala.position.y - (label.frame.height / 2)

            tipLabel.text = tipText.first
        } else {
            if let nextGameScene = NotGameScene(fileNamed: "GameScene") {
                nextGameScene.scaleMode = .aspectFit
                self.scene?.view?.presentScene(nextGameScene, transition: SKTransition.fade(withDuration: TimeInterval(1)))
            }
        }
    }

    func touchMoved(toPoint pos : CGPoint) {
        
    }

    func touchUp(atPoint pos : CGPoint) {
        
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }

    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }

    override public func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

