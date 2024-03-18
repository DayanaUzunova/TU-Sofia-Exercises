using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Welcome.Others;

namespace Welcome.Model
{
    public class User
    {
        public string Name { get; set; }
        public string Password { get; set; }
        public UserRolesEnum Role { get; set; }


        private string _names;
        public string GetNames()
        {
            return _names;
        }
        public void SetNames(string value)
        {
            _names = value;
        }
    }
}
