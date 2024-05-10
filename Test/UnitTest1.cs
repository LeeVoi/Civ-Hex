using api;
using backend.WebSocket.Dto;
using lib;

namespace Test;

[TestFixture]
[NonParallelizable]
public class Tests
{
    [SetUp]
    public async Task Setup()
    {
        await ApiStartUp.StartApi(null);
    }

    [Test]
    public async Task ClientCanEnterQueueTestMethods()
    {
        var ws1 = await new WebSocketTestClient().ConnectAsync();
        var ws2 = await new WebSocketTestClient().ConnectAsync();
        
        await ws1.DoAndAssert(new ClientWantsToEnterQueueDto() {},
            response =>
            {
                return response.Count(e => e.eventType == nameof(ServerBroadcastGameStateDto)) == 0;
            });
        await ws2.DoAndAssert(new ClientWantsToEnterQueueDto() {},
            response =>
            {
                return response.Count(e => e.eventType == nameof(ServerBroadcastGameStateDto)) == 1;
            });
        
        ws1.Client.Dispose();
        ws2.Client.Dispose();
    }
}