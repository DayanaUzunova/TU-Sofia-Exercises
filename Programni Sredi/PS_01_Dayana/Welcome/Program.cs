using Welcome.Model;
using Welcome.Others;
using Welcome.View;
using Welcome.ViewModel;

namespace Welcome
{
    internal class Program
    {
        static void Main(string[] args)
        {
            User user = new User
            {
                Name = "Dayana",
                Role = UserRolesEnum.ADMIN
            };

            UserViewModel userViewModel = new UserViewModel(user);
            UserView userView = new UserView(userViewModel);

            userView.Display();
            Console.ReadKey();
        }
    }
}