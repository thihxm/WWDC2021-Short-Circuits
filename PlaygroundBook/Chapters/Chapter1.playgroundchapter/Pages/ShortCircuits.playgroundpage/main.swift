//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
//#-end-hidden-code

//#-hidden-code
import PlaygroundSupport
import SpriteKit
import UIKit
import BookCore

let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 1366, height: 1024))
if let scene = GameScene(fileNamed: "GameScene") {
    scene.scaleMode = .aspectFit
    sceneView.presentScene(scene)
}


PlaygroundPage.current.liveView = sceneView
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.wantsFullScreenLiveView = true
//#-end-hidden-code
/*:
 # Please hide the editor and enable full screen mode for a better experience
 This playground was developed with the editor hidden and with full screen mode enabled
*/

/*:
 ## Attributions
 - I'm very grateful to the Freepik user **pikisuperstar** for making his [Female Scientist Hand Drawn Illustration](https://www.freepik.com/free-vector/female-scientist-hand-drawn-illustration_6528232.htm) illustration available for free, without it I would not be able to draw such an amazing art to represent Sarah the Engineer
 
 - I'm very grateful to the Freepik user **iconicbestiary** for making his [Physics Classroom Equipment](https://www.freepik.com/free-vector/physics-classroom-equipment_1310877.htm) illustrations available for free, without it I would not be able to draw such an amazing art to represent Sarah's Oscilloscope
*/
