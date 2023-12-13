using System;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using DotNetCoreSqlDb.Data;
using DotNetCoreSqlDb.Models;

namespace test
{
    public class TestTimerTrigger
    {
        private readonly ILogger _logger;
        private readonly MyDatabaseContext _context;

        public TestTimerTrigger(ILoggerFactory loggerFactory, MyDatabaseContext context)
        {
            _logger = loggerFactory.CreateLogger<TestTimerTrigger>();
            _context = context;
        }

        [Function("TestTimerTrigger")]
        public async Task Run([TimerTrigger("0 */5 * * * *")] TimerInfo myTimer)
        {
            _logger.LogInformation($"C# Timer trigger function executed at: {DateTime.Now}");
            
            if (myTimer.ScheduleStatus is not null)
            {
                _logger.LogInformation($"Next timer schedule at: {myTimer.ScheduleStatus.Next}");
            }

            _context.Add(new Todo() { Description = "functionapp funker", CreatedDate = DateTime.UtcNow });
            await _context.SaveChangesAsync();
        }
    }
}
