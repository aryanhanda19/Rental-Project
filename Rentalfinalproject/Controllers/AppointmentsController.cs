using System;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using Rentalfinalproject.Models;

namespace Rentalfinalproject.Controllers
{
    public class AppointmentsController : Controller
    {
        private RentalDBEntities db = new RentalDBEntities();

        // GET: Appointments
        public ActionResult Index()
        {
            var appointments = db.Appointments
                .Include(a => a.Apartment)
                .Include(a => a.User) // Tenant
                .Include(a => a.User1); // Property Manager
            return View(appointments.ToList());
        }

        // GET: Appointments/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Appointment appointment = db.Appointments.Find(id);
            if (appointment == null)
            {
                return HttpNotFound();
            }
            return View(appointment);
        }

        // GET: Appointments/Create
        public ActionResult Create()
        {
            // Load only tenants for appointment creation
            ViewBag.ApartmentID = new SelectList(db.Apartments, "ApartmentID", "UnitNumber");
            ViewBag.PropertyManagerID = new SelectList(db.Users.Where(u => u.Role == "PropertyManager"), "UserID", "Username"); // Assuming you have a PropertyManager role
            ViewBag.TenantID = new SelectList(db.Users.Where(u => u.Role == "Tenant"), "UserID", "Username");
            return View();
        }

        // POST: Appointments/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "AppointmentID,TenantID,PropertyManagerID,ApartmentID,AppointmentDate,Status,CreatedAt")] Appointment appointment)
        {
            if (ModelState.IsValid)
            {
                appointment.Status = "Pending"; // Set default status
                appointment.CreatedAt = DateTime.Now; // Set created date
                db.Appointments.Add(appointment);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.ApartmentID = new SelectList(db.Apartments, "ApartmentID", "UnitNumber", appointment.ApartmentID);
            ViewBag.PropertyManagerID = new SelectList(db.Users.Where(u => u.Role == "PropertyManager"), "UserID", "Username", appointment.PropertyManagerID);
            ViewBag.TenantID = new SelectList(db.Users.Where(u => u.Role == "Tenant"), "UserID", "Username", appointment.TenantID);
            return View(appointment);
        }

        // GET: Appointments/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Appointment appointment = db.Appointments.Find(id);
            if (appointment == null)
            {
                return HttpNotFound();
            }
            ViewBag.ApartmentID = new SelectList(db.Apartments, "ApartmentID", "UnitNumber", appointment.ApartmentID);
            ViewBag.PropertyManagerID = new SelectList(db.Users.Where(u => u.Role == "PropertyManager"), "UserID", "Username", appointment.PropertyManagerID);
            ViewBag.TenantID = new SelectList(db.Users.Where(u => u.Role == "Tenant"), "UserID", "Username", appointment.TenantID);
            return View(appointment);
        }

        // POST: Appointments/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "AppointmentID,TenantID,PropertyManagerID,ApartmentID,AppointmentDate,Status,CreatedAt")] Appointment appointment)
        {
            if (ModelState.IsValid)
            {
                db.Entry(appointment).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.ApartmentID = new SelectList(db.Apartments, "ApartmentID", "UnitNumber", appointment.ApartmentID);
            ViewBag.PropertyManagerID = new SelectList(db.Users.Where(u => u.Role == "PropertyManager"), "UserID", "Username", appointment.PropertyManagerID);
            ViewBag.TenantID = new SelectList(db.Users.Where(u => u.Role == "Tenant"), "UserID", "Username", appointment.TenantID);
            return View(appointment);
        }

        // GET: Appointments/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Appointment appointment = db.Appointments.Find(id);
            if (appointment == null)
            {
                return HttpNotFound();
            }
            return View(appointment);
        }

        // POST: Appointments/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Appointment appointment = db.Appointments.Find(id);
            db.Appointments.Remove(appointment);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
