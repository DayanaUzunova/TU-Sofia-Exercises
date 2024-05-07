using System.Linq.Expressions;
using Welcome.Model;
using Welcome.Others;
using Welcome.ViewModel;
using WelcomeExtended.Data;
using WelcomeExtended.Helpers;
using WelcomeExtended.Others;

namespace WelcomeExtended
{
    internal class Program
    {   
        
        static void Main(string[] args)
        {
            try
            {
                UserData userData = new UserData();
                User studentUser = new User("Student", "123", UserRolesEnum.STUDENT);
                userData.addUser(studentUser);
                User studentUser1 = new User("Student2", "1234", UserRolesEnum.STUDENT);
                userData.addUser(studentUser1);
                User studentUser2 = new User("Teacher", "123", UserRolesEnum.PROFESSOR);
                userData.addUser(studentUser2);
                User studentUser3 = new User("Admin", "123", UserRolesEnum.ADMIN);
                userData.addUser(studentUser3);
                Console.WriteLine("Please enter username:");
                string username = Console.ReadLine();
                Console.WriteLine("Please enter password:");
                string password = Console.ReadLine();
                if ( UserHelper.ValidateCredentials(username, password))
                {
                    User user = UserHelper.GetUser(username, password);
                    Console.WriteLine(UserHelper.ToString(user));
                }

            }
            catch (Exception e)
            {
                var log = new ActionOnError(Delegates.Log);
                log(e.Message);
            }
            finally
            {
                Console.WriteLine("Executed in any case!");
            }
            }
        }
    }

