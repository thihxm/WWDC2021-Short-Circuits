import SpriteKit

public class NotGameScene: SKScene {

    var dragging: SKSpriteNode!
    var isGateInPosition = false;

    let fadeIn = SKAction.fadeIn(withDuration: 0.15)
    let fadeOut = SKAction.fadeOut(withDuration: 0.15)
    let slowFadeIn = SKAction.fadeIn(withDuration: 1)

    let PCB_tutorialNOT = SKSpriteNode(imageNamed: "PCB_Tutorial-NOT")
    let energyLineLeft = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 4, height: 4))
    let btn = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 60, height: 60))
    var emitterNodeLeft: SKEmitterNode?
    var emitterNodeOutput: SKEmitterNode?

    let energySwitch = EnergySwitch(scale: 0.3)

    let led_ON = SKSpriteNode(imageNamed: "LED_ON")
    let led_OFF = SKSpriteNode(imageNamed: "LED_OFF")

    let GATE_DEFAULT_SCALE: CGFloat = 0.31
    let GATE_DRAGGING_SCALE: CGFloat = 0.34
    let gate_OUTLINE = SKSpriteNode(imageNamed: "GATE_OUTLINE")

    let gate_NOT = NotGate(defaultScale: 0.31, draggingScale: 0.34)

    let label = SKLabelNode()
    let labelText = "This is the NOT Gate, it does not like energy signals\nand because of that it does not work when they are on!"
    
    let engenheira = SKSpriteNode(imageNamed: "Engenheira")
    let winLabel = SKLabelNode()
    let winLabelText = "WOW, you got it!\nThis was easy, let's try the next gate!\n\nNext  ➡️"
    let balaoFala = SKSpriteNode(imageNamed: "Balao de Fala")
    
    let nextLevelSound = SKAction.playSoundFileNamed("Next Level.mp3", waitForCompletion: false)

    override public func didMove(to view: SKView) {
        self.scene?.backgroundColor = .white

        PCB_tutorialNOT.setScale(0.4)
        PCB_tutorialNOT.position.x = self.frame.midX
        PCB_tutorialNOT.position.y = self.frame.midY + 100
        addChild(PCB_tutorialNOT)
        
        gate_OUTLINE.setScale(GATE_DEFAULT_SCALE)
        gate_OUTLINE.position.x = self.frame.midX
        gate_OUTLINE.position.y = self.frame.midY + 100
        gate_OUTLINE.alpha = 1
        addChild(gate_OUTLINE)
        
        energySwitch.position.x = self.frame.midX - 405
        energySwitch.position.y = self.frame.midY + 100
        energySwitch.setSwitchState(.ON)
        addChild(energySwitch)
        addEnergy(pos: CGPoint(x: -385, y: 100), parentEmitterNode: &emitterNodeLeft)
        
        
        led_ON.setScale(0.3)
        led_ON.position.x = self.frame.midX + 435
        led_ON.position.y = self.frame.midY + 100
        led_ON.alpha = 0
        addChild(led_ON)
        led_OFF.setScale(0.3)
        led_OFF.position.x = self.frame.midX + 435
        led_OFF.position.y = self.frame.midY + 100
        led_OFF.alpha = 1
        addChild(led_OFF)
        
        energyLineLeft.fillColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 0.65)
        energyLineLeft.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        energyLineLeft.position = CGPoint(x: 62, y: 100)
        energyLineLeft.alpha = 0
        addChild(energyLineLeft)
        
        gate_NOT.position.x = self.frame.midX
        gate_NOT.position.y = self.frame.midY - 300
        gate_NOT.intersectionNode = gate_OUTLINE
        addChild(gate_NOT)
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let centeredText = NSMutableAttributedString(string: labelText)
        let range = NSRange(location: 0, length: labelText.utf16.count)
        let textFont = UIFont(name: "AvenirNext", size: 16) ?? UIFont.systemFont(ofSize: 16)
        centeredText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        centeredText.addAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), NSAttributedString.Key.font: textFont], range: range)
        label.attributedText = centeredText
        label.numberOfLines = 0
        label.position.x = self.frame.midX
        label.position.y = self.frame.midY - 200
        addChild(label)
        

        engenheira.setScale(0.15)
        engenheira.position.x = self.frame.midX + 550
        engenheira.position.y = self.frame.midY - 400
        engenheira.alpha = 0
        balaoFala.setScale(0.42)
        balaoFala.position.x = self.frame.midX + 365
        balaoFala.position.y = self.frame.midY - 290
        balaoFala.alpha = 0
        
        let centeredWinText = NSMutableAttributedString(string: winLabelText)
        winLabelText.data(using: String.Encoding.utf16)
        let centeredRange = NSRange(location: 0, length: winLabelText.utf16.count)
        let winTextFont = UIFont(name: "AvenirNext", size: 16) ?? UIFont.systemFont(ofSize: 16)
        centeredWinText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: centeredRange)
        centeredWinText.addAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), NSAttributedString.Key.font: winTextFont], range: centeredRange)
        winLabel.attributedText = centeredWinText
        winLabel.numberOfLines = 0
        winLabel.position.x = balaoFala.position.x
        winLabel.position.y = balaoFala.position.y - (winLabel.frame.height / 2)
        winLabel.alpha = 0
        
        addChild(engenheira)
        addChild(balaoFala)
        addChild(winLabel)
    }

    @objc static override public var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }

    func loadParticle(named: String) -> SKEmitterNode? {
        guard let path = Bundle.main.path(forResource: named, ofType: "sks") else { return nil }

        return NSKeyedUnarchiver.unarchiveObject(withFile: path) as? SKEmitterNode
    }

    func addEnergy(pos: CGPoint, parentEmitterNode: inout SKEmitterNode?) {
        parentEmitterNode?.removeFromParent()
        let emitterNode = loadParticle(named: "Energia")! // Criação da aurora
        emitterNode.targetNode = self // Onde vai emitir as particulas
        emitterNode.particleLifetime = 1.1
        emitterNode.position = pos
        
        parentEmitterNode = emitterNode
        addChild(emitterNode)
    }

    func setLedState(_ state: EnergyState) {
        // seconds = emitter.numParticlesToEmit / emitter.particleBirthRate + emitter.particleLifetime + emitter.particleLifetimeRange / 2;
        let seconds = 1.16667
        let delay = SKAction.wait(forDuration: TimeInterval(seconds))
        switch state {
        case .ON:
            self.led_OFF.run(self.fadeOut)
            self.led_ON.run(self.fadeIn)
        default:
            self.led_OFF.run(fadeIn)
            self.led_ON.run(fadeOut)
        }
    }

    func checkSolution() {
        if gate_NOT.isGateInPosition {
            if energySwitch.state == .ON {
                setLedState(.OFF)
                gate_NOT.setGateState(.angry)
                emitterNodeOutput?.removeFromParent()
                self.emitterNodeOutput = nil
            } else {
                if self.emitterNodeOutput == nil {
                    addEnergy(pos: CGPoint(x: 81, y: 100), parentEmitterNode: &self.emitterNodeOutput)
                    let energyEmitterOutput_ReachedEnd = DispatchWorkItem {
                        if (self.energySwitch.state == .OFF) && self.gate_NOT.isGateInPosition {
                            self.setLedState(.ON)
                            
                            self.run(self.nextLevelSound)
                            self.balaoFala.run(self.slowFadeIn)
                            self.winLabel.run(self.slowFadeIn)
                            self.engenheira.run(self.slowFadeIn)
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.1667, execute: energyEmitterOutput_ReachedEnd)
                }
                gate_NOT.setGateState(.happy)
            }
        } else {
            emitterNodeOutput?.removeFromParent()
            self.emitterNodeOutput = nil
            led_OFF.removeAllActions()
            led_ON.removeAllActions()
            led_OFF.run(fadeIn)
            led_ON.run(fadeOut)
            setLedState(.OFF)
        }
    }

    func touchDown(atPoint pos : CGPoint) {
        gate_NOT.touchDown(atPoint: pos)

        energySwitch.touchDown(atPoint: pos, completion: {
            if self.energySwitch.state == .ON {
                self.addEnergy(pos: CGPoint(x: -385, y: 100), parentEmitterNode: &self.emitterNodeLeft)
                self.emitterNodeOutput?.removeFromParent()
                self.emitterNodeOutput = nil
                self.led_OFF.removeAllActions()
                self.led_ON.removeAllActions()
            } else {
                self.emitterNodeLeft?.removeFromParent()
            }
        })
        
        if balaoFala.contains(pos) && balaoFala.alpha > 0.2 {
            if let nextGameScene = AndGameScene(fileNamed: "GameScene") {
                nextGameScene.scaleMode = .aspectFit
                self.scene?.view?.presentScene(nextGameScene, transition: SKTransition.fade(withDuration: TimeInterval(1)))
            }
        }

        checkSolution()
    }

    func touchMoved(toPoint pos : CGPoint) {
        gate_NOT.touchMoved(toPoint: pos)
    }

    func touchUp(atPoint pos : CGPoint) {
        gate_NOT.touchUp(atPoint: pos)
        
        checkSolution()
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

