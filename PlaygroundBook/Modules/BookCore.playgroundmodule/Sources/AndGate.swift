import SpriteKit

public class AndGate: Gate {
    init(defaultScale: CGFloat = 1, draggingScale: CGFloat = 1.05) {
        super.init("GATE_AND", defaultScale: defaultScale, draggingScale: draggingScale)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
