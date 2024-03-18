using System.Text;
using Microsoft.Extensions.Logging;

public class FileLogger : ILogger
{

    private static string filePath = "log.txt";
    public IDisposable? BeginScope<TState>(TState state) where TState : notnull
    {
        return null;
    }

    public bool IsEnabled(LogLevel logLevel)
    {
        return true;
    }

    public void Log<TState>(LogLevel logLevel, EventId eventId, TState state,
        Exception? exception, Func<TState, Exception?,
        string> formatter)
    {
        var message = formatter(state, exception);


        WriteLogToFile(message);
    }

    private void WriteLogToFile(string text)
    {
        using (StreamWriter writer = new StreamWriter(filePath, true))
        {
            writer.WriteLine(text);
        }
    }
}
