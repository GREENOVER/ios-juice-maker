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
  - 해당 접근제한자를 fileprivate로 설정해주었다. private보다 fileprivate으로 주어 다른 VC에서도 쥬스를 차감하면 쥬스 재고가 가감될 수 있도록 변경하였다.

- 문제점 (2)







#### Thinking Point 🤔
- 고민점 (1)
  ```swift
  func makeJuice(_ juice: Juice)
  ```
  - _ 와일드 카드를 사용하는 것보다 좀 더 명확히 이름을 주어도 좋아요.   
  외부에서 호출할 때 전달인자로 무엇을 전달해야 하는지 이름만으로는 잘 모르겠습니다.
- 대책
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
  ㄱ
            strawberryStock -= 
            strawberryStock -= 3
