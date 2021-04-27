# iOS JuiceMaker Application Project
### 쥬스 주문 및 판매를 통한 과일의 재고를 관리하는 프로젝트
***
#### What I learned✍️
- fileprivate
- Struct & Class
- Stepper
- Segment

#### What have I done🧑🏻‍💻
- Struct와 Class의 차이를 학습하여 참조보다 복사가 더 적합하여 Struct를 사용하여 구현해보았다.
- fileprivate 접근제어를 통해 같은 폴더에서 호출이 가능하도록 구현하였다.
- Stepper의 사용을 통해 수의 가감을 구현해보았다.
- 각 조건에 따라 해당하는 얼럿과 함수를 호출하도록 구현하였다.
- 세그먼트를 통해 뷰와 값의 이동을 구현해보았다.
- 과일별 쥬스주문에 따라 재고를 차감하고 부족 시 얼럿이 나오도록 구현하였다.

#### Trouble Shooting 👨‍🔧
- 문제점 (1)
  - 과일의 재고를 외부에서도 수정할 수 있는 문제가 발생하였다.
- 원인
  - 아래와 같이 쥬스재고를 관리해주는 코드에서 접근제한자를 설정하지 않아 기본 설정인 internal로 같은 모듈에서는 접근이 될 수 있게 되어 외부에서도 수정이 가능하게 되었다.
  ```swift
  class JuiceMaker {
    var strawberryStock: Int = 10
  ```
- 해결방안
  - 해당 접근제한자를 fileprivate로 설정해주었다. private보다 fileprivate으로 주어 다른 VC에서도 쥬스를 차감하면 쥬스 재고가 가감될 수 있도록 변경하였다.

- 문제점 (2)
  - 재고 수정 시 재고 관리 화면으로 넘어가게되는데 쥬스 주문의 과일 재고와 일치하지 않는 과일 재고 수량이 나오는 문제가 발생하였다.
- 원인
  - 재고 수정을 누를 시 화면이 넘어가도록 modal 방식으로 구성하여주었다. 그런데 서로의 VC에서 재고 데이터값을 전달받는 부분의 구현이 되지 않아 재고관리 VC의 재고는 초기값인 10으로 전부 세팅되게 되었다. 물론 다시 쥬스주문 화면으로 넘어온다면 10이 아닌 감소된 수량이 나타나게 된다. 즉 서로의 데이터값이 연동되지 않고 따로 값을 갖고있는셈이었다.
- 해결방안
  - 우선 서로의 VC를 세그 방식으로 연결해주었다. 그리고 재고수정을 클릭하거나 재고 부족시에도 넘어가야됨으로 재고관리 VC의 identifierID를 설정해주고 prepare 함수를 오버라이드하여 재고가 연동될 수 있도록 구현하였다.
  ```swift
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let manageStockView: ManageStockViewController = segue.destination as? ManageStockViewController else { return }

        manageStockView.strawberryStock = juiceMaker.strawberryStock
        manageStockView.bananaStock = juiceMaker.bananaStock
        manageStockView.pineappleStock = juiceMaker.pineappleStock
        manageStockView.kiwiStock = juiceMaker.kiwiStock
        manageStockView.mangoStock = juiceMaker.mangoStock
    }
    ```   
    이렇게 세그동작이 일어날때 현재 VC의 재고를 재고관리 VC의 재고로 입혀준다. 그리고 해당 재고관리 이동이 필요한곳에서 핸들러를 통해 세그 이동을 실행시켜준다.
    ```swift
    let okAction = UIAlertAction(title: "예", style: .default, handler: { (action) in
            self.performSegue(withIdentifier: "manageStockSegue", sender: self) })
    ```   







#### Thinking Point 🤔
- 고민점 (1)
  ```swift
  func makeJuice(_ juice: Juice)
  ```
  - "_ 와일드 카드를 사용하는 것보다 좀 더 명확히 이름을 주어도 좋아요.   
  외부에서 호출할 때 전달인자로 무엇을 전달해야 하는지 이름만으로는 잘 모르겠습니다."
- 원인 및 대책
  - _ 와일드카드 사용으로 외부에서 조금 더 편리하게 호출할 수 있으면 좋겠다 생각하였는데 코멘트를 보고 생각해보니 호출이 많을 수 있어 명확하지 않아질때를 대비하여 makeJuice는 juiceName으로 재고들은 stockName으로 _ 와일드카드 사용을 수정하여 호출 시 명확하게 수정하였다.   
  또한 매개변수 레이블도 메서드 이름의 일부여서 지금 위의 함수 호출 시 읽으면 makeJuice juice가 되는것으로 너무 어색했다. 이에 메서드명을 짓고 매개변수 레이블 네이밍을 고민할때 겹치지 않고 자연스럽게 되도록 아래와 같이 수정해보았다.   
  ``` swift
  func make(juice: Juice) 
  ```   
- 고민점 (2)
  ```swift
  case .strawberryJuice:
    strawberryStock -= 16
  ```
  - "레시피가 변경된다면 이 코드는 안전할까요?"
- 원인 및 대책
  - 과일 주문시 위와 같은 코드로 과일을 감소 시켰었는데 만약 이 경우에는 레시피나 기획이 바뀌면 일일히 과일마다 해당 수를 변경해주는거에 유지보수의 번거로움이 많아보였다. 이에 레시피가 변경되어도 안전한 코드가 되도록 아래와 같이 우선 각 레시피에 필요한 과일의 수를 구조체 타입으로 따로 분리하여 생성하였다.   
  ```swift
  struct FruitAmountForJuice {
    fileprivate let strawberryForStrawberryJuice: UInt = 16
    fileprivate let bananaForBananaJuice: UInt = 2
    fileprivate let pineappleForPineappleJuice: UInt = 2
    fileprivate let kiwiForKiwiJuice: UInt = 3
    fileprivate let mangoForMangoJuice: UInt = 3
    fileprivate let strawberryForStrawberryBananaJuice: UInt = 10
    fileprivate let bananaForStrawberryBananaJuice: UInt = 1
    fileprivate let mangoForMangoKiwiJuice: UInt = 2
    fileprivate let kiwiForMangoKiwiJuice: UInt = 1
  }
  ```   
  그 후 쥬스메이커 클래스에서 해당 구조체에 대한 인스턴스를 생성하고 쥬스 주문 시 해당 값에서 차감되도록 아래와 같이 구성하였다.
  ```swift
  private var amountOfNeed = FruitAmountForJuice()
  ```   
  ```swift
  case .strawberryJuice:
    strawberryStock -= amountOfNeed.strawberryForStrawberryJuice
  ```   
- 고민점 (3)
  - "쥬스 레시피에 대한 타입을 클래스가 아닌 구조체로 해준 이유는 무엇인가요?"
- 원인 및 대책
  - 해당 과일 재고에 대한 타입은 현재 하나의 점포만 있다면 class로 해주는것도 괜찮다. 그렇지만 만약 해당 레시피를 여러 쥬스 점포에서 인스턴스를 만들어 사용한다고 생각하면 class로 만들경우 각 과일 재고 값에 대해 참조하게되고 어느 가게에서든 수정이 일어나면 동일하게 반영이 된다. 이에 참조를 하지 않는 값타입의 Struct 타입으로 만들어 추후 해당 타입 모델을 여러곳에서 쓸 수 있는것이 효율적이다.
- 고민점 (4)
 
