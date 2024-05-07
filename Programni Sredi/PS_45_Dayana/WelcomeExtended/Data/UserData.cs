using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Welcome.Model;
using Welcome.Others;

namespace WelcomeExtended.Data
{
    public class UserData
    {
        private static List<User> _users = new List<User>();
        private int _nextId;

        public UserData() {
            this._nextId = 0;
            _users = new List<User>();
        }

        public void addUser(User user)
        {
            user.Id = this._nextId++;
            _users.Add(user);
        }
        public void deleteUser(User user)
        {
            _users.Remove(user);
        }
        public static bool ValidateUser(string name, string password)
        {
            foreach (var user in _users)
            {
                if (user.Names == name && user.Password == password) return true;
            }
            return false;
        }
        public bool ValidateUserLambda(string name, string password)
        {
            return _users.Where(x=> x.Names == name && x.Password == password).FirstOrDefault() != null ? true : false;
        }
        public bool ValidateUserLinq(string name, string password)
        {
            var ret = from user in _users
                      where user.Names == name && user.Password == password
                      select user.Id;
            return ret != null ? true : false;
        }
        public static User GetUser(string name, string password)
        {
            User? returnUser = _users?.FirstOrDefault(x => x.Names == name && x.Password == password);
            return returnUser;
        }
        public void SetActive(string name, DateTime validDate)
        {
            User user = _users.FirstOrDefault(x => x.Names == name);
            if (user != null)
            {
                user.Expires = validDate;
            }
        }
        public void AssignUserRole(string name, UserRolesEnum userRolesEnum)
        {
            User user = _users.FirstOrDefault(x => x.Names == name);
            if (user != null)
            {
                user.Role = userRolesEnum;
            }
        }

    }
}
