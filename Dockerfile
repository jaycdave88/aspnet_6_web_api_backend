FROM mcr.microsoft.com/dotnet/sdk:6.0-focal AS base
WORKDIR /app
EXPOSE 80
#Used to map the p
ENV ASPNETCORE_URLS="http://*:80"
#Used to render Swagger UI 
#Not needed now that in the program.cs I removed the if block to always use swagger
#ENV ASPNETCORE_ENVIRONMENT="Development" 

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