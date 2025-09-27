# Quick start script for Hugo blog
Write-Host "Ardalis Hugo Blog - Quick Start" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green

# Check if Hugo is installed
try {
    $hugoVersion = hugo version
    Write-Host "✓ Hugo is installed: $hugoVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Hugo is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Hugo from: https://gohugo.io/installation/" -ForegroundColor Yellow
    exit 1
}

# Navigate to beta directory
Set-Location $PSScriptRoot

Write-Host ""
Write-Host "Available commands:" -ForegroundColor Cyan
Write-Host "1. Start development server (with drafts): hugo server -D" -ForegroundColor White
Write-Host "2. Start development server (published only): hugo server" -ForegroundColor White
Write-Host "3. Build for production: hugo" -ForegroundColor White
Write-Host "4. Create new blog post: hugo new blog/post-name.md" -ForegroundColor White

Write-Host ""
$choice = Read-Host "Enter choice (1-4) or press Enter to start development server"

switch ($choice) {
    "1" { 
        Write-Host "Starting development server with drafts..." -ForegroundColor Green
        hugo server -D
    }
    "2" { 
        Write-Host "Starting development server (published only)..." -ForegroundColor Green
        hugo server 
    }
    "3" { 
        Write-Host "Building for production..." -ForegroundColor Green
        hugo
        Write-Host "Build complete! Files are in ./public/" -ForegroundColor Green
    }
    "4" { 
        $postName = Read-Host "Enter post name (e.g., my-new-post)"
        if ($postName) {
            hugo new "blog/$postName.md"
            Write-Host "New post created: content/blog/$postName.md" -ForegroundColor Green
        }
    }
    default { 
        Write-Host "Starting development server with drafts..." -ForegroundColor Green
        hugo server -D 
    }
}