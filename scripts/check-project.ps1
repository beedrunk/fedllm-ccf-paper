param(
    [string]$Root = "."
)

$ErrorActionPreference = "Stop"

$required = @(
    "README.md",
    "AGENTS.md",
    "PROJECT_STATE.md",
    "docs/archival-policy.md",
    "docs/github-sync.md",
    "docs/direction-decision.md",
    "docs/dataset-strategy.md",
    "docs/no-fabrication-protocol.md",
    "docs/roadmap.md",
    "docs/executable-plan-3months.md",
    "docs/project-constraints.md",
    "literature/evidence-ledger.csv",
    "literature/search-log.md",
    "experiments/experiment-registry.csv",
    "experiments/run-log.md",
    "manuscript/outline.md",
    "manuscript/draft.md",
    "journal/ccf-targets.md",
    "review/checklists.md"
)

$missing = @()
foreach ($file in $required) {
    $path = Join-Path $Root $file
    if (-not (Test-Path -LiteralPath $path)) {
        $missing += $file
    }
}

if ($missing.Count -gt 0) {
    Write-Host "Missing required files:"
    $missing | ForEach-Object { Write-Host " - $_" }
    exit 1
}

Write-Host "Project structure check passed."
