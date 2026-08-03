WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.Services.AddHealthChecks();

WebApplication app = builder.Build();

// Needed to map index.html as the default landing page
app.UseDefaultFiles();
app.UseStaticFiles();
app.MapFallbackToFile("index.html");

// Kubernetes Liveness Probe endpoint
app.MapGet("/health", () => Results.Ok(new
{
    Status = "Healthy"
}));

// Kubernetes Readiness Probe endpoint
app.MapGet("/ready", () => Results.Ok(new
{
    Status = "Ready"
}));

app.MapGet("/api/info", () => Results.Ok(new
{
    Status = "Healthy",
    Service = "Azure AKS Demo API",
    Environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? "Production",
    HostName = Environment.MachineName,
    Timestamp = DateTime.UtcNow
}));

app.Run();