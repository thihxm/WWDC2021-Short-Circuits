import SpriteKit

public class XorGate: Gate {
    init(defaultScale: CGFloat = 1, draggingScale: CGFloat = 1.05) {
        super.init("GATE_XOR", defaultScale: defaultScale, draggingScale: draggingScale)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
