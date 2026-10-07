# 1. Use the official Microsoft .NET SDK image to build the app
FROM ://microsoft.com AS build
WORKDIR /src

# 2. Copy project files and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# 3. Copy the rest of the application files and publish it
COPY . ./
RUN dotnet publish -c Release -o /app/out

# 4. Use the lightweight runtime image to run the app
FROM ://microsoft.com
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "mywebapp.dll"]