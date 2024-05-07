using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Welcome.Model;
using WelcomeExtended.Data;

namespace WelcomeExtended.Helpers
{
    public static class UserHelper
    {
        public static string ToString(this User user)
        {
           return user.ToString();
        }
        public static bool ValidateCredentials(string username, string password)
        {
            if ( username == null
                || password == null)
            {
                throw new Exception("Error: Both of the fields should be != null");

            }
            return UserData.ValidateUser(username, password);

        }
        public static User GetUser(string username, string password) { 
            return UserData.GetUser(username, password);
        }
    }
}
