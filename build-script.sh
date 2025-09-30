#!/bin/bash

echo "Building for branch: $HEAD"
echo "Current directory: $(pwd)"
echo "Available files: $(ls -la)"

# Check if we're on a Hugo branch and beta folder exists
if [[ "$HEAD" == *"hugo"* ]] && [[ -d "beta" ]]; then
    echo "Detected Hugo branch with beta folder - building with Hugo"
    
    # Install Hugo if not present
    if ! command -v hugo &> /dev/null; then
        echo "Installing Hugo ${HUGO_VERSION:-0.150.1}"
        HUGO_VERSION="${HUGO_VERSION:-0.150.1}"
        
        # Download and install Hugo
        cd /tmp
        wget -O hugo.tar.gz "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"
        tar -xzf hugo.tar.gz
        sudo mv hugo /usr/local/bin/
        cd $OLDPWD
        
        echo "Hugo installed: $(hugo version)"
    else
        echo "Hugo already available: $(hugo version)"
    fi
    
    cd beta
    
    # Build with Hugo
    hugo --minify -b "${DEPLOY_PRIME_URL:-/}"
    
    # Check if build was successful
    if [[ -d "public" ]]; then
        echo "Hugo build complete. Output in beta/public/"
        
        # Move the built files to the root public directory for Netlify
        cd ..
        rm -rf public
        cp -r beta/public public
        echo "Files copied to root public directory"
    else
        echo "ERROR: Hugo build failed - no public directory created"
        exit 1
    fi
    
else
    echo "Detected Gatsby branch - building with npm"
    npm run build
fi

echo "Build script completed"