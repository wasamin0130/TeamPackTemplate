<div align="center">

<img src="assets/brand/teamnest-logo.svg" width="96" alt="TeamNest logo">

# TeamNest Team Pack Template

**A ready-to-use sample team for [TeamNest](https://github.com/wasamin0130/TeamNest), and the starting point for your own.**

[English](#english) · [**日本語はこちら**](#日本語)

</div>

---

<a id="english"></a>

## What is this?

A **Team Pack** defines who is on your TeamNest team and how they look and talk: roles, expression images, lines of dialogue, and voice settings. The Pack manifest is declarative data. Review its text and assets before sharing, and use trusted Packs: personas may be passed to AI agents and voice services may receive dialogue.

Role names and typical jobs below belong to this sample. You choose your own team composition, responsibilities and process; TeamNest does not prescribe them.

This template gives you a complete six-role team you can use right away, and a clean base to turn into your own team.

| Role | Color | Typical job |
|---|---|---|
| Orchestrator | blue | Talks to you and coordinates the team |
| Architect | purple | Design and structure |
| Implementer | red | Writes the code |
| Reviewer | green | Reviews the changes |
| UX Designer | orange | Looks at the user experience |
| Tester | yellow | Verifies behavior |

The role ids match the [TeamNestReferenceFlow](https://github.com/wasamin0130/TeamNestReferenceFlow), so the members also talk to each other when you run that flow.

Every role has five expressions, English lines, and Japanese lines that are used automatically on a Japanese system. `runtimeMoodMap` shows each expression for one or more of TeamNest's seven moods:

| Expression | Shown for |
|---|---|
| `neutral` (— —) | `neutral`, `focused`, `tired` |
| `smile` (^ ^) | `pleased` |
| `surprised` (o o) | `attentive` |
| `strained` (> <) | `blocked` |
| `teary` (T T) | `worried` |

The images are sample avatars. Replace them to give your team its own look.

## Use it as is

You need [TeamNest](https://github.com/wasamin0130/TeamNest) installed in [Herdr](https://herdr.dev/). Clone this repository next to it:

```text
workspaces/
├─ TeamNest/
└─ TeamPackTemplate/
```

Then apply the pack:

```powershell
.\install.ps1
```

```bash
bash ./install.sh
```

The script finds TeamNest Core in a sibling `TeamNest` folder, in `TEAMNEST_CORE_DIR`, or as a `teamnest` command on your PATH. You can also pass the Core directory explicitly (`.\install.ps1 -CoreDir <path>` / `bash ./install.sh <path>`).

Check it inside Herdr:

```bash
herdr plugin action invoke teamnest.open-team
```

## Make it your own

1. **Copy** this repository (or use GitHub's *Use this template*) and give it a new name.
2. **Change the identity** in `team-pack.json`: `id` (use a reverse domain you own, for example `io.github.yourname.my-team`), `name`, `version`.
3. **Replace the images** under `assets/roles/<role>/expressions/` with your own PNGs.
4. **Rewrite the lines** in each role's `speech` (and `localizedSpeech` for other languages).
5. **Adjust** role colors, icons, name hints, and voices as you like.
6. **Validate and apply**: run `install.ps1` / `install.sh` again after every change.

Step-by-step guide: **[Customization guide](docs/CUSTOMIZATION.md)**
Format reference: **[Team Pack specification](https://github.com/wasamin0130/TeamNest/blob/main/docs/TEAM-PACK-SPEC.md)**

## Create your team with an LLM

An LLM can interview you about roles, characters, speaking styles, appearance, and relationships, then build your pack in a copy of this template. Start with the **[copy-and-paste prompt](docs/AI-CREATION.md#english-starter-prompt)**. A reusable **[create-team-pack Agent Skill](skills/create-team-pack/SKILL.md)** is included too.

The workflow saves design decisions so you can resume, creates visual assets when image tools are available, and reports missing assets or validation explicitly. Team Packs customize presentation and dialogue; task execution belongs to a Flow.

## Layout

```text
TeamPackTemplate/
├─ team-pack.json               # roles, expressions, lines, voices (single source of truth)
├─ bindings/
│  └─ workspace-default.json    # agent / pane names that map to each role
├─ runtime/
│  └─ config.json               # avatar size, when to speak
├─ assets/
│  ├─ brand/                    # logo
│  ├─ icons/<role>.svg
│  └─ roles/<role>/expressions/<expression>.png
├─ docs/CUSTOMIZATION.md
├─ install.ps1
└─ install.sh
```

## Voice

Out of the box, TeamNest speaks with your OS text-to-speech. Each role also declares a Gemini TTS voice, used automatically when `GEMINI_API_KEY` is set. See [Voice Providers](https://github.com/wasamin0130/TeamNest/blob/main/docs/VOICE-PROVIDERS.md).

## Sharing your pack

Made your own team? Please share it. Post it in [Show and tell](https://github.com/wasamin0130/TeamNest/discussions/categories/show-and-tell) on TeamNest's GitHub Discussions: a screenshot of your team or a link to your pack is plenty. Before you publish it:

- Keep the pack data only: TeamNest rejects packs that try to run commands, load code, or choose network endpoints.
- Never commit API keys.
- Make sure you have the rights to every image and voice you include.
- Run `validate-pack` (the install script does this) before publishing.

## License

[MIT](LICENSE) © 2026 wasamin0130. The sample avatars and icons may be reused in your own packs.

---

<a id="日本語"></a>

# 日本語

[English is above ↑](#english)

## これは何？

**Team Pack**は、TeamNestのチームに「誰がいて、どう見え、どう話すか」を定義するものです。Role、表情の画像、セリフ、音声の設定をまとめています。Packの設定は宣言的なデータです。共有前に文章と画像を確認してください。口調設定がAIエージェントに渡り、音声サービスにセリフを送る場合もあるため、信頼できるPackを使ってください。

以下のRole名と担当は、このサンプルの設定です。独自のチームの名称・人数・担当・進め方は利用者が決めます。TeamNestが標準のRoleや職責を指定するものではありません。

このテンプレートは、すぐに使える6人のチームであり、自分のチームを作るときの出発点でもあります。

| Role | 色 | 主な役割 |
|---|---|---|
| Orchestrator | 青 | あなたの窓口。チームをまとめる |
| Architect | 紫 | 設計・構造 |
| Implementer | 赤 | 実装 |
| Reviewer | 緑 | 変更のレビュー |
| UX Designer | オレンジ | 使い心地の確認 |
| Tester | 黄 | 動作の検証 |

Role IDは[TeamNestReferenceFlow](https://github.com/wasamin0130/TeamNestReferenceFlow)とそろえてあるので、そのFlowを使うと、メンバー同士の会話も表示されます。

各Roleには、5つの表情、英語のセリフ、日本語のセリフがあります。日本語のセリフは、日本語環境で自動的に使われます。`runtimeMoodMap` で、各表情をTeamNestの7つのムードに対応付けています。

| 表情 | 表示されるムード |
|---|---|
| `neutral`（— —） | `neutral`、`focused`、`tired` |
| `smile`（^ ^） | `pleased` |
| `surprised`（o o） | `attentive` |
| `strained`（> <） | `blocked` |
| `teary`（T T） | `worried` |

画像はTeamNestの標準アバターと同じなので、このPackがあってもなくても見た目は変わりません。差し替えて、自分のチームらしい見た目にしてください。

## そのまま使う

[Herdr](https://herdr.dev/)に[TeamNest](https://github.com/wasamin0130/TeamNest)がインストールされている必要があります。このリポジトリを、TeamNestと同じ階層にcloneしてください。

```text
workspaces/
├─ TeamNest/
└─ TeamPackTemplate/
```

Packを適用します。

```powershell
.\install.ps1
```

```bash
bash ./install.sh
```

スクリプトは、隣の `TeamNest` フォルダー、環境変数 `TEAMNEST_CORE_DIR`、PATH上の `teamnest` コマンドの順にTeamNest Coreを探します。Coreの場所を直接指定することもできます（`.\install.ps1 -CoreDir <path>` / `bash ./install.sh <path>`）。

Herdrで確認します。

```bash
herdr plugin action invoke teamnest.open-team
```

## 自分のチームにする

1. このリポジトリを**コピー**し（GitHubの *Use this template* も使えます）、新しい名前を付けます。
2. `team-pack.json` の**識別情報**を変えます: `id`（自分が持つドメインを逆にしたもの。例: `io.github.yourname.my-team`）、`name`、`version`
3. `assets/roles/<role>/expressions/` の**画像**を自分のPNGに差し替えます。
4. 各Roleの `speech`（ほかの言語は `localizedSpeech`）の**セリフ**を書き換えます。
5. Roleの色、アイコン、名前のヒント、声を好みに**調整**します。
6. 変更するたびに `install.ps1` / `install.sh` を実行して、**検証と適用**をします。

手順の詳細: **[カスタマイズガイド](docs/CUSTOMIZATION.md#日本語)**
形式の仕様: **[Team Pack仕様](https://github.com/wasamin0130/TeamNest/blob/main/docs/TEAM-PACK-SPEC.md#日本語)**

## LLMと自分のチームを作る

役割やキャラクターが未定でも、LLMにヒアリングしてもらいながら作れます。テンプレートをコピーした作業フォルダーで、**[開始プロンプト](docs/AI-CREATION.md#開始プロンプト)**を渡してください。再利用できる **[create-team-pack Agent Skill](skills/create-team-pack/SKILL.md)** も同梱しています。

用途・雰囲気から、キャラクターの性格・口調・見た目・関係性まで相談し、設定・セリフ・アセットを作成します。決定事項を保存して続きから再開でき、画像生成が使えない場合は仮アセットと生成プロンプトを残します。Team Packは表示と会話の設定であり、仕事の実行手順はFlow側で設定します。

## フォルダー構成

```text
TeamPackTemplate/
├─ team-pack.json               # Role、表情、セリフ、声（唯一の正本）
├─ bindings/
│  └─ workspace-default.json    # 各Roleに対応するエージェント名・ペイン名
├─ runtime/
│  └─ config.json               # アバターの大きさ、話すタイミング
├─ assets/
│  ├─ brand/                    # ロゴ
│  ├─ icons/<role>.svg
│  └─ roles/<role>/expressions/<expression>.png
├─ docs/CUSTOMIZATION.md
├─ install.ps1
└─ install.sh
```

## 音声

標準では、OSの読み上げ機能で話します。各RoleにはGemini TTSの声も設定してあり、`GEMINI_API_KEY` を設定すると自動的に使われます。詳しくは[Voice Provider](https://github.com/wasamin0130/TeamNest/blob/main/docs/VOICE-PROVIDERS.md#日本語)を参照してください。

## Packを公開するときは

自分のチームを作ったら、ぜひ共有してください。TeamNestのGitHub Discussionsの[Show and tell](https://github.com/wasamin0130/TeamNest/discussions/categories/show-and-tell)に投稿してください。チームのスクリーンショットや、Packへのリンクだけで十分です。公開する前に、次の点を確かめてください。

- Packはデータだけにしてください。コマンドの実行、コードの読み込み、通信先の指定をしようとするPackは、TeamNestが拒否します。
- APIキーをコミットしないでください。
- 含める画像や音声は、すべて権利を確認してください。
- 公開前に `validate-pack` を実行してください（installスクリプトが実行します）。

## ライセンス

[MIT](LICENSE) © 2026 wasamin0130。サンプルのアバターとアイコンは、自分のPackで再利用して構いません。
