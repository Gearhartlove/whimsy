#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPT=$(cat "$SCRIPT_DIR/prompt.md")

claude --permission-mode acceptEdits "$PROMPT"
