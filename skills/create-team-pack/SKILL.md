---
name: create-team-pack
description: Build a personalized TeamNest Team Pack from TeamPackTemplate through an interview, character design, dialogue, and visual assets. Use for creating or customizing a Team Pack, rather than implementing a Flow or changing TeamNest Core.
---

# Create a Team Pack

Work in the user's copy of TeamPackTemplate. Read `README.md`, `docs/CUSTOMIZATION.md`, `team-pack.json`, `bindings/workspace-default.json`, and `runtime/config.json` from that copy. The repository files are the starting format; keep their version fields unless a verified feature requires a change. If this skill was installed separately, locate the user's template checkout first; do not treat the installed skill directory as the pack.

## Interview and design

Use the user's language. Start with the purpose of the team and the desired atmosphere. Ask at most three related questions per turn, offering concrete options and an “up to you” choice. Skip questions already answered. Offer a coherent proposal when the user delegates choices.

Cover team name/theme, intended Flow and required role IDs, member count/jobs, each character's name, personality, speaking style, appearance, relationships, dialogue languages, and image/voice preferences. Distinguish a role's job from its fictional character: changing the character does not change the actual agent's instructions or abilities. Team Packs define presentation; execution order and delegation belong to a Flow. Preserve the six template role IDs when using TeamNestReferenceFlow. For custom roles, explain that the consuming Flow must support them; do not claim to implement that Flow.

Summarize the proposed members in a compact table with role ID, character name, job, personality, appearance, and sample line. Invite corrections before substantial image generation. Existing authorization to proceed or choose details is sufficient; do not repeatedly seek approval for routine edits.

Record agreed decisions, delegated choices, open questions, and progress in `docs/TEAM-DESIGN.md`. Include per-character visual descriptions and relationships. Keep creative notes here rather than inventing JSON fields. On resume, read this document and inspect current files before continuing.

## Build the pack

- Update identity/branding and role labels, personas, colors, icons, match hints, and dialogue using the existing structure. Use a pack ID in the user's namespace; if unknown, record a provisional ID that must be replaced before sharing.
- Keep `speech` and each `localizedSpeech` locale complete: a locale replaces the whole base speech tree. Write working/done/blocked lines, monologue including idle, and request/accept/report/thanks exchanges. Preserve supported placeholders `{from}`, `{to}`, `{topic}`, `{self}`. Express relationships through persona and counterpart-specific interaction lines using actual role IDs.
- Synchronize role IDs across bindings, match hints, asset paths, interaction counterpart keys, and voice options such as `roleId`. Avoid ambiguous matching hints. Maintain expression vocabulary, default expressions, and mappings for the seven existing runtime moods.
- Keep provider settings supported by the template. Match voice style to character preferences; do not invent provider IDs, voice names, model versions, or custom schema fields. Keep credentials and user-specific generated voice IDs outside the pack.

## Visual assets

Use available image-generation tools for requested character PNGs. Establish a neutral portrait first, then use it as the reference for expression variants so identity, costume, palette, framing, and scale stay consistent. Prefer separate transparent square PNGs, approximately 256–512 px, with matching dimensions and no clipped features. The template expressions are neutral, smile, surprised, strained, and teary. Store them under `assets/roles/<role-id>/expressions/` and verify their actual format, transparency, dimensions, and appearance before declaring them ready. Create simple SVG icons and branding directly when appropriate.

If image tools are unavailable, continue the data work. Keep valid template images as explicitly identified temporary assets, or reference only the images that actually exist. Do not rename an SVG to PNG or claim a prompt is an image. Save reproducible prompts and pending paths in `docs/ASSET-PROMPTS.md`; report the pack as provisional until requested visuals are complete. Respect an explicit choice to reuse template art.

For each prompt, include character identity, distinguishing features, outfit/palette, shared art direction, composition, canvas/background, target expression, output path, and the neutral reference needed for variants. Record which assets were generated, reused, or remain pending in the design document.

## Validate and hand over

Check JSON parsing, referenced file existence, unique role IDs, binding targets, expression/mood references, localization completeness, and counterpart IDs. Run TeamNest's validation separately from activation:

```sh
teamnest validate-pack <pack-directory>
```

If a sibling Core checkout is available, use `node ../TeamNest/bin/teamnest.mjs validate-pack <pack-directory>`. Inspect the actual CLI/specification for unfamiliar features rather than guessing. If Core is unavailable, report that official validation is pending; structural checks alone are not equivalent.

Applying changes to the user's active team is a separate action. When requested, use `install.ps1` / `install.sh` (they validate and apply). Otherwise provide those commands without activating or publishing the pack.

Finish with created files, validation results, any provisional decisions or missing assets, and how to apply the pack. A successful JSON check does not prove that images were generated or a custom Flow supports the new roles.
