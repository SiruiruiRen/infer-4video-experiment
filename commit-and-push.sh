#!/bin/bash

# Commit and push script for INFER 4-Video Experiment
# Usage: ./commit-and-push.sh "Your commit message"

set -e

echo "================================================"
echo "INFER 4-Video Experiment - Commit & Push Script"
echo "================================================"
echo ""

# Check if we're in the correct directory
if [ ! -f "app.js" ] || [ ! -f "index.html" ]; then
    echo "❌ Error: Please run this script from the project root directory"
    exit 1
fi

# Check current branch
CURRENT_BRANCH=$(git branch --show-current)
echo "Current branch: $CURRENT_BRANCH"
echo ""

# Check git status
echo "📝 Git Status:"
git status --short
echo ""

# Check for uncommitted changes
if [ -z "$(git status --porcelain)" ]; then
    echo "✅ No uncommitted changes"
else
    echo "📦 Staging changes..."
    git add app.js index.html styles.css COMMIT_RULES.md DEPLOYMENT_GUIDE.md commit-and-push.sh 2>/dev/null || true
    
    # Show what will be committed
    echo ""
    echo "Files to be committed:"
    git diff --cached --name-only
    echo ""
    
    # Commit with message
    if [ -z "$1" ]; then
        echo "⚠️  No commit message provided. Using default message."
        COMMIT_MSG="Update INFER 4-video experiment"
    else
        COMMIT_MSG="$1"
    fi
    
    echo "💾 Committing with message: '$COMMIT_MSG'"
    git commit -m "$COMMIT_MSG"
    echo ""
fi

# Show current remotes
echo "🔗 Git Remotes:"
git remote -v | grep infer-4video
echo ""

# Push to infer-4video repository
echo "🚀 Pushing to infer-4video-experiment repository..."
git push infer-4video clean-update:main

echo ""
echo "✅ Successfully pushed to infer-4video-experiment!"
echo "🌐 Render will auto-deploy in 2-3 minutes"
echo "   Check: https://dashboard.render.com/"
echo ""
echo "================================================"

