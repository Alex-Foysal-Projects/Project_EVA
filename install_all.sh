#!/bin/bash
set -e

echo "Installing Node.js dependencies..."

echo "Installing in scripts/agentic-mcp..."
cd scripts/agentic-mcp && npm install && cd ../..

echo "Installing in scripts/agents/mcp-hello..."
cd scripts/agents/mcp-hello && npm install && cd ../../../

echo "Installing in scripts/sparc2..."
cd scripts/sparc2 && npm install && cd ../..

echo "Installing Deno dependencies..."

if ! command -v deno &> /dev/null; then
    echo "Deno not found, installing Deno..."
    curl -fsSL https://deno.land/install.sh | sh
    export DENO="$HOME/.deno/bin/deno"
else
    export DENO=$(command -v deno)
fi

echo "Running Deno cache in scripts/sparc2..."
cd scripts/sparc2 && $DENO cache deno.json && cd ../..

echo "Running Deno cache in scripts/agents/openai-agent..."
cd scripts/agents/openai-agent && $DENO cache deno.json && cd ../../../

echo "Running Deno cache in scripts/vectorstore..."
cd scripts/vectorstore && $DENO cache deno.json && cd ../..

echo "Installing Python dependencies in scripts/agents/devops..."
cd scripts/agents/devops && (pip install -r requirements.txt || true) && cd ../../../

echo "All installations complete."