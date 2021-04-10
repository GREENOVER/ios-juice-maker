//그린
//쥬스 재고관리

import UIKit

enum StockStepper {
    case strawberry
    case banana
    case pineapple
    case kiwi
    case mango
}

class ManageStockViewController: UIViewController {
    
    var strawberryStock: UInt = 10
    var bananaStock: UInt = 10
    var pineappleStock: UInt = 10
    var kiwiStock: UInt = 10
    var mangoStock: UInt = 10
    
    @IBOutlet weak var numberOfStrawberry: UILabel!
    @IBOutlet weak var numberOfBanana: UILabel!
    @IBOutlet weak var numberOfPineapple: UILabel!
    @IBOutlet weak var numberOfKiwi: UILabel!
    @IBOutlet weak var numberOfMango: UILabel!
    
    @IBOutlet weak var strawberryStepper: UIStepper!
    @IBOutlet weak var bananaStepper: UIStepper!
    @IBOutlet weak var pineappleStepper: UIStepper!
    @IBOutlet weak var kiwiStepper: UIStepper!
    @IBOutlet weak var mangoStepper: UIStepper!
    
    @IBAction func strawberryStockChanged(_ sender: UIStepper) {
        stepperSetting(fruit: strawberryStepper)
        
        strawberryStock += 1
        
        stockChange(fruit: StockStepper.strawberry)
    }
    
    @IBAction func bananaStockChanged(_ sender: UIStepper) {
        stepperSetting(fruit: bananaStepper)
        
        bananaStock += 1
        
        stockChange(fruit: StockStepper.banana)
    }
    
    @IBAction func pineappleStockChanged(_ sender: UIStepper) {
        stepperSetting(fruit: pineappleStepper)
        
        pineappleStock += 1
        
        stockChange(fruit: StockStepper.pineapple)
    }
    
    @IBAction func kiwiStockChanged(_ sender: UIStepper) {
        stepperSetting(fruit: kiwiStepper)
        
        kiwiStock += 1
        
        stockChange(fruit: StockStepper.kiwi)
    }
    
    @IBAction func mangoStockChanged(_ sender: UIStepper) {
        stepperSetting(fruit: mangoStepper)
        
        mangoStock += 1
        
        stockChange(fruit: StockStepper.mango)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showFruitStock()
        
        strawberryStepper.autorepeat = true
        strawberryStepper.minimumValue = 0
    }
    
    func showFruitStock() {
        numberOfStrawberry.text = String(strawberryStock)
        numberOfBanana.text = String(bananaStock)
        numberOfPineapple.text = String(pineappleStock)
        numberOfKiwi.text = String(kiwiStock)
        numberOfMango.text = String(mangoStock)
    }
    
    func stepperSetting(fruit: UIStepper!) {
        fruit.autorepeat = true
        fruit.maximumValue = 0
    }
    
    func stockChange(fruit: StockStepper) {
        switch fruit {
        case .strawberry:
            numberOfStrawberry.text = String(strawberryStock)
        case .banana:
            numberOfBanana.text = String(bananaStock)
        case .pineapple:
            numberOfPineapple.text = String(pineappleStock)
        case .kiwi:
            numberOfKiwi.text = String(kiwiStock)
        case .mango:
            numberOfMango.text = String(mangoStock)
        }
    }
    
    @IBAction func touchupDissmissButton(_ sender: UIButton) {
        
        self.presentingViewController?.dismiss(animated: true,
                completion: nil)
    }
}
