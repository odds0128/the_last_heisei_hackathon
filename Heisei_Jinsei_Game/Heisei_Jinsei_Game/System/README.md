#  System Class APIについて

## `HSGameController`

`ViewModel`との通信関連はほぼここ

## 注意
`HSGameController`はシングルトンを提供しますが、最初から初期化されていません。
ユーザーがゲームをスタートした後に
`HSGameController::initiarize(_:)` で初期化する必要がありあます。

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

  

- `func didUserAcceptEventAction(_ action:HSEventAction)`

  (アニメーションの都合があるので) 

  ユーザーがイベント発火を確認したら呼び出してください。

  アクションを続行します。

  

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

  （アクションによる変更でも`didUserAcceptEventAction`が呼び出されるまで、発火しません。）

  



#### イベント（マス目情報）管理系

＊ ここでいうEventとは、時事ネタのタイトル・詳細・画像のとこです。

マス目移動・アイテム...などはEventActionと明記します。

- `func getEvent(for squareIndex:Int) -> HSEraEvent`

  `index`番めのマス情報を返します。
