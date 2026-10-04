# LLMと自分のTeam Packを作る / Create your team with an LLM

このリポジトリをコピーした作業フォルダーを、ファイル編集ができるLLMに開いてもらい、下のプロンプトを渡してください。役割やキャラクターが未定でも始められます。質問に答えると、LLMがチーム案、設定ファイル、セリフ、利用可能な画像生成ツールによるアセット作成まで進めます。

Open your own copy of this repository in an LLM coding agent and paste the prompt below. You can start without knowing the members or theme. The agent interviews you, proposes a team, edits the pack, and creates artwork when image-generation tools are available.

## 開始プロンプト

```text
このTeamPackTemplateを使って、自分用のTeamNest Team Packをイチから作ってください。
skills/create-team-pack/SKILL.mdを読み、その手順に従ってください。
まず用途と好みの雰囲気を聞き、役割・キャラクター・口調・見た目・関係性を
少しずつヒアリングしてください。一度の質問は3つ以内にして、選択肢やおまかせ案も出してください。
回答済みのことは聞き直さず、未定の部分は案を出してください。
チーム案をまとめてから、設定・セリフ・アイコン・表情PNGをこのフォルダーに作ってください。
画像生成が使えない場合は、仮アセットで進め、生成プロンプトと未完成の一覧を残してください。
決定事項と進捗をdocs/TEAM-DESIGN.mdに保存し、再開できるようにしてください。
最後に検証結果と適用方法を示してください。適用や公開は、こちらが依頼したときに行ってください。
```

## English starter prompt

```text
Build my own TeamNest Team Pack from scratch in this copy of TeamPackTemplate.
Read skills/create-team-pack/SKILL.md and follow it.
Start by asking about my use case and preferred atmosphere. Interview me gradually about
roles, characters, speaking styles, appearance, and relationships, with at most three
questions per turn. Offer options and an “up to you” choice; propose ideas for undecided details.
Summarize the team before creating the configuration, dialogue, icons, and expression PNGs here.
If image generation is unavailable, use clearly marked temporary assets and save prompts and pending work.
Save decisions and progress in docs/TEAM-DESIGN.md so we can resume.
Finish with validation results and application instructions. Apply or publish only when I request it.
```

## 何ができあがるか / Deliverables

| ファイル / File | 内容 / Contents |
|---|---|
| `team-pack.json` | チーム・キャラクター・セリフ・表情・音声 / Team, personas, dialogue, expressions, voices |
| `bindings/workspace-default.json` | エージェント名とRoleの対応 / Agent names mapped to roles |
| `runtime/config.json` | 表示や読み上げの好み / Display and speech preferences |
| `assets/` | 表情PNG、SVGアイコン、ロゴ / Expression PNGs, SVG icons, logo |
| `docs/TEAM-DESIGN.md` | 決定事項、キャラクター設定、進捗、未決事項 / Design decisions and progress |
| `docs/ASSET-PROMPTS.md`（必要な場合 / when needed） | 画像生成プロンプト、参照画像、未作成ファイル / Image prompts, references, pending files |

キャラクターの名前や性格は自由に変えられます。TeamNestReferenceFlowを使う場合は、連携に必要な6つのRole IDを維持します。独自の役割も作れますが、それを使うFlow側の対応が必要です。Team Packの性格設定は表示・会話用であり、実際のコーディングエージェントの指示や能力を変更するものではありません。

Character identities are freely customizable. Keep the six template role IDs for TeamNestReferenceFlow compatibility. Custom roles require support in the consuming Flow. Personas affect presentation and dialogue; they do not configure the coding agents' actual instructions or abilities.

## Skillとして使う / Use as a skill

同梱の[create-team-pack Skill](../skills/create-team-pack/SKILL.md)を、利用しているエージェントのSkillフォルダーにディレクトリごとコピーして使うこともできます。自動検出されない環境でも、開始プロンプトのようにファイルを直接読むよう指示できます。Skill単体をコピーした場合も、作業対象としてこのテンプレートのコピーが必要です。

You can also copy the whole `skills/create-team-pack/` directory into your agent's skill directory. Explicitly asking the agent to read the file works without automatic discovery. An installed skill still needs a separate template checkout to edit.

## 続きから作る / Resume

```text
skills/create-team-pack/SKILL.mdとdocs/TEAM-DESIGN.mdを読み、現在のファイルを確認して
前回の続きから進めてください。今回は［変更したい点・作りたいアセット］をお願いします。
```

To resume, ask the agent to read the skill and `docs/TEAM-DESIGN.md`, inspect the current files, and continue with your requested changes.

完成後は `teamnest validate-pack <pack-directory>` で検証できます。`install.ps1` / `install.sh` は検証に加えて、アクティブなチームへの適用も行います。画像生成・Coreによる検証が未実施なら、その作業は未完了として引き継ぎます。

Validate with `teamnest validate-pack <pack-directory>`. `install.ps1` / `install.sh` also activate the pack. Missing image generation or official Core validation remains explicitly pending.
