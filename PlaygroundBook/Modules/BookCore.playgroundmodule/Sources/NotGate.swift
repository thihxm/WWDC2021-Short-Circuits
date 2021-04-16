import SpriteKit

public class NotGate: Gate {
    init(defaultScale: CGFloat = 1, draggingScale: CGFloat = 1.05) {
        super.init("GATE_NOT", defaultScale: defaultScale, draggingScale: draggingScale)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
