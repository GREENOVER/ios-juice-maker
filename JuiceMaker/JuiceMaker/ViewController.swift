//그린
//쥬스 주문

import UIKit
                                
struct JuiceName {
    fileprivate let strawberryBananaJuice: String = "딸바쥬스"
    fileprivate let mangoKiwiJuice: String = "망키쥬스"
    fileprivate let strawberryJuice: String = "딸기쥬스"
    fileprivate let bananaJuice: String = "바나나쥬스"
    fileprivate let pineappleJuice: String = "파인애플쥬스"
    fileprivate let kiwiJuice: String = "키위쥬스"
    fileprivate let mangoJuice: String = "망고쥬스"
}
    
class ViewController: UIViewController {
    var juiceMaker: JuiceMaker = JuiceMaker()
    
    private let order = JuiceName()
    
    @IBOutlet weak var amountOfStrawberry: UILabel!
    @IBOutlet weak var amountOfBanana: UILabel!
    @IBOutlet weak var amountOfPineapple: UILabel!
    @IBOutlet weak var amountOfKiwi: UILabel!
    @IBOutlet weak var amountOfMango: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func orderStrawberryBanana(_ sender: UIButton) {
        let juice: String = order.strawberryJuice
        if (juiceMaker.strawberryStock >= 10) && (juiceMaker.bananaStock >= 1) {
            juiceMaker.make(juice: .strawberryBananaJuice)
            showOrderMessage(juice)
            updateFruitStock(juice: .strawberryBananaJuice)
        }
        else {
            showAlertMessage()
        }
    }
    
    @IBAction func orderMangoKiwi(_ sender: UIButton) {
        let juice: String = order.mangoKiwiJuice
        if (juiceMaker.mangoStock >= 2) && (juiceMaker.kiwiStock >= 1) {
            juiceMaker.make(juice: .mangoKiwiJuice)
            showOrderMessage(juice)
            updateFruitStock(juice: .mangoKiwiJuice)
        }
        else {
            showAlertMessage()
        }
    }
    
    @IBAction func orderStrawberry(_ sender: UIButton) {
        let juice: String = order.strawberryJuice
        if juiceMaker.strawberryStock >= 16 {
            juiceMaker.make(juice: .strawberryJuice)
            showOrderMessage(juice)
            updateFruitStock(juice: .strawberryJuice)
        }
        else {
            showAlertMessage()
        }
    }
    
    @IBAction func orderBanana(_ sender: UIButton) {
        let juice: String = order.bananaJuice
        if juiceMaker.bananaStock >= 2 {
            juiceMaker.make(juice: .bananaJuice)
            showOrderMessage(juice)
            updateFruitStock(juice: .bananaJuice)
        }
        else {
            showAlertMessage()
        }
    }
    
    @IBAction func orderPineapple(_ sender: UIButton) {
        let juice: String = order.pineappleJuice
        if juiceMaker.pineappleStock >= 2 {
            juiceMaker.make(juice: .pineappleJuice)
            showOrderMessage(juice)
            updateFruitStock(juice: .pineappleJuice)
        }
        else {
            showAlertMessage()
        }
    }
    
    @IBAction func orderKiwi(_ sender: UIButton) {
        let juice: String = order.kiwiJuice
        if juiceMaker.kiwiStock >= 3 {
            juiceMaker.make(juice: .kiwiJuice)
            showOrderMessage(juice)
            updateFruitStock(juice: .kiwiJuice)
        }
        else {
            showAlertMessage()
        }
    }
    
    @IBAction func orderMango(_ sender: UIButton) {
        let juice: String = order.mangoJuice
        if juiceMaker.mangoStock >= 3 {
            juiceMaker.make(juice: .mangoJuice)
            showOrderMessage(juice)
            updateFruitStock(juice: .mangoJuice)
        }
        else {
            showAlertMessage()
        }
    }
        
    func showOrderMessage(_ juice: String) {
        let alert = UIAlertController(title: nil, message: juice + " 나왔습니다! 맛있게 드세요!", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler : nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertMessage() {
        let alert = UIAlertController(title: nil, message: "재료가 모자라요. 재고를 수정할까요?", preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "예", style: .default, handler: { (action) in
            self.performSegue(withIdentifier: "manageStockSegue", sender: self) })
        
        alert.addAction(cancel)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func updateFruitStock(juice: Juice) {
        switch juice {
        case .strawberryBananaJuice:
            amountOfStrawberry.text = String(juiceMaker.strawberryStock)
            amountOfBanana.text = String(juiceMaker.bananaStock)
        case .mangoKiwiJuice:
            amountOfMango.text = String(juiceMaker.mangoStock)
            amountOfKiwi.text = String(juiceMaker.kiwiStock)
        case .strawberryJuice:
            amountOfStrawberry.text = String(juiceMaker.strawberryStock)
        case .bananaJuice:
            amountOfBanana.text = String(juiceMaker.bananaStock)
        case .pineappleJuice:
            amountOfPineapple.text = String(juiceMaker.pineappleStock)
        case .kiwiJuice:
            amountOfKiwi.text = String(juiceMaker.kiwiStock)
        case .mangoJuice:
            amountOfMango.text = String(juiceMaker.mangoStock)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let manageStockView: ManageStockViewController = segue.destination as? ManageStockViewController else { return }

        manageStockView.strawberryStock = juiceMaker.strawberryStock
        manageStockView.bananaStock = juiceMaker.bananaStock
        manageStockView.pineappleStock = juiceMaker.pineappleStock
        manageStockView.kiwiStock = juiceMaker.kiwiStock
        manageStockView.mangoStock = juiceMaker.mangoStock
    }
}
