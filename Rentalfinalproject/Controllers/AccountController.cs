using System;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using System.Web.Security; // For FormsAuthentication
using Rentalfinalproject.Models;

namespace Rentalfinalproject.Controllers
{
    public class AccountController : Controller
    {
        private RentalDBEntities db = new RentalDBEntities();

        // GET: Account/Register
        public ActionResult Register()
        {
            return View();
        }

        // POST: Account/Register
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(User user)
        {
            if (ModelState.IsValid)
            {
                // Check if the username already exists
                if (db.Users.Any(u => u.Username == user.Username))
                {
                    ModelState.AddModelError("Username", "Username already exists.");
                    return View(user);
                }

                // Set additional properties if necessary
                user.CreatedAt = DateTime.Now;
                user.Role = "Tenant"; // Set default role to Tenant or modify as needed
                db.Users.Add(user);
                db.SaveChanges();
                return RedirectToAction("Login");
            }
            return View(user);
        }

        // GET: Account/Login
        public ActionResult Login()
        {
            return View();
        }

        // POST: Account/Login
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = db.Users.FirstOrDefault(u => u.Username == model.Username && u.PasswordHash == model.Password);
                if (user != null)
                {
                    FormsAuthentication.SetAuthCookie(model.Username, model.RememberMe);
                    return RedirectToAction("Index", "Home"); // Redirect to home page or user-specific page
                }
                ModelState.AddModelError("", "Invalid username or password.");
            }
            return View(model);
        }

        // GET: Account/Logout
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Login");
        }
    }
}
