# Build stage
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Copy solution and project files
COPY *.sln .
COPY src/BloggingDemo/*.csproj ./src/BloggingDemo/
COPY tests/unit/BloggingDemo.Tests/*.csproj ./tests/unit/BloggingDemo.Tests/
COPY tests/integration/BloggingDemo.Tests/*.csproj ./tests/integration/BloggingDemo.Tests/

# Restore packages
RUN dotnet restore

# Copy all project files
COPY . .
WORKDIR /app/
RUN dotnet build -c Release

# Test stage
FROM build AS testrunner
WORKDIR /app/tests/unit/BloggingDemo.Tests
# Run unit tests
RUN dotnet test --collect "XPlat Code Coverage" --results-directory:/testresults/unit /p:CoverletOutputFormat=opencover /p:Threshold=80 /p:ThresholdType=line+method

# FROM build as integration-runner
# # Run integration tests
# RUN dotnet test --collect "XPlat Code Coverage" --results-directory:/testresults/integration /p:CoverletOutputFormat=opencover /p:Threshold=80 /p:ThresholdType=line+method tests/integration/BloggingDemo.Tests/BloggingDemo.Tests.csproj

# Final stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final
WORKDIR /app

# Copy published output
COPY --from=build /app/src/BloggingDemo/bin/Release/net6.0/ ./

# Set the entry point to the web API project
ENTRYPOINT ["dotnet", "BloggingDemo.dll"]
