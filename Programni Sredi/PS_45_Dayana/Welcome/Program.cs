using Welcome.Model;
using Welcome.Others;
using Welcome.ViewModel;

namespace Welcome
{
    internal class Program
    {
        static void Main(string[] args)
        {
            User user = new User("Dayana", "123", UserRolesEnum.PROFESSOR);
            User user1 = new User("Emily", "123", UserRolesEnum.PROFESSOR);
            User user2 = new User("Viki", "123", UserRolesEnum.PROFESSOR);
            UserViewModel userViewM = new UserViewModel(user);
            UserView userView = new UserView(userViewM);
            userView.Display();

        }
    }
}
