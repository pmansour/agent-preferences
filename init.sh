#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

link_file() {
  local src="$1" dest="$2"
  if [ -L "$dest" ]; then
    local current
    current="$(readlink "$dest")"
    if [ "$current" = "$src" ]; then
      echo "  ok: $dest (already linked)"
      return
    fi
    echo "  update: $dest -> $src (was $current)"
    ln -sfn "$src" "$dest"
  elif [ -e "$dest" ]; then
    echo "  WARN: $dest exists as a regular file/dir — skipping (remove it manually to link)"
    return 1
  else
    echo "  link: $dest -> $src"
    ln -s "$src" "$dest"
  fi
}

echo "Linking global agent configs..."
link_file "$REPO_DIR/CLAUDE.md" "$HOME/CLAUDE.md"
link_file "$REPO_DIR/AGENTS.md" "$HOME/AGENTS.md"

echo "Linking skills into ~/.claude/skills/..."
mkdir -p "$HOME/.claude/skills"
for skill_dir in "$REPO_DIR"/skills/*/; do
  skill_name="$(basename "$skill_dir")"
  link_file "$skill_dir" "$HOME/.claude/skills/$skill_name"
done

echo "Done."
