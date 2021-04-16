import SpriteKit

public class NorGate: Gate {
    init(defaultScale: CGFloat = 1, draggingScale: CGFloat = 1.05) {
        super.init("GATE_NOR", defaultScale: defaultScale, draggingScale: draggingScale)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
