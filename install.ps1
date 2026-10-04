# Validate this Team Pack and make it the active TeamNest team.
# TeamNest Core is found in this order: -CoreDir, $env:TEAMNEST_CORE_DIR,
# a sibling ..\TeamNest checkout, then a `teamnest` command on PATH.
param([string]$CoreDir)
$ErrorActionPreference = "Stop"
$PackDir = $PSScriptRoot

function Invoke-Core {
  param([string[]]$Arguments)
  if ($script:CoreCli) { & node $script:CoreCli @Arguments } else { & teamnest @Arguments }
  if ($LASTEXITCODE -ne 0) { throw "teamnest $($Arguments -join ' ') failed with exit code $LASTEXITCODE" }
}

$candidates = @($CoreDir, $env:TEAMNEST_CORE_DIR, (Join-Path $PackDir "..\TeamNest")) | Where-Object { $_ }
$script:CoreCli = $candidates | ForEach-Object { Join-Path $_ "bin\teamnest.mjs" } | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $script:CoreCli -and -not (Get-Command teamnest -ErrorAction SilentlyContinue)) {
  throw "TeamNest Core was not found. Clone it next to this pack (..\TeamNest), set TEAMNEST_CORE_DIR, or pass -CoreDir."
}

Invoke-Core @("validate-pack", $PackDir)
Invoke-Core @("apply-pack", $PackDir)
Write-Host "Applied the Team Pack. Restart Herdr if TeamNest was already running."
