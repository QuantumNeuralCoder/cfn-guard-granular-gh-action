#!/bin/sh
set -e

if [ -z "$INPUT_DATA_DIRECTORY" ]; then
  echo "INPUT_DATA_DIRECTORY is not set. Quitting."
  exit 1
fi

if [ ! -d "$INPUT_DATA_DIRECTORY" ]; then
  echo "Path $INPUT_DATA_DIRECTORY does not exist. Skipping validation."
  exit 0
fi

if ! ls "$INPUT_DATA_DIRECTORY"/*.json "$INPUT_DATA_DIRECTORY"/*.json 1> /dev/null 2>&1; then
  echo "No CloudFormation templates found in $INPUT_DATA_DIRECTORY. Skipping validation."
  exit 0
fi

if [ -n "$INPUT_RULE_SET_URL" ]; then
  echo "Downloading rules from $INPUT_RULE_SET_URL..."
  curl -sSL "$INPUT_RULE_SET_URL" -o /tmp/custom.guard
  if [ ! -s /tmp/custom.guard ]; then
    echo "Failed to download or empty rule file. Quitting."
    exit 1
  fi
  RULES_PATH="/tmp/custom.guard"

else
  echo "No rule source provided. Set rule_set_url, custom_rules_directory, or rule_set_url. Quitting."
  exit 1
fi

echo "Running: cfn-guard validate --data $INPUT_DATA_DIRECTORY --rules $RULES_PATH --show-summary $INPUT_SHOW_SUMMARY --output-format $INPUT_OUTPUT_FORMAT"

cfn-guard validate \
  --data "$INPUT_DATA_DIRECTORY" \
  --rules "$RULES_PATH" \
  --show-summary "$INPUT_SHOW_SUMMARY" \
  --output-format "$INPUT_OUTPUT_FORMAT"
