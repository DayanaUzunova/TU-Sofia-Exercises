using Welcome.Model;
using Welcome.Others;



UserData userData = new UserData();

var user = new User
{
    Name = "Student",
    Password = "123",
    Role = UserRolesEnum.STUDENT
};
userData.AddUser(user);

var user2 = new User
{
    Name = "Student2",
    Password = "123",
    Role = UserRolesEnum.STUDENT
};
userData.AddUser(user2);

var user3 = new User
{
    Name = "Teacher",
    Password = "1234",
    Role = UserRolesEnum.PROFESSOR
};
userData.AddUser(user3);

var user4 = new User
{
    Name = "Admin",
    Password = "12345",
    Role = UserRolesEnum.ADMIN
};
userData.AddUser(user4);

Console.WriteLine("enter name");
var name = Console.ReadLine();

Console.WriteLine("enter password");
var password = Console.ReadLine();

if (userData.ValidateCredentials(name, password))
{
    var foundUser = userData.GetUser(name, password);
    Console.WriteLine(UserHelper.ToString(foundUser));
}
else
{
    Console.WriteLine("User Not Found.");
}

