using Welcome.Others;

namespace Welcome.Model
{
    public class User
    {
        public string Names { get; set; }
        public string Password { get; set; }
        public UserRolesEnum Role { get; set; }
        public int Id { get; set; }
        public DateTime Expires { get; set; }

        public User(string names, string password, UserRolesEnum role)
        {
            Names = names;
            Password = password;
            Role = role;
        }

        public User(string names, string password, UserRolesEnum role, DateTime expires) : this(names, password, role)
        {
            Expires = expires;
        }

        public override string ToString()
        {
            return Names;
        }

        public int GetId()
        {
            return Id;
        }

        public void SetId(int id)
        {
            Id = id;
        }
    }
}
