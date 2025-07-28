# Stage 1 - Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy toàn bộ .csproj vào đúng thư mục
COPY MenShop_Assignment/MenShop_Assignment.csproj ./MenShop_Assignment/
WORKDIR /src/MenShop_Assignment
RUN dotnet restore

# Copy toàn bộ source code vào container
COPY . .
RUN dotnet publish -c Release -o /app/publish

# Stage 2 - Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "MenShop_Assignment.dll"]
