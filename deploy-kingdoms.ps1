# deploy-kingdoms.ps1
# Commits and pushes the Kingdoms card viewer + PDFs to GitHub Pages (WernerCD/Kingdoms)
# Files live in the repo itself -- no copy step needed.
# Usage:
#   .\deploy-kingdoms.ps1          -- commit changed files and push
#   .\deploy-kingdoms.ps1 -Force   -- force redeploy via empty commit even if nothing changed

param(
    [switch]$Force
)

# --- Config ------------------------------------------------------------------
$repoUrl = "https://github.com/WernerCD/Kingdoms.git"
$repoDir = "Y:\Code\Kingdoms"
$logFile = "$repoDir\logs\deploy-kingdoms.log"

# --- Logging (buffered -- written once at end) --------------------------------
$logBuffer = [System.Collections.Generic.List[string]]::new()

function Log {
    param([string]$msg, [string]$color = "White")
    $ts   = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $line = "[$ts] $msg"
    Write-Host $line -ForegroundColor $color
    $logBuffer.Add($line)
}

function LogLines {
    param($output, [string]$prefix = "", [string]$color = "DarkGray")
    ($output | Out-String).Trim() -split "`r?`n" | Where-Object { $_ } | ForEach-Object {
        Log "$prefix$_" $color
    }
}

function WriteLog {
    try {
        $dir = Split-Path $logFile -Parent
        if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
        $logBuffer | Add-Content -Path $logFile -Encoding UTF8
    } catch {
        Write-Host "[log write failed: $_]" -ForegroundColor DarkGray
    }
}

# --- Start -------------------------------------------------------------------
Log "----------------------------------------------------" "DarkGray"
if ($Force) {
    Log "Deploy started [-Force]  machine: $env:COMPUTERNAME" "Cyan"
} else {
    Log "Deploy started  machine: $env:COMPUTERNAME" "Cyan"
}

# --- Clone or pull -----------------------------------------------------------
if (Test-Path "$repoDir\.git") {
    Log "Repo found at $repoDir -- pulling..." "Cyan"
    Set-Location $repoDir
    LogLines (git pull 2>&1) "git pull: "
    if ($LASTEXITCODE -ne 0) { Log "ERROR: git pull failed (exit $LASTEXITCODE)" "Red"; WriteLog; exit 1 }
} else {
    Log "Repo not found -- cloning $repoUrl to $repoDir" "Cyan"
    $parent = Split-Path $repoDir -Parent
    if (-not (Test-Path $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
        Log "Created directory: $parent" "DarkGray"
    }
    LogLines (git clone $repoUrl $repoDir 2>&1) "git clone: "
    if ($LASTEXITCODE -ne 0) { Log "ERROR: git clone failed (exit $LASTEXITCODE)" "Red"; WriteLog; exit 1 }
    Set-Location $repoDir
}

# --- Stage -------------------------------------------------------------------
LogLines (git add -A 2>&1) "git add: "

# --- Commit ------------------------------------------------------------------
$status = git status --porcelain | Where-Object { $_ -notmatch '^\?\?' }
$committed = $false

if ($status) {
    $changed = ($status -split "`r?`n" | Where-Object { $_ }) -join ", "
    Log "Changed: $changed" "DarkGray"
    LogLines (git commit -m "Update Kingdoms card viewer and PDFs" 2>&1) "git commit: " "Green"
    if ($LASTEXITCODE -ne 0) { Log "ERROR: git commit failed (exit $LASTEXITCODE)" "Red"; WriteLog; exit 1 }
    $committed = $true
} elseif ($Force) {
    Log "No file changes -- creating empty commit to force redeploy" "Yellow"
    LogLines (git commit --allow-empty -m "Force redeploy (no file changes)" 2>&1) "git commit: " "Yellow"
    if ($LASTEXITCODE -ne 0) { Log "ERROR: git commit failed (exit $LASTEXITCODE)" "Red"; WriteLog; exit 1 }
    $committed = $true
} else {
    Log "Nothing to commit -- all files already up to date" "DarkGray"
    Log "Tip: use -Force to trigger a Pages redeploy with no file changes" "DarkGray"
}

# --- Push --------------------------------------------------------------------
if ($committed) {
    LogLines (git push 2>&1) "git push: " "Cyan"
    if ($LASTEXITCODE -ne 0) { Log "ERROR: git push failed (exit $LASTEXITCODE)" "Red"; WriteLog; exit 1 }
    Log "Done! Live at: https://wernercd.github.io/Kingdoms/" "Yellow"
} else {
    Log "Nothing pushed -- repo is already current" "DarkGray"
}

Log "----------------------------------------------------" "DarkGray"

# --- Write log ---------------------------------------------------------------
WriteLog
