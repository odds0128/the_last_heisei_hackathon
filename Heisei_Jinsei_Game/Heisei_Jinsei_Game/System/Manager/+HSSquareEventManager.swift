//
//  +HSSquareEventManager.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/28.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

extension HSSquareEventManager{
    static let sampleEventManager = _createSampleEventManager()
}

private func _createSampleEventManager() -> HSSquareEventManager{
    let em = HSSquareEventManager()
    em.registerEvent(HSEraEvent(title: "平成元年，その最初の日．", heiseiYear: 1, eventDescription: "小渕恵三が発表した「平成」の2文字は生乾きであったという。\n", imageName: "01_winter", action: nil))
    em.registerEvent(HSEraEvent(title: "消費税がスタート．", heiseiYear: 1, eventDescription: "最初の消費税は3%でした。\n", imageName: "01_spring", action: nil))
    em.registerEvent(HSEraEvent(title: "礼宮(秋篠宮)文仁親王が川嶋紀子さんとの婚約会見を開く．", heiseiYear: 1, eventDescription: "当時は色々とトラブルもあったようで...\n", imageName: "01_summer", action: nil))
    em.registerEvent(HSEraEvent(title: "ベルリンの壁“崩壊”．", heiseiYear: 1, eventDescription: "正確には撤去作業の着工がこの日。\n東西ドイツの統一はもう少し先のことでした。\n", imageName: "01_autumn", action: nil))
    em.registerEvent(HSEraEvent(title: "東京ウォーカー第1号の発行．", heiseiYear: 2, eventDescription: "記念すべき最初のテーマは「東京ディズニーランドと花やしき」でした。\nディズニーランドが実は1957年からあったことをみなさん知っていましたか？\n", imageName: "02_winter", action: nil))
    em.registerEvent(HSEraEvent(title: "シングルCD「おどるポンポコリン」発売．", heiseiYear: 2, eventDescription: "国民的アニメ「ちびまる子ちゃん」を代表する言わずと知れた名曲はこの年に生まれました。\nその後ゴールデンボンバーやE-girlsなど様々なアーティストにカバーされるなど脈々と受け継がれています。\n", imageName: "02_spring", action: nil))
    em.registerEvent(HSEraEvent(title: "京大の森重文教授がフィールズ賞を受賞．", heiseiYear: 2, eventDescription: "フィールズ賞は数学界において最高の権威を有する賞です。\n森重文はのちにアジア人として初の国際数学連合の総裁となりました。\n", imageName: "02_summer", action: nil))
    em.registerEvent(HSEraEvent(title: "サンリオピューロランドの開園．", heiseiYear: 2, eventDescription: "サンリオピューロランドも30年近い歴史があるのですね。\nちなみにハローキティは今年で45歳らしいです。\nおっと，女性の年齢を探るのは無粋でしたね^^;\n", imageName: "02_autumn", action: nil))
    em.registerEvent(HSEraEvent(title: "バブル崩壊．", heiseiYear: 3, eventDescription: "1973年12月から成長し続けた日本の経済は，ここから「失われた20年」と呼ばれる暗黒期に突入しました。\n日本の経済は令和では果たしてどうなるのでしょうか。\n", imageName: "03_winter", action: nil))
    em.registerEvent(HSEraEvent(title: "都庁移転．", heiseiYear: 3, eventDescription: "東京都庁が千代田区丸の内から新宿区西新宿に移転しました。\nかつては千代田区にあったんですね。\nところで都庁所在地を聞かれてなんと答えていいのかいまだに迷いませんか？\nもし答えることがあれば\"千代田区\"と言ってみるとご年配の方に懐かしがられるかもしれません。\n", imageName: "03_spring", action: nil))
    em.registerEvent(HSEraEvent(title: "SMAPが「Can't Stop!! -LOVING-」でCDデビュー．", heiseiYear: 3, eventDescription: "国民的アイドルSMAPの時代はここから始まりました。\nあの解散騒動は衝撃的でしたね。\n", imageName: "03_summer", action: nil))
    em.registerEvent(HSEraEvent(title: "Jリーグ発足．", heiseiYear: 3, eventDescription: "日本サッカー史においても最重要な出来事の一つではないでしょうか。\n開幕戦はまだ先ですが，ここからJリーグが動き出します。\n", imageName: "03_autumn", action: nil))
    em.registerEvent(HSEraEvent(title: "ハウステンボス開業．", heiseiYear: 4, eventDescription: "長崎県佐世保市にハウステンボスがオープンしました。\n一時は経営不振による閉園まで囁かれましたが現在ではテーマパークの定番となっています。\n", imageName: "04_winter", action: nil))
    em.registerEvent(HSEraEvent(title: "尾崎豊，死去．", heiseiYear: 4, eventDescription: "今尚カリスマ的人気を誇る歌手 尾崎豊はこの年になくなりました。\n26歳という早すぎる死に加え死因は不明とされており，大きな話題となりました。\n", imageName: "04_spring", action: nil))
    em.registerEvent(HSEraEvent(title: "毛利衛，宇宙へ．", heiseiYear: 4, eventDescription: "史上二人目の日本人宇宙飛行士として毛利衛が宇宙に飛び立ちました。\n帰国後の会見で発した「宇宙からは国境線は見えなかった」というコメントはとても有名です。\n", imageName: "04_summer", action: nil))
    em.registerEvent(HSEraEvent(title: "チェッカーズ解散．", heiseiYear: 4, eventDescription: "昭和後期を席巻したバンドであるチェッカーズが解散します。\n代表曲である「ギザギザハートの子守唄」などは現在でもテレビで目にします。\n", imageName: "04_autumn", action: nil))
    em.registerEvent(HSEraEvent(title: "曙太郎，外国人力士として初めて横綱に昇進．", heiseiYear: 5, eventDescription: "日本の国技\"相撲\"において初の外国人横綱の誕生です。\n格闘家に転身するなど一般的なイメージは良くない曙ですが，横綱としては誰よりもその品格を重んじる理想的な横綱だったと言います。\nちなみに，曙は後に日本国籍を取得しています。\n", imageName: "05_winter", action: nil))
    em.registerEvent(HSEraEvent(title: "Jリーグ開幕．", heiseiYear: 5, eventDescription: "日本サッカーの礎を築くJリーグはここから幕を開けます。\n記念すべき開幕戦はヴェルディ川崎(現: 東京ヴェルディ)vs横浜マリノス(現: 横浜F・マリノス)でした。\nちなみに最初のシーズンを制したのはヴェルディ川崎でした。\n", imageName: "05_spring", action: nil))
    em.registerEvent(HSEraEvent(title: "レインボーブリッジ開通", heiseiYear: 5, eventDescription: "「レインボーブリッジ，封鎖できません！」でお馴染みの，おそらく日本で一番有名な橋が開通しました。\nその名前は一般公募で決められたのだそうです。\nなお，冒頭のセリフは映画「踊る大捜査線 THE MOVIE 2 レインボーブリッジを封鎖せよ！」のものです。\n", imageName: "05_summer", action: nil))
    em.registerEvent(HSEraEvent(title: "法隆寺・姫路城・屋久島・白神山地が日本初の世界遺産登録．", heiseiYear: 5, eventDescription: "2019年4月21日現在で日本には22個の世界遺産がありますが，その先陣を切ったのがこの4つでした。\n修学旅行などで行ったことがあるという人も多いのではないでしょうか。\nいずれも観光名所として人気の場所ですね。\n", imageName: "05_autumn", action: nil))
    em.registerEvent(HSEraEvent(title: "ウィダーinゼリー発売開始．", heiseiYear: 6, eventDescription: "「10秒チャージ」でお馴染みのゼリー飲料の登場です。\n現在でも時間のない朝にコンビニで買って飲むという人も多いのではないでしょうか。\nこの頃から忙しい日本人の味方をしてくれていたのですね。\n", imageName: "06_winter", action: nil))
    em.registerEvent(HSEraEvent(title: "松本サリン事件．", heiseiYear: 6, eventDescription: "オウム3大事件の一つであるテロ事件が発生しました。\nオウム真理教教徒により神経ガスのサリンが撒き散らされ，8人の死者を出しました。\nこの翌年，更に凶悪なあの事件が起こります。\n", imageName: "06_spring", action: nil))
    em.registerEvent(HSEraEvent(title: "向井千秋，宇宙へ．", heiseiYear: 6, eventDescription: "日本人初の女性宇宙飛行士・向井千秋を乗せたスペースシャトルが打ち上げられます。\n彼女は23日までの14日と17時間55分を宇宙で過ごし，当時の女性の宇宙最長滞在記録を更新しました。\n", imageName: "06_summer", action: nil))
    em.registerEvent(HSEraEvent(title: "", heiseiYear: 6, eventDescription: "初代PlayStation発売。\n任天堂のハードと人気を二分するPlayStatoinシリーズの登場です。\n2019年4月22日現在で4まで出ており，最近5の開発が話題となりました。\nなお，初代PlayStationの一ヶ月前にはセガサターンが登場しています。\n", imageName: "06_autumn", action: nil))
    em.registerEvent(HSEraEvent(title: "阪神・淡路大震災", heiseiYear: 7, eventDescription: "午前5時46分52秒，文字通り日本列島を大震撼させる出来事が起こりました。\nその被害は甚大であり，5000人以上が死亡しました。\nなお，大震災とは地震によって引き起こされた災害のことであり，阪神・淡路大震災の直接の原因となった地震は兵庫県南部地震と呼ばれています。\n", imageName: "07_winter", action: nil))
    em.registerEvent(HSEraEvent(title: "麻原彰晃こと松本智津夫逮捕．", heiseiYear: 7, eventDescription: "オウム真理教の教祖で地下鉄サリン事件の首謀者たる麻原彰晃が逮捕されます。\nその後17もの事件で起訴され，裁判は20年以上続きました。\n死刑が執行されたのは死刑の確定からなんと12年後のことでした。\n", imageName: "07_spring", action: nil))
    em.registerEvent(HSEraEvent(title: "PHSサービス開始．", heiseiYear: 7, eventDescription: "携帯電話の前身とも言えるPHSがサービスを開始しました。\n最初は札幌と東京でサービスが開始され，ここから全国に広がっていきます。\n携帯電話とは違い，「持ち運べる子機」といった役割だったそうです。\n", imageName: "07_summer", action: nil))
    em.registerEvent(HSEraEvent(title: "ゆりかもめ開業．", heiseiYear: 7, eventDescription: "お台場に行った際はお世話になるでしょう，ゆりかもめが開業します。\n最初は新橋・有明間のみでした。\n", imageName: "07_autumn", action: nil))
    em.registerEvent(HSEraEvent(title: "ポケットモンスター赤・緑 発売", heiseiYear: 8, eventDescription: "誰しも一度は遊んだことがあるのではないでしょうか，あのポケットモンスターが世に放たれます。\n今では世界的に大人気のコンテンツで，2019末には新作「ソード・シールド」が出るなどその勢いはとどまるところを知りません。\n", imageName: "08_winter", action: nil))
    em.registerEvent(HSEraEvent(title: "Yahoo! JAPAN始動．", heiseiYear: 8, eventDescription: "天下のYahoo! JAPANがサービスを開始しました。\nかつてよりは見なくなったイメージのあるYahooですが，今なお広告事業などをメインに成長し続けている大企業です。\n", imageName: "08_spring", action: nil))
    em.registerEvent(HSEraEvent(title: "コミックマーケットが東京ビッグサイトで開催．", heiseiYear: 8, eventDescription: "コミケの通称で知られる一大同人イベント「コミックマーケット」がビッグサイトにやってきました。\nこの時点でコミックマーケット「50」だったそうで，その歴史はなかなか古いようです。\n", imageName: "08_summer", action: nil))
    em.registerEvent(HSEraEvent(title: "たまごっち発売．", heiseiYear: 8, eventDescription: "卵のような形をしたデバイスの中で登場するキャラクターを育てるというゲームです。\n発売当初から大ブームとなり，「たまごっち託児所」ができたり，持っていることがステータスとみなされるなど社会現象にまで発展しました。\n", imageName: "08_autumn", action: nil))
    em.registerEvent(HSEraEvent(title: "「CAN YOU CELEBRATE?」リリース", heiseiYear: 9, eventDescription: "平成を代表する女性歌手の一人，安室奈美恵の最大のヒット曲がリリースされました。\n現在でも結婚式の定番ソングとして耳にする機会の多い曲です。\n", imageName: "09_winter", action: nil))
    em.registerEvent(HSEraEvent(title: "消費税率が5%に引き上げ．", heiseiYear: 9, eventDescription: "平成元年導入時から3%だった消費税率が5%に上がりました。\n2019年4月22日現在は8%であり，近いうちに10%になりそうです。\n8%よりは5%か10%の方がキリがいいですし計算が楽でいいと思うのですが皆様はいかがでしょうか？\n", imageName: "09_spring", action: nil))
    em.registerEvent(HSEraEvent(title: "フジロックフェスティバル初開催．", heiseiYear: 9, eventDescription: "ロックフェスティバルとして最大級の規模を誇るあのフジロックフェスティバルの初回が開催されました。\n現在でこそ新潟で開催されていますが，なぜフジかというとこの初回が富士山の近くで行われたからです。\nしかし不運なことに，この時記録的な台風が直撃し大変な有様だったと言います。\n", imageName: "09_summer", action: nil))
    em.registerEvent(HSEraEvent(title: "ジョホールバルの歓喜", heiseiYear: 9, eventDescription: "ドーハの悲劇から4年，ついにその時は訪れます。\nイランとの激戦を3-2で制した日本はワールドカップ初出場を決めました。\nここを皮切りに日本はアジアの強豪国として6大会連続ワールドカップ本戦出場を果たします(2019年4月22日現在)。\n", imageName: "09_autumn", action: nil))
    em.registerEvent(HSEraEvent(title: "冬季長野オリンピック開催．", heiseiYear: 10, eventDescription: "20世紀最後の冬季オリンピックは日本の長野県で開催されました。\n特に男子スキージャンプ団体日本代表の活躍には大変なドラマがありました。\n", imageName: "10_winter", action: nil))
    em.registerEvent(HSEraEvent(title: "民主党結成．", heiseiYear: 10, eventDescription: "2016年まで自民党に次ぐ第2党として国会の重要な地位を占めた民主党が結成されます。\n一時は政権を獲得し連立与党を形成しますが，2012年の総選挙で大敗し野党となりました。\n2016年に維新の党と合流し民進党と改称しています。\n", imageName: "10_spring", action: nil))
    em.registerEvent(HSEraEvent(title: "Windows 98 (日本版)発売．", heiseiYear: 10, eventDescription: "Internet ExplorerをOSに内蔵することでシームレスなWebアクセスを実現するなど，前身の95よりもユーザーにとって使いやすい環境を提供します。\nまたUSBやIEEE規格に対応するようになり，家庭でもさらに使いやすくなりました。\n", imageName: "10_summer", action: nil))
    em.registerEvent(HSEraEvent(title: "タイタニック公開．", heiseiYear: 10, eventDescription: "1912年に実際に起きた「タイタニック号沈没事件」を元に作られた本作が公開されました。\n19日にアメリカで，翌20日には日本でも公開されました。\n公開から瞬く間に大ヒットし，その興行収入は全米史上最高を記録しました。\n", imageName: "10_autumn", action: nil))
    em.registerEvent(HSEraEvent(title: "藤原京跡から富本銭出土．", heiseiYear: 11, eventDescription: "皆さんも歴史の教科書で見たことがあるのではないでしょうか。\nそれまでは和同開珎が最古と言われていましたが，その出現よりも古い遺跡から富本銭が出土したことで最古の座が塗り替えられます。\n今は世界的にキャッシュレスの流れがありますが，一方で日本では2019年4月9日に新紙幣が発表されました。\n果たして令和ではどうなっていくのでしょうね。\n", imageName: "11_winter", action: nil))
    em.registerEvent(HSEraEvent(title: "AIBO販売開始．", heiseiYear: 11, eventDescription: "2017年にAIを搭載した機械の犬aiboが発売され話題になりましたが，その歴史は平成11年に遡ります。\n当然初代にはそのような高度な機能はなく組み込まれた特定の動きしかできませんでしたが，その人気ぶりは凄まじく社会現象になりました。\nソニーによる修理対応の終了で皮肉にも実質的な死を迎えたAIBOですが，それを受けて各地で本格的な「お葬式」が執り行われるほどだったそうです。\n", imageName: "11_spring", action: nil))
    em.registerEvent(HSEraEvent(title: "GLAYのライブ観客動員数が世界記録を更新．", heiseiYear: 11, eventDescription: "日本を代表するロックバンドGLAYが「MAKUHARI MESSE 10TH ANNIVERSARY GLAY EXPO'99 SURVIVAL」を開催しました。\nなんとその観客動員数は20万人に登り，有料ライブの動員数として世界記録を樹立しました。\nこの年には3度目の紅白出場を果たしています。\n", imageName: "11_summer", action: nil))
    em.registerEvent(HSEraEvent(title: "2000年問題．", heiseiYear: 11, eventDescription: "当時のコンピュータが日付を扱う際，西暦の「下二桁のみ」を扱っていたためにシステムに異常が生じると言われた問題です。\n結果として大きな問題には至りませんでしたが，各所で騒ぎとなり関係者は対応に追われました。\n平成から令和への切り替わりでも何か起こるかもしれません。\n", imageName: "11_autumn", action: nil))
    em.registerEvent(HSEraEvent(title: "平成ライダー，始動．", heiseiYear: 12, eventDescription: "平成ライダーの第1作目となる「仮面ライダークウガ」が放送を開始します。\n主演にオダギリジョーが抜擢され，彼を有名にする一因となりました。\nこのように平成ライダーは若手俳優の登竜門的な役割も持ち合わせています。\n「令和ライダー」はどのような活躍を見せてくれるのか楽しみですね。\n", imageName: "12_winter", action: nil))
    em.registerEvent(HSEraEvent(title: "アニメ「遊☆戯☆王デュエルモンスターズ」放送開始．", heiseiYear: 12, eventDescription: "世界で最も販売枚数の多いトレーディングカードゲームとしてギネス認定されている大人気カードゲームのアニメが始まります。\n現代でも根強い人気を誇り，ニコニコ動画やネットスラングとして今でも目や耳にする機会は多いです。\n令和に向けて「全速前進DA!」\n", imageName: "12_spring", action: nil))
    em.registerEvent(HSEraEvent(title: "高橋尚子，世界新で金メダル．", heiseiYear: 12, eventDescription: "シドニーオリンピック女子マラソンで，高橋尚子は当時の世界記録を塗り替えて金メダルを獲得します。\nオリンピックでの金メダル自体が日本陸上界にとっては64年ぶり，日本女子陸上界においてはなんと史上初とまさに前人未到の活躍でした。\nその時の「すごく楽しい42キロでした」という言葉と，愛称である「Qちゃん」がその年の流行語大賞にノミネートされています。\n", imageName: "12_summer", action: nil))
    em.registerEvent(HSEraEvent(title: "イチローが日本人野手初のメジャーリーガーに．", heiseiYear: 12, eventDescription: "数々の記録を打ち立てアメリカでも大きな功績を残すことになるイチローの挑戦が始まります。\n当初は懐疑的な見方もありましたが，アメリカでも「日本人野手の固定概念を覆した」と言われるほどその活躍は凄まじいものでした。\n2019年3月21日にイチローは惜しまれながらもその野球生涯に幕を下ろしました。\n", imageName: "12_autumn", action: nil))

    return em
}

