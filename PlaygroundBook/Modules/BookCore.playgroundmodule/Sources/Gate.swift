import SpriteKit

public class Gate: SKSpriteNode {

    let gateImagesPrefix: String
    let defaultScale: CGFloat
    let draggingScale: CGFloat

    var isDragging = false
    public var intersectionNode: SKSpriteNode!
    public var isGateInPosition = false
    let inPositionSound = SKAction.playSoundFileNamed("Encaixe.mp3", waitForCompletion: false)

    init(_ gateImagesPrefix: String, defaultScale: CGFloat = 1, draggingScale: CGFloat = 1.05) {
        self.gateImagesPrefix = gateImagesPrefix
        self.defaultScale = defaultScale
        self.draggingScale = draggingScale

        let texture = SKTexture(imageNamed: "\(gateImagesPrefix)_SAD")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.setScale(defaultScale)
    }

    init(_ texture: SKTexture, gateImagesPrefix: String, defaultScale: CGFloat = 1, draggingScale: CGFloat = 1.05) {
        self.gateImagesPrefix = gateImagesPrefix
        self.defaultScale = defaultScale
        self.draggingScale = draggingScale

        super.init(texture: texture, color: UIColor.clear, size: texture.size())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setGateState(_ state: EmotionalState) {
        switch state {
        case .happy:
            self.texture = SKTexture(imageNamed: "\(self.gateImagesPrefix)_HAPPY")
        case .angry:
            self.texture = SKTexture(imageNamed: "\(self.gateImagesPrefix)_ANGRY")
        case .impressed:
            self.texture = SKTexture(imageNamed: "\(self.gateImagesPrefix)_IMPRESSED")
        default:
            self.texture = SKTexture(imageNamed: "\(self.gateImagesPrefix)_SAD")
        }
    }

    func touchDown(atPoint pos : CGPoint) {
        if self.contains(pos) {
            isDragging = true
            self.setScale(draggingScale)
            isGateInPosition = false
            self.setGateState(.impressed)
            return
        }
    }
    
    func touchDown(atPoint pos : CGPoint, completion block: @escaping () -> Void) {
        if self.contains(pos) {
            touchDown(atPoint: pos)
            block()
        }
    }

    func touchMoved(toPoint pos : CGPoint) {
        if isDragging {
            self.position = pos
        }
    }
    
    func touchMoved(toPoint pos : CGPoint, completion block: @escaping () -> Void) {
        if isDragging {
            touchMoved(toPoint: pos)
            block()
        }
    }

    func touchUp(atPoint pos : CGPoint) {
        if isDragging {
            self.setScale(defaultScale)
            
            if intersectionNode != nil {
                if intersectionNode.contains(pos) {
                    self.position = intersectionNode.position
                    isGateInPosition = true
                    self.run(self.inPositionSound)
                } else {
                    self.setGateState(.sad)
                    isGateInPosition = false
                }
            }

            isDragging = false
        }
    }
    
    func touchUp(atPoint pos : CGPoint, completion block: @escaping () -> Void) {
        if isDragging {
            touchUp(atPoint: pos)
            block()
        }
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
