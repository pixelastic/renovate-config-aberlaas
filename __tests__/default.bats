bats_load_library 'helper'

setup() {
  ROOT_DIR="${BATS_TEST_DIRNAME%/*}"
  PRESET_PATH="$ROOT_DIR/default.json"
  PACKAGE_PATH="$ROOT_DIR/package.json"
}

@test "Renovate's validator accepts the preset without errors or migration warnings" {
  run npx --yes --package renovate -- \
    renovate-config-validator \
    --strict \
    --no-global \
    "$PRESET_PATH"
  [[ "$status" -eq 0 ]]
  [[ "$output" != *"WARN"* ]]
  [[ "$output" != *"ERROR"* ]]
}

@test "preset contains no deprecated option names" {
  local deprecatedKeys='["packageNames","packagePatterns","excludePackageNames","excludePackagePatterns","rebaseStalePrs","masterIssue","masterIssueAutoclose","masterIssueTitle","node"]'
  run jq \
    --exit-status \
    --argjson deprecatedKeys "$deprecatedKeys" \
    '[.. | objects | keys[]] - $deprecatedKeys == [.. | objects | keys[]]' \
    "$PRESET_PATH"
  [[ "$status" -eq 0 ]]
}

@test "json-lint reports no errors on package.json" {
  bats_run_zsh "json-lint --json $PACKAGE_PATH"
  [[ "$status" -eq 0 ]]
  [[ "$output" == "[]" ]]
}

@test "json-lint reports no errors on the preset" {
  [[ -f "$PRESET_PATH" ]]
  bats_run_zsh "json-lint --json $PRESET_PATH"
  [[ "$status" -eq 0 ]]
  [[ "$output" == "[]" ]]
}
