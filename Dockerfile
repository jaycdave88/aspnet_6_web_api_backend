FROM mcr.microsoft.com/dotnet/sdk:6.0-focal AS base
WORKDIR /app
EXPOSE 80
ENV ASPNETCORE_URLS="http://*:80"
ENV ASPNETCORE_ENVIRONMENT="Development"

FROM mcr.microsoft.com/dotnet/sdk:6.0-focal AS build
WORKDIR /src
COPY ["src.csproj", "./"]
RUN dotnet restore "src.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "src.csproj" -c Release -o /app/build 

FROM build as publish
RUN dotnet publish "src.csproj" -c Release -o /app/publish

FROM base as final 
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "src.dll"]