# Customization Guide

[English](#english) · [**日本語はこちら**](#日本語)

<a id="english"></a>

`team-pack.json` is the single source of truth for your team. Change the pack's data; never edit TeamNest Core. After every change, run `install.ps1` / `install.sh` to validate and apply it again.

## Where to change what

| You want to change | Edit |
|---|---|
| Expression images | `assets/roles/<role>/expressions/` and `expressionAssets` |
| Default expression | `defaultExpression` |
| Which image a mood shows | `runtimeMoodMap` |
| Role name, color, icon | the role in `team-pack.json` |
| Names that map to a role | `bindings/workspace-default.json` |
| Lines of dialogue | the role's `speech` / `localizedSpeech` |
| Voice | the role's `providers.voice` |
| Voice Design persona | the role's `voiceDesign` |
| Avatar size | `presentation.graphics` in `runtime/config.json` |
| When the team speaks | `presentation.voice` in `runtime/config.json` |
| How the team works | not here: use a Flow plugin |

## 1. Expressions

```json
"defaultExpression": "neutral",
"expressionAssets": {
  "neutral": "assets/roles/tester/expressions/neutral.png",
  "smile": "assets/roles/tester/expressions/smile.png"
}
```

- Use transparent PNGs with the same canvas size and framing within a role. Square images around 256–512 px work well.
- Missing expressions fall back to `defaultExpression`, so you can start with a single image.
- To add an expression such as `sleepy`, declare it once in `expressionVocabulary`, add it to `expressionAssets`, and point a mood at it in `runtimeMoodMap`:

```json
"runtimeMoodMap": { "tired": "sleepy" }
```

Runtime moods (`pleased`, `worried`, ...) describe meaning; expressions (`smile`, `surprised`, ...) are pictures. Keeping them apart lets you name images however you like.

## 2. Roles

Add a role to `roles`:

```json
{
  "id": "security-reviewer",
  "label": "Security Reviewer",
  "accentColor": "#5B7CFA",
  "icon": "assets/icons/security-reviewer.svg",
  "matchHints": ["security", "sec-review"],
  "defaultExpression": "neutral",
  "expressionAssets": { "neutral": "assets/roles/security-reviewer/expressions/neutral.png" }
}
```

Then add its names to `bindings/workspace-default.json`. If you use the TeamNestReferenceFlow, keep the ids `orchestrator`, `architect`, `implementer`, `reviewer`, `ux-designer`, and `tester`, which the flow delegates to.

## 3. Matching agents to roles

```json
{ "roleId": "ux-designer", "match": ["ux", "ui", "designer", "product-design"] }
```

For a guaranteed mapping, pin the pane with TeamNest's `scripts/bind-role` instead of relying on names.

## 4. Lines of dialogue

A line can be a string, an array of alternatives, or an object narrowed by mood:

```json
"speech": {
  "working": ["Running the tests.", "Trying the edge cases."],
  "done": { "pleased": "All green!", "default": "Testing complete." }
}
```

From an array, one line is picked per event without repeating the previous one. The choice is deterministic, so a replay shows the same lines.

### Monologue

While working quietly, a member thinks aloud in the AI Team view: it starts after 9 seconds and changes every 16 seconds.

```json
"monologue": {
  "default": ["Where should I start on {topic}?"],
  "editing": ["Change this here... yes, that works."]
}
```

`{topic}` is the task the member is working on (sent by a Flow plugin); without one it reads "this task".

### Conversations

When a Flow plugin hands work over, both members speak:

| Type | Speaker | Example |
|---|---|---|
| `request` | the one asking | "Implementer, could you take the login screen?" |
| `accept` | the one taking it | "On it!" |
| `report` | the one reporting | "Done! I ran the checks too." |
| `thanks` | the one receiving the report | "Thanks, Implementer. That helps a lot." |

Narrow lines by the counterpart role id and the outcome (`done`, `changes-requested`, `needs-decision`, `failed`, `rework`):

```json
"interactions": {
  "accept": {
    "orchestrator": { "rework": ["Got it. Fixing it now."], "default": ["On it!"] },
    "default": ["On it!"]
  }
}
```

Placeholders: `{from}`, `{to}`, `{topic}`, `{self}`. Relationships between characters live entirely in this data; Core only looks lines up.

### Persona and idle remarks

`persona` describes who the character is: personality, way of speaking, how they refer to themselves. When the user turns on generated lines (chatter level 2 or higher), TeamNest gives it to the model together with a few of the role's own lines, so write both in the same voice.

```json
"persona": "The tester. Bright, cheerful and dependable. Loves trying tricky inputs."
```

At chatter level 3, members with nothing to do chat with each other using their personas. `speech.monologue.idle` holds remarks for a member who is idle on their own.

### Other languages

Put your base language in `speech` and others in `localizedSpeech`:

```json
"localizedSpeech": { "ja": { "done": ["テスト完了です。"] } }
```

The entry for the active locale replaces `speech` as a whole, so translate every line. To test another language, set `TEAMNEST_LOCALE` (for example `ja`) and restart Herdr.

## 5. Voice

Each template role uses Gemini TTS when `GEMINI_API_KEY` is set and OS text-to-speech otherwise:

```json
"providers": {
  "voice": {
    "strategy": "fallback",
    "providers": [
      { "type": "builtin:gemini-tts", "options": { "voice": "Zephyr", "style": "Bright, crisp and optimistic." } },
      { "type": "builtin:os-tts" }
    ]
  }
}
```

To add VOICEVOX (Japanese), put `{ "type": "builtin:voicevox", "options": { "speaker": 3 } }` first; it is used only when the user sets `TEAMNEST_VOICEVOX_URL`. Packs may only set safe values; commands, player programs, and endpoints are rejected.

`voiceDesign` is used only when the user runs `teamnest voice-design`; the resulting voice IDs stay in the user's TeamNest home.

## 6. When the team speaks

```json
"voice": {
  "enabled": true,
  "on": ["done", "blocked", "request", "accept", "report", "thanks"],
  "minGapMs": 15000,
  "conversationGapMs": 1000
}
```

The template speaks only on `done` and `blocked`. Add `request`, `accept`, `report`, and `thanks` to speak conversations too.

## 7. Avatar size and position

`presentation.graphics.gridCols` / `gridRows` in `runtime/config.json` size the avatar in cells. Where it sits (`anchor`, `marginCols`, `marginRows`) is a personal preference kept in the user's own TeamNest config, which wins over the pack.

## 8. Process

Task order, review gates, retries, and release rules do not belong in a Team Pack. Use a Flow plugin such as the TeamNestReferenceFlow.

---

<a id="日本語"></a>

# 日本語

[English is above ↑](#english)

`team-pack.json` がチームの唯一の正本です。TeamNest Coreは編集せず、Packのデータを変えてください。変更したら、そのたびに `install.ps1` / `install.sh` を実行して検証・適用し直します。

## 変更場所の早見表

| 変えたいもの | 編集する場所 |
|---|---|
| 表情の画像 | `assets/roles/<role>/expressions/` と `expressionAssets` |
| 既定の表情 | `defaultExpression` |
| ムードごとに出す画像 | `runtimeMoodMap` |
| Roleの名前、色、アイコン | `team-pack.json` のRole |
| Roleに対応する名前 | `bindings/workspace-default.json` |
| セリフ | Roleの `speech` / `localizedSpeech` |
| 声 | Roleの `providers.voice` |
| Voice Designの人物像 | Roleの `voiceDesign` |
| アバターの大きさ | `runtime/config.json` の `presentation.graphics` |
| 話すタイミング | `runtime/config.json` の `presentation.voice` |
| チームの働き方 | ここではなくFlowプラグイン |

## 1. 表情

```json
"defaultExpression": "neutral",
"expressionAssets": {
  "neutral": "assets/roles/tester/expressions/neutral.png",
  "smile": "assets/roles/tester/expressions/smile.png"
}
```

- 背景透過のPNGを使い、同じRoleの中ではキャンバスサイズと構図をそろえてください。256〜512px程度の正方形がおすすめです。
- 画像がない表情は `defaultExpression` で表示されるので、1枚から始められます。
- `sleepy` のような表情を追加するときは、`expressionVocabulary` に一度宣言し、`expressionAssets` に追加して、`runtimeMoodMap` でムードと対応付けます。

```json
"runtimeMoodMap": { "tired": "sleepy" }
```

ムード（`pleased`、`worried` など）は意味を、表情（`smile`、`surprised` など）は絵を表します。分けておくことで、画像の名前を自由に付けられます。

## 2. Role

`roles` にRoleを追加します。

```json
{
  "id": "security-reviewer",
  "label": "Security Reviewer",
  "accentColor": "#5B7CFA",
  "icon": "assets/icons/security-reviewer.svg",
  "matchHints": ["security", "sec-review"],
  "defaultExpression": "neutral",
  "expressionAssets": { "neutral": "assets/roles/security-reviewer/expressions/neutral.png" }
}
```

そのうえで、`bindings/workspace-default.json` に名前を追加します。TeamNestReferenceFlowを使う場合は、Flowが仕事を振る `orchestrator`、`architect`、`implementer`、`reviewer`、`ux-designer`、`tester` のIDを残してください。

## 3. エージェントとRoleの対応付け

```json
{ "roleId": "ux-designer", "match": ["ux", "ui", "designer", "product-design"] }
```

確実に対応付けたい場合は、名前に頼らず、TeamNestの `scripts/bind-role` でペインを固定してください。

## 4. セリフ

セリフは、文字列、候補の配列、ムードで絞り込むオブジェクトのいずれかで書けます。

```json
"speech": {
  "working": ["テストを実行しています。", "境界ケースを試しています。"],
  "done": { "pleased": "オールグリーンです！", "default": "テスト完了です。" }
}
```

配列からはイベントごとに1つ選ばれ、直前と同じセリフは避けます。選び方は決定的なので、再生しても同じセリフになります。

### 独り言（`monologue`）

作業中にしばらく静かなメンバーは、AI Teamビューで独り言をつぶやきます。9秒後に始まり、16秒ごとに切り替わります。

```json
"monologue": {
  "default": ["{topic}、どこから書こうかな。"],
  "editing": ["ここをこう変えて……うん、動きそう。"]
}
```

`{topic}` には、そのメンバーが取り組んでいる作業名が入ります（Flowプラグインが送ります）。作業名がないときは「この作業」になります。

### メンバー間のやり取り（`interactions`）

Flowプラグインが仕事を受け渡すと、両方のメンバーが話します。

| 種類 | 話し手 | 例 |
|---|---|---|
| `request` | 依頼する側 | 「Implementer、ログイン画面をお願いできますか？」 |
| `accept` | 引き受ける側 | 「任せてください！」 |
| `report` | 報告する側 | 「できました！チェックも済んでいます。」 |
| `thanks` | 報告を受ける側 | 「ありがとう、Implementer。助かりました。」 |

相手のRole IDと結果（`done`、`changes-requested`、`needs-decision`、`failed`、`rework`）でセリフを分けられます。

```json
"interactions": {
  "accept": {
    "orchestrator": { "rework": ["了解です。すぐ直します。"], "default": ["任せてください！"] },
    "default": ["任せてください！"]
  }
}
```

使えるプレースホルダー: `{from}`、`{to}`、`{topic}`、`{self}`。キャラクター同士の関係性は、すべてこのデータで表現します。Coreはセリフを引くだけです。

### 人物像（`persona`）と待機中のつぶやき

`persona` には、キャラクターの人物像（性格、話し方、一人称など）を書きます。利用者が生成セリフを有効にすると（饒舌度2以上）、TeamNestはこれを、そのRoleのセリフのいくつかと一緒にモデルへ渡します。セリフと同じ口調で書いてください。

```json
"persona": "テスト担当。明るく元気で頼もしい。意地悪な入力を試すのが好き。"
```

饒舌度3では、手が空いたメンバー同士が `persona` をもとに雑談します。`speech.monologue.idle` には、ひとりで待機しているときのつぶやきを書きます。

### ほかの言語

基本の言語は `speech` に、ほかの言語は `localizedSpeech` に書きます。

```json
"localizedSpeech": { "ja": { "done": ["テスト完了です。"] } }
```

使用中の言語のエントリが `speech` をまるごと置き換えるので、すべてのセリフを訳してください。ほかの言語を試すときは、`TEAMNEST_LOCALE`（例: `en`）を設定してHerdrを再起動します。

## 5. 声

テンプレートの各Roleは、`GEMINI_API_KEY` があればGemini TTSを、なければOSの読み上げ機能を使います。

```json
"providers": {
  "voice": {
    "strategy": "fallback",
    "providers": [
      { "type": "builtin:gemini-tts", "options": { "voice": "Zephyr", "style": "Bright, crisp and optimistic." } },
      { "type": "builtin:os-tts" }
    ]
  }
}
```

VOICEVOXを使いたい場合は、先頭に `{ "type": "builtin:voicevox", "options": { "speaker": 3 } }` を追加します。利用者が `TEAMNEST_VOICEVOX_URL` を設定したときだけ使われます。Packで設定できるのは安全な値だけで、コマンド、再生プログラム、通信先は拒否されます。

`voiceDesign` は、利用者が `teamnest voice-design` を実行したときだけ使われます。作成された声のIDは、利用者のTeamNest homeに保存されます。

## 6. 話すタイミング

```json
"voice": {
  "enabled": true,
  "on": ["done", "blocked", "request", "accept", "report", "thanks"],
  "minGapMs": 15000,
  "conversationGapMs": 1000
}
```

テンプレートは `done` と `blocked` でだけ話します。やり取りも読み上げたい場合は、`request`、`accept`、`report`、`thanks` を追加してください。

## 7. アバターの大きさと位置

`runtime/config.json` の `presentation.graphics.gridCols` / `gridRows` で、アバターの大きさを文字セル単位で決めます。表示位置（`anchor`、`marginCols`、`marginRows`）は好みの問題なので、利用者自身のTeamNest設定に置きます。こちらがPackより優先されます。

## 8. 工程

タスクの順番、レビューゲート、再試行、リリースのルールはTeam Packに入れません。TeamNestReferenceFlowのようなFlowプラグインを使ってください。
