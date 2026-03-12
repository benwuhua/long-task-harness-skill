#!/usr/bin/env bash
# Long-Task Harness Skill installer for OpenCode (macOS / Linux)
# Usage: curl -fsSL https://raw.githubusercontent.com/benwuhua/long-task-harness-skill/main/install.sh | bash
set -euo pipefail

INSTALL_DIR="${HOME}/.config/opencode/long-task-harness-skill"
PLUGINS_DIR="${HOME}/.config/opencode/plugins"
SKILLS_DIR="${HOME}/.config/opencode/skills"
REPO_URL="https://github.com/benwuhua/long-task-harness-skill.git"

echo "Installing long-task-harness-skill for OpenCode..."

if [ -d "${INSTALL_DIR}/.git" ]; then
  echo "  -> Updating existing installation..."
  git -C "${INSTALL_DIR}" pull --ff-only
else
  echo "  -> Cloning repository..."
  git clone "${REPO_URL}" "${INSTALL_DIR}"
fi

mkdir -p "${PLUGINS_DIR}" "${SKILLS_DIR}"

rm -f "${PLUGINS_DIR}/long-task.js"
rm -rf "${SKILLS_DIR}/long-task"

ln -s "${INSTALL_DIR}/.opencode/plugins/long-task.js" "${PLUGINS_DIR}/long-task.js"
ln -s "${INSTALL_DIR}/skills" "${SKILLS_DIR}/long-task"

echo
echo "Done."
echo "  Plugin: ${PLUGINS_DIR}/long-task.js"
echo "  Skills: ${SKILLS_DIR}/long-task"
echo
echo "Restart OpenCode to activate the updated plugin and skills."
