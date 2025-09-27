#!/bin/bash

echo "Building for branch: $HEAD"
echo "Current directory: $(pwd)"
echo "Available files: $(ls -la)"

# Check if we're on a Hugo branch and beta folder exists
if [[ "$HEAD" == *"hugo"* ]] && [[ -d "beta" ]]; then
    echo "Detected Hugo branch with beta folder - building with Hugo"
    cd beta
    
    # Set Hugo version
    export HUGO_VERSION="0.150.1"
    
    # Build with Hugo
    hugo --minify -b "${DEPLOY_PRIME_URL:-/}"
    
    # Set correct publish directory for Netlify
    echo "Hugo build complete. Output in beta/public/"
    
    # Move the built files to the root public directory for Netlify
    cd ..
    rm -rf public
    cp -r beta/public public
    
else
    echo "Detected Gatsby branch - building with npm"
    npm run build
fi

echo "Build script completed"