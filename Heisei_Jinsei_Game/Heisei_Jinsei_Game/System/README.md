#  System Class APIについて

## `HSGameController`

`ViewModel`との通信関連はほぼここ



### 初期化

`HSPlayerSquareManager`

`HSSquareEventManager`

が必要、これらのクラスについては下で説明する。

### プロパティ
- `var currentPlayer: HSPlayer`
現在のプレーヤーです。
- `var gamingPlayers: [HSPlayer]`
ゲーム中のプレイヤー一覧です。


#### マス目管理系

- `func getPlayerPosition(for player: HSPLayer) -> Int`

  プレーヤーの現在地を返します。


- `func spinWheel(min:Int = 1, max:Int = 12) -> Int`

  現在のプレイヤーに対してルーレットを回します。

  返り値はルーレットの出目です。
  
- `Notification:: HSGameControllerDidEventActionOccur (object:HSEventAction)`

  止まったマスにイベントアクションが発生した時に発火します。

  `Notification::object`は`HSEventAction`です。


- `func didAnimationEnd()`

アニメーションが完了したら呼び出してください。

マスのアクション・操作ユーザー更新を行います。

アクションによるAnimation後も再度呼び出してください。


- `Notification:: HSGameControllerDidCurrentPlayerChanged (object:HSPlayer)`

  操作ユーザーが更新された時に発火します。

  `Notification::object`は更新後の`HSPlayer`です。


#### プレイヤー管理系

- `Notification:: HSGameControllerDidPlayerMoneyChanged (object:HSPlayer)`

  プレイヤーの所持金が変化した時に発火します。

  View側は対応してPlayerの所持金を変化させてください。

  （アクションによる変更でも`didUserAcceptEventAction`が呼び出されるまで、発火しません。）

  

- `Notification:: HSGameControllerDidPlayerPositionChanged (object:HSPlayer)`

  プレイヤーの場所が変化した時に発火します。

  View側は対応してPlayerの場所を変化させてください。

  （アクションによる変更でも`didAnimationEnd`が呼び出されるまで、発火しません。）

  

#### イベント（マス目情報）管理系

＊ ここでいうEventとは、時事ネタのタイトル・詳細・画像のとこです。

マス目移動・アイテム...などはEventActionと明記します。

- `func getEvent(for squareIndex:Int) -> HSEraEvent`

  `index`番めのマス情報を返します。

- `func getAllEvent() -> [HSEraEvent]`

全てのマス情報を返します。



## `HSPlayerSquareManager`

プレイヤーの位置情報を管理します。

API使用者はこのクラスのAPIを使用しないでください。



### 初期化

ゲームプレイヤーとして`[HSPlayer]`が必要



## `HSSquareEventManager`

マスにある時代のイベントを管理します。



### APIs

- `func registerEvent(_ event:HSEraEvent)`

  マスにイベントを登録します。

  登録した順にマス目となります。


