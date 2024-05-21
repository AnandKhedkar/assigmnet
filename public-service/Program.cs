using System.Text.Json.Serialization;
using HttpClient = System.Net.Http.HttpClient;

var builder = WebApplication.CreateSlimBuilder(args);

builder.Services.ConfigureHttpJsonOptions(options =>
{
    options.SerializerOptions.TypeInfoResolverChain.Insert(0, AppJsonSerializerContext.Default);
});

var app = builder.Build();

var sampleTodos = new Todo[] {
    new(1, "Walk the dog"),
    new(2, "Do the dishes", DateOnly.FromDateTime(DateTime.Now)),
    new(3, "Do the laundry", DateOnly.FromDateTime(DateTime.Now.AddDays(1))),
    new(4, "Clean the bathroom"),
    new(5, "Clean the car", DateOnly.FromDateTime(DateTime.Now.AddDays(2))),
    new(6, "Clean the bathroom"),
    new(7, "Clean the bathroom"),
    new(8, "Clean the bathroom"),
    new(9, "Clean the bathroom"),
    new(10, "Clean the bathroom"),
    new(11, "Clean the bathroom"),





};

var home = app.MapGroup("/");
home.MapGet("/", async () => { 
    var client = new HttpClient();
    client.BaseAddress = new Uri("http://private-api-clusterip.assignment.svc.cluster.local:8000");
    var privateResponse = await client.GetAsync("");
    return "Public service running \nCalling private service...-\n"+await privateResponse.Content.ReadAsStringAsync();
    
    });
var todosApi = app.MapGroup("/todos");
todosApi.MapGet("/", () => sampleTodos);
todosApi.MapGet("/{id}", (int id) =>
    sampleTodos.FirstOrDefault(a => a.Id == id) is { } todo
        ? Results.Ok(todo)
        : Results.NotFound());

app.Run();

public record Todo(int Id, string? Title, DateOnly? DueBy = null, bool IsComplete = false);

[JsonSerializable(typeof(Todo[]))]
internal partial class AppJsonSerializerContext : JsonSerializerContext
{

}
