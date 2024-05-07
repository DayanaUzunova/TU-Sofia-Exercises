using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Welcome.Model;
using Welcome.Others;

namespace DataLayer.Model
{
    public class DatabaseUser : User
    {
        public DatabaseUser() : base("", "", UserRolesEnum.ADMIN)
        {
        }
        public DatabaseUser(string names, string password, UserRolesEnum role, DateTime expires) : base(names, password, role, expires)
        {
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id;
    }
}
