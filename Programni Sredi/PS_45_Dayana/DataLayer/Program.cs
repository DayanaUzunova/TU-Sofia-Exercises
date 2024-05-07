using DataLayer.Database;
using DataLayer.Model;

namespace DataLayer
{
    internal class Program
    {
        static void Main(string[] args)
        {
            using (var context = new DatabaseContext())
            {
                context.Database.EnsureCreated();
                context.Add<DatabaseUser>(new DatabaseUser("user", "password", Welcome.Others.UserRolesEnum.ADMIN, DateTime.Now));
                context.SaveChanges();
                var users = context.Users.ToList();
                Console.ReadKey();

            }
        }
    }
}
