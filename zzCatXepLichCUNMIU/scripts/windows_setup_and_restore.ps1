param(
  [string]$DumpPath = "",
  [string]$ComposeFile = "docker-compose.yml"
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

Assert-Command "docker"

if (-not (Test-Path $ComposeFile)) {
  throw "Khong tim thay $ComposeFile. Hay chay script trong thu muc goc du an."
}

Write-Step "Khoi dong Docker services"
docker compose -f $ComposeFile up -d --build

if ($DumpPath -eq "") {
  Write-Host "Khong co dump path. Bo qua restore DB." -ForegroundColor Yellow
  Write-Host "App dang chay tai http://localhost:8001" -ForegroundColor Green
  exit 0
}

if (-not (Test-Path $DumpPath)) {
  throw "Khong tim thay file dump: $DumpPath"
}

$ResolvedDumpPath = (Resolve-Path $DumpPath).Path
$LowerPath = $ResolvedDumpPath.ToLowerInvariant()
$WorkingDumpPath = $ResolvedDumpPath

if ($LowerPath.EndsWith(".gz")) {
  Write-Step "Giai nen dump .gz"
  $WorkingDumpPath = $ResolvedDumpPath.Substring(0, $ResolvedDumpPath.Length - 3)
  if (Test-Path $WorkingDumpPath) {
    Remove-Item $WorkingDumpPath -Force
  }
  $inStream = [System.IO.File]::OpenRead($ResolvedDumpPath)
  $outStream = [System.IO.File]::Create($WorkingDumpPath)
  try {
    $gzipStream = New-Object System.IO.Compression.GzipStream($inStream, [System.IO.Compression.CompressionMode]::Decompress)
    try {
      $gzipStream.CopyTo($outStream)
    }
    finally {
      $gzipStream.Dispose()
    }
  }
  finally {
    $outStream.Dispose()
    $inStream.Dispose()
  }
}

Write-Step "Lay container db id"
$DbContainerId = (docker compose -f $ComposeFile ps -q db).Trim()
if (-not $DbContainerId) {
  throw "Khong tim thay container db."
}

Write-Step "Copy dump vao container"
docker cp "$WorkingDumpPath" "${DbContainerId}:/tmp/restore.sql"

Write-Step "Restore database"
docker compose -f $ComposeFile exec -T db psql -U lich_user -d lich_lam_viec -f /tmp/restore.sql

Write-Step "Don file tam trong container"
docker compose -f $ComposeFile exec -T db rm -f /tmp/restore.sql

Write-Step "Restart web"
docker compose -f $ComposeFile restart web

Write-Host "Hoan tat. App tai: http://localhost:8001" -ForegroundColor Green
