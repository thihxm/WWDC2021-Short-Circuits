import SpriteKit

public class AndNotGameScene: SKScene {

    var dragging: SKSpriteNode!

    let fadeIn = SKAction.fadeIn(withDuration: 0.15)
    let fadeOut = SKAction.fadeOut(withDuration: 0.15)
    let slowFadeIn = SKAction.fadeIn(withDuration: 1)

    let PCB_tutorialNOT = SKSpriteNode(imageNamed: "PCB_Tutorial-2-INPUTS-NOT")
    let energyLineLeft = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 4, height: 4))
    var emitterNodeInput1_1: SKEmitterNode?
    var emitterNodeInput1_2: SKEmitterNode?
    var emitterNodeInput1_3: SKEmitterNode?
    var emitterNodeInput2_1: SKEmitterNode?
    var emitterNodeInput2_2: SKEmitterNode?
    var emitterNodeInput2_3: SKEmitterNode?
    var emitterNodeOutput1: SKEmitterNode?
    var emitterNodeOutput2: SKEmitterNode?
    var emitterInput1_ReachedEnd = false
    var emitterInput2_ReachedEnd = false
    var emitterOutput1_ReachedEnd = false

    let energySwitch1 = EnergySwitch(scale: 0.3)
    let energySwitch2 = EnergySwitch(scale: 0.3)
    

    let led_ON = SKSpriteNode(imageNamed: "LED_ON")
    let led_OFF = SKSpriteNode(imageNamed: "LED_OFF")

    let GATE_DEFAULT_SCALE: CGFloat = 0.31
    let GATE_DRAGGING_SCALE: CGFloat = 0.34
    let gate_OUTLINE = SKSpriteNode(imageNamed: "GATE_OUTLINE")
    let gate_OUTLINE2 = SKSpriteNode(imageNamed: "GATE_OUTLINE")

    let gate_AND = AndGate(defaultScale: 0.31, draggingScale: 0.34)
    let gate_NOT = NotGate(defaultScale: 0.23, draggingScale: 0.26)
    
    let label = SKLabelNode()
    let labelText = "This circuit works like the AND Gate, but inverted!\nIt works when at least one signal is off!"
    
    let engenheira = SKSpriteNode(imageNamed: "Engenheira")
    let winLabel = SKLabelNode()
    let winLabelText = "You're so helpful!\nThe next gate is available.\n\nNext  ➡️"
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
        
        gate_OUTLINE2.setScale(0.23)
        gate_OUTLINE2.position.x = self.frame.midX + 234
        gate_OUTLINE2.position.y = self.frame.midY + 100
        gate_OUTLINE2.alpha = 1
        addChild(gate_OUTLINE2)
        
        energySwitch1.position.x = self.frame.midX - 405
        energySwitch1.position.y = self.frame.midY + 195
        energySwitch1.setSwitchState(.OFF)
        addChild(energySwitch1)
        
        energySwitch2.position.x = self.frame.midX - 405
        energySwitch2.position.y = self.frame.midY + 9
        energySwitch2.setSwitchState(.OFF)
        addChild(energySwitch2)
        
        
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
        
        gate_AND.position.x = self.frame.midX - 100
        gate_AND.position.y = self.frame.midY - 300
        gate_AND.intersectionNode = gate_OUTLINE
        addChild(gate_AND)
        
        gate_NOT.position.x = self.frame.midX + 100
        gate_NOT.position.y = self.frame.midY - 300
        gate_NOT.intersectionNode = gate_OUTLINE2
        addChild(gate_NOT)
        
        let centeredText = NSMutableAttributedString(string: labelText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let range = NSRange(location: 0, length: labelText.count)
        centeredText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        centeredText.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)], range: range)
        label.attributedText = centeredText
        label.fontName = "AvenirNext"
        label.fontSize = 16
        label.fontColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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

        energySwitch1.setSwitchState(.ON)
        energySwitch1.clickTime = .now()
        setSwitch1EmittersState(.ON)
        energySwitch2.setSwitchState(.ON)
        energySwitch2.clickTime = .now()
        setSwitch2EmittersState(.ON)
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

    func addEnergy(pos: CGPoint, lifetime: CGFloat, parentEmitterNode: inout SKEmitterNode?) {
        parentEmitterNode?.removeFromParent()
        let emitterNode = loadParticle(named: "Energia")! // Criação da aurora
        emitterNode.targetNode = self // Onde vai emitir as particulas
        emitterNode.particleLifetime = lifetime
        emitterNode.position = pos
        
        parentEmitterNode = emitterNode
        addChild(emitterNode)
    }
    
    func addEnergy(pos: CGPoint, lifetime: CGFloat, parentEmitterNode: inout SKEmitterNode?, angle: CGFloat) {
        parentEmitterNode?.removeFromParent()
        let emitterNode = loadParticle(named: "Energia")! // Criação da aurora
        emitterNode.targetNode = self // Onde vai emitir as particulas
        emitterNode.particleLifetime = lifetime
        emitterNode.position = pos
        emitterNode.emissionAngle = angle
        
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
        if gate_AND.isGateInPosition && !gate_NOT.isGateInPosition {
            gate_AND.setGateState(.angry)
        } else if !gate_AND.isGateInPosition && gate_NOT.isGateInPosition {
            gate_NOT.setGateState(.angry)
        }
        if gate_AND.isGateInPosition && gate_NOT.isGateInPosition {
            if (energySwitch1.state == .ON && emitterInput1_ReachedEnd) && (energySwitch2.state == .ON && emitterInput2_ReachedEnd) {
                if self.emitterNodeOutput1 == nil {
                    addEnergy(pos: CGPoint(x: 81, y: 100), lifetime: 0.34, parentEmitterNode: &self.emitterNodeOutput1)
                    
                    let energyEmitterOutput_ReachedEnd = DispatchWorkItem {
                        if (self.energySwitch1.state == .ON && self.emitterInput1_ReachedEnd) && (self.energySwitch2.state == .ON && self.emitterInput2_ReachedEnd) && self.gate_AND.isGateInPosition && self.gate_NOT.isGateInPosition {
                            self.gate_NOT.setGateState(.angry)
                            self.setLedState(.OFF)
                            self.gate_AND.setGateState(.happy)
                            self.gate_NOT.setGateState(.angry)
                            self.emitterNodeOutput2?.removeFromParent()
                            self.emitterNodeOutput2 = nil
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.40, execute: energyEmitterOutput_ReachedEnd)
                }
                
                gate_AND.setGateState(.happy)
                self.gate_NOT.setGateState(.angry)
            } else {
                if self.emitterNodeOutput2 == nil {
                    self.addEnergy(pos: CGPoint(x: 296, y: 100), lifetime: 0.34, parentEmitterNode: &self.emitterNodeOutput2)
                    let energyEmitterOutput2_ReachedEnd = DispatchWorkItem {
                        if (self.energySwitch1.state == .OFF || self.energySwitch2.state == .OFF) && (self.gate_AND.isGateInPosition && self.gate_NOT.isGateInPosition) {
                            self.setLedState(.ON)
                            
                            self.run(self.nextLevelSound)
                            self.balaoFala.run(self.slowFadeIn)
                            self.winLabel.run(self.slowFadeIn)
                            self.engenheira.run(self.slowFadeIn)
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.40, execute: energyEmitterOutput2_ReachedEnd)
                }
                
                self.gate_AND.setGateState(.angry)
                self.gate_NOT.setGateState(.happy)
                self.emitterNodeOutput1?.removeFromParent()
                self.emitterNodeOutput1 = nil
            }
        } else {
            emitterNodeOutput1?.removeFromParent()
            self.emitterNodeOutput1 = nil
            self.emitterNodeOutput2?.removeFromParent()
            self.emitterNodeOutput2 = nil
            led_OFF.removeAllActions()
            led_ON.removeAllActions()
            led_OFF.run(fadeIn)
            led_ON.run(fadeOut)
            
            setLedState(.OFF)
        }
    }
    
    func setSwitch1EmittersState(_ state: EnergyState) {
        switch state {
        case .ON:
            let energyEmitterInput1_2 = DispatchWorkItem {
                if self.energySwitch1.state == .ON && self.emitterNodeInput1_1 != nil && self.energySwitch1.clickTime + 0.8067 <= .now() {
                    self.addEnergy(pos: CGPoint(x: -175, y: 192), lifetime: 0.23, parentEmitterNode: &self.emitterNodeInput1_2, angle: -1.5708)
                }
            }
            let energyEmitterInput1_3 = DispatchWorkItem {
                if self.energySwitch1.state == .ON && self.emitterNodeInput1_2 != nil && self.energySwitch1.clickTime + 1.0934 <= .now() {
                    self.addEnergy(pos: CGPoint(x: -175, y: 130), lifetime: 0.36, parentEmitterNode: &self.emitterNodeInput1_3)
                }
            }
            let energyEmitterInput1_ReachedEnd = DispatchWorkItem {
                if self.energySwitch1.state == .ON && self.emitterNodeInput1_3 != nil && self.energySwitch1.clickTime + 1.5201 <= .now() {
                    self.emitterInput1_ReachedEnd = true
                    self.checkSolution()
                }
            }
            
            self.addEnergy(pos: CGPoint(x: -385, y: 192), lifetime: 0.74, parentEmitterNode: &self.emitterNodeInput1_1)
            DispatchQueue.main.asyncAfter(deadline: self.energySwitch1.clickTime + 0.8067, execute: energyEmitterInput1_2)
            DispatchQueue.main.asyncAfter(deadline: self.energySwitch1.clickTime + 1.0934, execute: energyEmitterInput1_3)
            DispatchQueue.main.asyncAfter(deadline: self.energySwitch1.clickTime + 1.5201, execute: energyEmitterInput1_ReachedEnd)
        default:
            self.emitterNodeInput1_1?.removeFromParent()
            self.emitterNodeInput1_1 = nil
            self.emitterNodeInput1_2?.removeFromParent()
            self.emitterNodeInput1_2 = nil
            self.emitterNodeInput1_3?.removeFromParent()
            self.emitterNodeInput1_3 = nil
        }
    }
    
    func setSwitch2EmittersState(_ state: EnergyState) {
        switch state {
        case .ON:
            let energyEmitterInput2_2 = DispatchWorkItem {
                if self.energySwitch2.state == .ON && self.emitterNodeInput2_1 != nil && self.energySwitch2.clickTime + 0.8067 <= .now() {
                    self.addEnergy(pos: CGPoint(x: -175, y: 8), lifetime: 0.23, parentEmitterNode: &self.emitterNodeInput2_2, angle: 1.5708)
                }
            }
            let energyEmitterInput2_3 = DispatchWorkItem {
                if self.energySwitch2.state == .ON && self.emitterNodeInput2_2 != nil && self.energySwitch2.clickTime + 1.0934 <= .now() {
                    self.addEnergy(pos: CGPoint(x: -175, y: 70), lifetime: 0.36, parentEmitterNode: &self.emitterNodeInput2_3)
                }
            }
            let energyEmitterInput2_ReachedEnd = DispatchWorkItem {
                if self.energySwitch2.state == .ON && self.emitterNodeInput2_3 != nil && self.energySwitch2.clickTime + 1.5201 <= .now() {
                    self.emitterInput2_ReachedEnd = true
                    self.checkSolution()
                }
            }
            
            self.addEnergy(pos: CGPoint(x: -385, y: 8), lifetime: 0.74, parentEmitterNode: &self.emitterNodeInput2_1)
            DispatchQueue.main.asyncAfter(deadline: self.energySwitch2.clickTime + 0.8067, execute: energyEmitterInput2_2)
            DispatchQueue.main.asyncAfter(deadline: self.energySwitch2.clickTime + 1.0934, execute: energyEmitterInput2_3)
            DispatchQueue.main.asyncAfter(deadline: self.energySwitch2.clickTime + 1.5201, execute: energyEmitterInput2_ReachedEnd)
        default:
            self.emitterNodeInput2_1?.removeFromParent()
            self.emitterNodeInput2_1 = nil
            self.emitterNodeInput2_2?.removeFromParent()
            self.emitterNodeInput2_2 = nil
            self.emitterNodeInput2_3?.removeFromParent()
            self.emitterNodeInput2_3 = nil
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        gate_AND.touchDown(atPoint: pos)
        gate_NOT.touchDown(atPoint: pos)

        energySwitch1.touchDown(atPoint: pos, completion: {
            if self.energySwitch1.state == .ON {
                self.setSwitch1EmittersState(.ON)
            } else {
                self.emitterInput1_ReachedEnd = false
                self.setSwitch1EmittersState(.OFF)
            }
        })
        energySwitch2.touchDown(atPoint: pos, completion: {
            if self.energySwitch2.state == .ON {
                self.setSwitch2EmittersState(.ON)
            } else {
                self.emitterInput2_ReachedEnd = false
                self.setSwitch2EmittersState(.OFF)
            }
        })
        
        if balaoFala.contains(pos) && balaoFala.alpha > 0.2 {
            if let nextGameScene = NandGameScene(fileNamed: "GameScene") {
                nextGameScene.scaleMode = .aspectFit
                self.scene?.view?.presentScene(nextGameScene, transition: SKTransition.fade(withDuration: TimeInterval(1)))
            }
        }

        checkSolution()
    }

    func touchMoved(toPoint pos : CGPoint) {
        gate_AND.touchMoved(toPoint: pos)
        gate_NOT.touchMoved(toPoint: pos)
        checkSolution()
    }

    func touchUp(atPoint pos : CGPoint) {
        gate_AND.touchUp(atPoint: pos)
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

