```shell
dotnet new webapi -n BloggingDemo -o src/BloggingDemo
dotnet new xunit -n BloggingDemo.Tests -o tests/unit/BloggingDemo.Tests
dotnet new xunit -n BloggingDemo.Tests -o tests/integration/BloggingDemo.Tests
dotnet new sln -n BloggingDemo
dotnet sln BloggingDemo.sln add src/BloggingDemo/BloggingDemo.csproj
dotnet sln BloggingDemo.sln add tests/unit/BloggingDemo.Tests/BloggingDemo.Tests.csproj
dotnet sln BloggingDemo.sln add tests/integration/BloggingDemo.Tests/BloggingDemo.Tests.csproj
```
