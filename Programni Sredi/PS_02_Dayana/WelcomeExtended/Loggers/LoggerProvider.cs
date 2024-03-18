using Microsoft.Extensions.Logging;

namespace WelcomeExtended.Loggers
{
    public class LoggerProvider : ILoggerProvider
    {
        public LoggerProvider()
        {
        }

        public ILogger CreateLogger(string categoryName)
        {
            return new HashLogger(categoryName);
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }
    }
}

