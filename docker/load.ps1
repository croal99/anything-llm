# Anything LLM Docker Start Script (PowerShell version)
# Use script directory\AnythinLLM as storage location

# Switch to script directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ScriptDir

# Set storage location to AnythinLLM folder under script directory
$env:STORAGE_LOCATION = Join-Path $ScriptDir "AnythinLLM"

# Create storage directory (if not exists)
If (!(Test-Path $env:STORAGE_LOCATION)) {
    New-Item $env:STORAGE_LOCATION -ItemType Directory | Out-Null
}

# Create .env file (if not exists)
If (!(Test-Path "$env:STORAGE_LOCATION\.env")) {
    New-Item "$env:STORAGE_LOCATION\.env" -ItemType File | Out-Null
}

# Start Docker container
docker run -d --rm -p 3001:3001 `
    --cap-add SYS_ADMIN `
    -v "$env:STORAGE_LOCATION`:/app/server/storage" `
    -v "$env:STORAGE_LOCATION\.env:/app/server/.env" `
    -e STORAGE_DIR="/app/server/storage" `
    mintplexlabs/anythingllm

# Show access information
Write-Host ""
Write-Host "==================="
Write-Host "   Anything LLM Started!"
Write-Host "==================="
Write-Host ""
Write-Host "   Access URL: http://localhost:3001"
Write-Host "   Storage: $env:STORAGE_LOCATION"
Write-Host ""
Write-Host "==================="
Write-Host "   Common Docker Commands:"
Write-Host "     View logs: docker logs -f (docker ps -qf 'name=anythingllm')"
Write-Host "     Stop container: docker stop (docker ps -qf 'name=anythingllm')"
Write-Host "==================="
Write-Host ""

# Pause to view output
Read-Host "Press Enter to exit"
