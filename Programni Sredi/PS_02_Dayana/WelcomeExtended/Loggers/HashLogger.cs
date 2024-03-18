using System.Collections.Concurrent;
using System.Text;
using Microsoft.Extensions.Logging;

namespace WelcomeExtended.Loggers
{
    public class HashLogger : ILogger
    {
        private readonly ConcurrentDictionary<int, string> _logMessages;
        private readonly string _name;

        public HashLogger(string name)
        {
            _logMessages = new ConcurrentDictionary<int, string>();
            _name = name;
        }

        public void Log<TState>(LogLevel logLevel, EventId eventId, TState state,
            Exception? exception, Func<TState, Exception?, string> formatter)
        {
            var message = formatter(state, exception);
            switch (logLevel)
            {
                case LogLevel.Critical:
                    Console.ForegroundColor = ConsoleColor.Red;
                    break;
                case LogLevel.Error:
                    Console.ForegroundColor = ConsoleColor.DarkRed;
                    break;
                case LogLevel.Warning:
                    Console.ForegroundColor = ConsoleColor.Yellow;
                    break;
                default:
                    Console.ForegroundColor = ConsoleColor.White;
                    break;
            }

            Console.WriteLine(" == Logger == ");
            var messageToBeLogged = new StringBuilder();
            messageToBeLogged.Append($"[{logLevel}]");
            messageToBeLogged.AppendFormat(" [{0}]", _name);
            Console.WriteLine(messageToBeLogged);
            Console.WriteLine($"{formatter(state, exception)}");
            Console.WriteLine(" == Logger == ");
            Console.ResetColor();
            _logMessages[eventId.Id] = message;
        }

        public bool IsEnabled(LogLevel logLevel)
        {
            return true;
        }

        public IDisposable? BeginScope<TState>(TState state) where TState : notnull
        {
            return null;
        }

        public void PrintAllMessages()
        {
            foreach (var pair in _logMessages)
            {
                PrintEventIdAndMessage(pair.Key, pair.Value);
            }
        }

        public void PrintMessageWithEventId(int eventId)
        {
            if (_logMessages.ContainsKey(eventId))
            {
                var message = _logMessages.GetValueOrDefault(eventId, "");
                PrintEventIdAndMessage(eventId, message);
            }
        }

        private void PrintEventIdAndMessage(int eventId, string message)
        {
            Console.WriteLine($"eventId: {eventId}, Message: {message}");
        }

        public void DeleteMessageWithEventId(int eventId)
        {
            _logMessages.Remove(eventId, out _);
        }
    }
}
