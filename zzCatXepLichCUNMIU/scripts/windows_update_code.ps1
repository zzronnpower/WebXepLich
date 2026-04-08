param(
  [string]$Branch = "main",
  [string]$ComposeFile = "docker-compose.yml",
  [switch]$NoBuild
)

$ErrorActionPreference = "Stop"

function Write-Step {
  param([string]$Message)
  Write-Host "[STEP] $Message" -ForegroundColor Cyan
}

function Assert-Command {
  param([string]$Name)
  if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
    throw "Khong tim thay lenh '$Name'. Hay cai dat truoc."
  }
}

Assert-Command "git"
Assert-Command "docker"

if (-not (Test-Path ".git")) {
  throw "Thu muc hien tai khong phai git repo. Hay chay script trong thu muc goc du an."
}

if (-not (Test-Path $ComposeFile)) {
  throw "Khong tim thay $ComposeFile."
}

$DaStash = $false
$MaStash = ""

try {
  Write-Step "Kiem tra thay doi local"
  $TrangThai = (git status --porcelain).Trim()
  if ($TrangThai) {
    $MaStash = "auto-stash-before-update-" + (Get-Date -Format "yyyyMMdd-HHmmss")
    Write-Step "Tao tam stash de pull code an toan"
    git stash push -u -m $MaStash | Out-Null
    $DaStash = $true
  }

  Write-Step "Lay code moi tu origin"
  git fetch origin
  git checkout $Branch
  git pull --ff-only origin $Branch

  Write-Step "Dam bao DB dang chay (giu nguyen volume)"
  docker compose -f $ComposeFile up -d db

  if ($NoBuild) {
    Write-Step "Restart web khong build lai"
    docker compose -f $ComposeFile up -d web
  }
  else {
    Write-Step "Build lai web service"
    docker compose -f $ComposeFile up -d --build web
  }

  Write-Step "Kiem tra trang thai services"
  docker compose -f $ComposeFile ps

  Write-Host "Hoan tat cap nhat code. DB duoc giu nguyen (khong down -v, khong reset DB)." -ForegroundColor Green
  Write-Host "App: http://localhost:8000" -ForegroundColor Green
}
finally {
  if ($DaStash) {
    Write-Step "Phuc hoi thay doi local da stash"
    git stash pop | Out-Host
  }
}
