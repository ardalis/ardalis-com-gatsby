# Build script for Hugo beta blog
param(
    [switch]$Production
)

Write-Host "Building Hugo beta blog..." -ForegroundColor Green

# Navigate to beta directory
Set-Location $PSScriptRoot

if ($Production) {
    Write-Host "Building for production..." -ForegroundColor Yellow
    hugo --cleanDestinationDir
    Write-Host "Production build complete! Files are in ./public/" -ForegroundColor Green
} else {
    Write-Host "Starting development server..." -ForegroundColor Yellow
    Write-Host "Site will be available at: http://localhost:1313" -ForegroundColor Cyan
    Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Cyan
    hugo server -D --bind 0.0.0.0 --port 1313
}