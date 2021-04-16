import SpriteKit

public class EnergySwitch: SKSpriteNode {
    
    public var clickSwitch: SKSpriteNode!
    public var state = EnergyState.OFF
    public var clickTime: DispatchTime = .now()
    let clickSoundOn = SKAction.playSoundFileNamed("Click On.mp3", waitForCompletion: false)
    let clickSoundOff = SKAction.playSoundFileNamed("Click Off.mp3", waitForCompletion: false)

    init(scale: CGFloat = 1) {
        let texture = SKTexture(imageNamed: "Switch_OFF")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.setScale(scale)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setSwitchState(_ state: EnergyState) {
        switch state {
        case .ON:
            self.texture = SKTexture(imageNamed: "Switch_ON")
            self.state = .ON
        default:
            self.texture = SKTexture(imageNamed: "Switch_OFF")
            self.state = .OFF
        }
    }

    func touchDown(atPoint pos : CGPoint) {
        if (clickSwitch != nil && clickSwitch.contains(pos)) || self.contains(pos) {
            self.clickTime = .now()
            switch self.state {
            case .OFF:
                setSwitchState(.ON)
                self.run(self.clickSoundOn)
            default:
                setSwitchState(.OFF)
                self.run(self.clickSoundOff)
            }
        }
    }
    
    func touchDown(atPoint pos : CGPoint, completion block: @escaping () -> Void) {
        if (clickSwitch != nil && clickSwitch.contains(pos)) || self.contains(pos) {
            touchDown(atPoint: pos)
            block()
        }
    }

    func touchMoved(toPoint pos : CGPoint) {
        return
    }

    func touchUp(atPoint pos : CGPoint) {
        return
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {touchDown(atPoint: t.location(in: self)) }
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
}
