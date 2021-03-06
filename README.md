# iOS JuiceMaker Application Project
### 쥬스 주문 및 판매를 통한 과일의 재고를 관리하는 프로젝트
***
#### What I learned✍️
- fileprivate
- OOP
- Struct & Class
- Stepper
- Segment

#### What have I done🧑🏻‍💻
- Struct와 Class의 차이를 학습하여 참조보다 복사가 더 적합하여 Struct를 사용하여 구현해보았다.
- OOP의 개념을 학습하고 객체지향으로 프로그래밍하였다.
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
- 문제점 (3)
  - 아래와 같이 기기별 시뮬레이터로 앱을 구동 시 작은 사이즈의 기기에서는 쥬스주문 버튼의 크기 및 위치가 겹치거나 어색한것을 볼 수 있다.
  <img width="600" alt="스크린샷 2021-04-27 오전 10 10 34" src="https://user-images.githubusercontent.com/72292617/116169966-cfbdcc80-a740-11eb-8351-285c2a77ff70.png">
- 원인
  - 모호한 오토레이아웃이 적용되어 버튼의 크기가 고정되어 있는 값으로 주어져 뷰의 크기에 고려하지 않고 마진들만 적용되어 버튼이 겹치는 현상이 발생하였고, 또한 여러 뷰에서 아직 크기가 정해지지 않은 뷰들도 있어 각 시뮬레이터마다 크기가 다르게 나타나게 되었다. 즉 오토레이아웃이 미흡한 문제이다.
- 해결방안
  - 우선 스토리보드에서 일일히 확인하며 고치기보다 LLDB 디버깅을 이용하기로하였다. Chisel 명령어인 paltrace를 이용하여 서브뷰의 계층구조를 아래와 같이 출력하고 오토레이아웃이 모호한 부분이 있으면 AmBIGUOUS 라벨이 붙음으로 해당 부분을 찾았다.
  <img width="1118" alt="스크린샷 2021-04-27 오전 10 14 26" src="https://user-images.githubusercontent.com/72292617/116170222-596d9a00-a741-11eb-8992-ed80c1be4103.png">
  살펴보면 이미지뷰와 레이블의 오토레이아웃이 모호한걸 볼 수 있다. 버튼은 모호하지 않아보이는것은 오토레이아웃 설정은 전부되어있어 모호하진 않지만 각 사이즈를 뷰의 비율로 조정해줄 필요가 있다. 우선 디버깅을 통해 탐색한 뷰에 대해 시뮬레이터에서 확인 할 수 있도록 보더를 주었다.
  <img width="1118" alt="스크린샷 2021-04-27 오전 10 17 58" src="https://user-images.githubusercontent.com/72292617/116170451-d7ca3c00-a741-11eb-896b-8d3f33f60c73.png">
  <img width="600" alt="스크린샷 2021-04-27 오전 10 17 10" src="https://user-images.githubusercontent.com/72292617/116170498-e7498500-a741-11eb-93cf-82af359253cb.png">
  <img width="721" alt="스크린샷 2021-04-27 오전 10 17 17" src="https://user-images.githubusercontent.com/72292617/116170508-eb75a280-a741-11eb-8cf2-bcb4e5998a01.png">
  좀 더 명확하게 어느 부분이 모호한 지 파악할 수 있다. 해당 부분과 버튼을 고쳐보았다.
<img width="600" alt="스크린샷 2021-04-27 오전 10 52 01" src="https://user-images.githubusercontent.com/72292617/116172930-9be5a580-a746-11eb-8708-e2c81539d880.png">   

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
  - "네이밍이 짧을수록 좋을까요?"
- 원인 및 대책
  - 네이밍이 짧은것이 긴것보다야 가독성이 좋을 확률이 있다. 그렇지만 무조건 메서드명이든 변수던 길이가 짧다고 가독성이 좋은건 아니다. 처음에 과일재고를 업데이트해주는 메서드명은 'updateStock'으로 짧게 주었는데 추후 더 많은 기능들이 발전해 해당 재고가 과일뿐만 아니라 다른 재고들의 관리도 따로 생긴다면 모호한 메서드명이 될것이다. 이에 'updateFruitStock'과 같이 이전보다 길지만 추후 유지보수와 나만 아닌 다른 동료들이 보았을때도 직관적인 네이밍이 가독성이 좋은 네이밍이라고 생각한다.
- 고민점 (5)
  - "재고관리 해주는 VC을 ViewController를 상속하는게 적합할까요?"
  ```swift
  class ManageStockViewController: ViewController
  ```   
- 원인 및 대책
  - 재고관리 해주는 VC를 처음에 ViewController를 상속해줬는데 이는 올바르지 않았다. ViewController는 쥬스주문에 대한 VC이기에 재고관리에서 만약 이 VC을 상속 받는다면 필수 구현이 있다면 구현해야될 것이고 만약 겹치는 메서드들이 있거나 하더라도 오버라이드로 구현해야될것이다. 이에 꼬일 수 있음으로 재고관리에서는 UIViewController를 상속하여 구현하는것이 더 적합하다.
