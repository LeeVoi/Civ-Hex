using System.Reflection;
using api;
using backend.WebSocket.Services;
using backend.WebSocket.State;
using Fleck;
using lib;


namespace api
{
    public static class ApiStartUp
    {
        public static void Main(string[] args)
        {
            var webApp = StartApi(args);
            webApp.Result.Run();
        }
        public static async Task<WebApplication> StartApi(string[] args)
        { 
            var builder = WebApplication.CreateBuilder();
            builder.Services.AddSingleton<ClientConnections>();
            builder.Services.AddControllers();
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();
            var services =  builder.FindAndInjectClientEventHandlers(Assembly.GetExecutingAssembly());

            var app = builder.Build();
            
            var server = new WebSocketServer("ws://0.0.0.0:8181");
            
            server.Start(socket =>
            {
                socket.OnOpen = () =>
                {
                    WsState.AddConnection(socket);
                    socket.Send("Welcome to the server, a friendly gaming space.");
                };
                socket.OnClose = () =>
                {
                    app.Services.GetService<ClientConnections>().RemoveConnectionFromPool(socket);
                };
                socket.OnMessage = async message =>
                {
                    try
                    {
                        await app.InvokeClientEventHandler(services, socket, message);
                    }
                    catch (Exception e)
                    {
                        Console.WriteLine(e);
                        Console.WriteLine(e.InnerException);
                        Console.WriteLine(e.Message);
                    }
                };
            });
            return app;
        }
    }
    
}