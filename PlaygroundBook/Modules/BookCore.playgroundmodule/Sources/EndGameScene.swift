import SpriteKit

public class EndGameScene: SKScene {
    let fadeIn = SKAction.fadeIn(withDuration: 0.15)
    let fadeOut = SKAction.fadeOut(withDuration: 0.15)
    let slowFadeIn = SKAction.fadeIn(withDuration: 1)

    let labelThanks = SKLabelNode(text: "Thank you for playing!")
    
    let brand = SKSpriteNode(imageNamed: "Brand")

    override public func didMove(to view: SKView) {
        self.scene?.backgroundColor = .white
        
        brand.setScale(0.5)
        brand.position.x = self.frame.midX
        brand.position.y = self.frame.midY
        brand.alpha = 1
        brand.zPosition = 50
        addChild(brand)
        
        labelThanks.numberOfLines = 0
        labelThanks.fontColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        labelThanks.fontName = "AvenirNext"
        labelThanks.fontSize = 40
        labelThanks.position.x = self.frame.midX
        labelThanks.position.y = self.frame.midY + brand.frame.maxX + 48
        labelThanks.zPosition = 50
        addChild(labelThanks)
        
        var gates = ["NOT", "AND", "OR", "XOR", "NAND", "NOR", "XNOR"]
        for i in 0...6 {
            let index = Int.random(in: 0...(gates.count-1))
            let gate = gates[index]
            gates.remove(at: index)
            let posX = Int(self.frame.minX + 150) + (175 * i)
            self.addParticle(pos: CGPoint(x: posX, y: Int(self.frame.minY) + 150), gate: gate)
        }
    }

    func loadParticle(named: String) -> SKEmitterNode? {
        guard let path = Bundle.main.path(forResource: named, ofType: "sks") else { return nil }

        return NSKeyedUnarchiver.unarchiveObject(withFile: path) as? SKEmitterNode
    }

    func addParticle(pos: CGPoint, gate: String) {
        let emitterNode = loadParticle(named: "Celebration Gates")! // Criação da aurora
        emitterNode.targetNode = self // Onde vai emitir as particulas
        emitterNode.particleLifetime = 10
        emitterNode.position = pos
        let emotion = ["HAPPY", "SAD", "ANGRY", "IMPRESSED"].randomElement() ?? "IMPRESSED"
        emitterNode.particleTexture = SKTexture(imageNamed: "GATE_\(gate)_\(emotion)")
        emitterNode.zPosition = 1
        
        addChild(emitterNode)
    }

    func touchDown(atPoint pos : CGPoint) {}

    func touchMoved(toPoint pos : CGPoint) {}

    func touchUp(atPoint pos : CGPoint) {}

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

