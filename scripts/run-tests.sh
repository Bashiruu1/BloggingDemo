#!/bin/bash
set -e

# Run unit tests
echo "Running unit tests..."
dotnet test tests/unit/BloggingDemo.Tests/BloggingDemo.Tests.csproj \
  --logger:trx \
  --results-directory:/testresults/unit \
  /p:CollectCoverage=true \
  /p:CoverletOutputFormat=opencover \
  /p:ThresholdType=Line \
  /p:Threshold=80

# Run integration tests
echo "Running integration tests..."
dotnet test tests/integration/BloggingDemo.Tests/BloggingDemo.Tests.csproj \
  --logger:trx \
  --results-directory:/testresults/integration
