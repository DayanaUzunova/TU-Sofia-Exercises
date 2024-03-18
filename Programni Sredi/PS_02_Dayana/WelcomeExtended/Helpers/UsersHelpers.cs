using System.Text;
using Welcome.Model;

public static class UserHelper
{
    public static string ToString(this User user)
    {
        StringBuilder stringBulder = new StringBuilder();
        stringBulder.AppendLine($"Id: {user.Id}");
        stringBulder.AppendLine($"Name: {user.Name}");
        stringBulder.AppendLine($"Role: {user.Role}");
        stringBulder.AppendLine($"Expires: {user.Expires}");
        return stringBulder.ToString();
    }

    public static bool ValidateCredentials(this UserData userData, string name, string password)
    {
        if (IsFieldEmpty(name))
        {
            Console.WriteLine("The name cannot be empty.");
            return false;
        }
        if (IsFieldEmpty(password))
        {
            Console.WriteLine("The password cannot be empty.");
            return false;
        }

        return userData.ValidateUser(name, password);
    }

    private static bool IsFieldEmpty(string field)
    {
        return field == null || field == "";
    }

    public static User GetUser(this UserData userData, string name, string password)
    {
        return userData.GetUser(name, password);
    }
}
