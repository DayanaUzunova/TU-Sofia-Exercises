using DataLayer.Model;
using Microsoft.EntityFrameworkCore;
using System;
using System.IO; // Import System.IO namespace for Path.Combine
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Database
{
    public class DatabaseContext : DbContext
    {
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            string solutionFolder = Environment.GetFolderPath(Environment.SpecialFolder.Desktop);
            string databaseFile = "Welcome.db";
            string databasePath = Path.Combine(solutionFolder, databaseFile);
            optionsBuilder.UseSqlite(databasePath);
            // base.OnConfiguring(optionsBuilder);
        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<DatabaseUser>().Property(e => e.Id).ValueGeneratedOnAdd();

            modelBuilder.Entity<DatabaseUser>().HasData(
                new DatabaseUser { Id = -1, Names = "Georgi", Password = "123", Role = Welcome.Others.UserRolesEnum.ANONYMOUS, Expires = DateTime.Now.AddYears(10) },
                new DatabaseUser { Id = -2, Names = "Georgi1", Password = "123", Role = Welcome.Others.UserRolesEnum.ANONYMOUS, Expires = DateTime.Now.AddYears(5) },
                new DatabaseUser { Id = -3, Names = "Georgi2", Password = "123", Role = Welcome.Others.UserRolesEnum.ANONYMOUS, Expires = DateTime.Now.AddYears(7) }
            );

            // base.OnModelCreating(modelBuilder);
        }
        public DbSet<DatabaseUser> Users { get; set; }
    }
}
