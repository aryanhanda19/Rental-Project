using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Rentalfinalproject.Models;

namespace Rentalfinalproject.Controllers
{
    public class RentalAgreementsController : Controller
    {
        private RentalDBEntities db = new RentalDBEntities();

        // GET: RentalAgreements
        public ActionResult Index()
        {
            var rentalAgreements = db.RentalAgreements.Include(r => r.Apartment).Include(r => r.User);
            return View(rentalAgreements.ToList());
        }

        // GET: RentalAgreements/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            RentalAgreement rentalAgreement = db.RentalAgreements.Find(id);
            if (rentalAgreement == null)
            {
                return HttpNotFound();
            }
            return View(rentalAgreement);
        }

        // GET: RentalAgreements/Create
        public ActionResult Create()
        {
            ViewBag.ApartmentID = new SelectList(db.Apartments, "ApartmentID", "UnitNumber");
            ViewBag.TenantID = new SelectList(db.Users, "UserID", "Username");
            return View();
        }

        // POST: RentalAgreements/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "AgreementID,TenantID,ApartmentID,StartDate,EndDate,PaymentStatus,MonthlyRent,DueDate")] RentalAgreement rentalAgreement)
        {
            if (ModelState.IsValid)
            {
                db.RentalAgreements.Add(rentalAgreement);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.ApartmentID = new SelectList(db.Apartments, "ApartmentID", "UnitNumber", rentalAgreement.ApartmentID);
            ViewBag.TenantID = new SelectList(db.Users, "UserID", "Username", rentalAgreement.TenantID);
            return View(rentalAgreement);
        }

        // GET: RentalAgreements/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            RentalAgreement rentalAgreement = db.RentalAgreements.Find(id);
            if (rentalAgreement == null)
            {
                return HttpNotFound();
            }
            ViewBag.ApartmentID = new SelectList(db.Apartments, "ApartmentID", "UnitNumber", rentalAgreement.ApartmentID);
            ViewBag.TenantID = new SelectList(db.Users, "UserID", "Username", rentalAgreement.TenantID);
            return View(rentalAgreement);
        }

        // POST: RentalAgreements/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "AgreementID,TenantID,ApartmentID,StartDate,EndDate,PaymentStatus,MonthlyRent,DueDate")] RentalAgreement rentalAgreement)
        {
            if (ModelState.IsValid)
            {
                db.Entry(rentalAgreement).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.ApartmentID = new SelectList(db.Apartments, "ApartmentID", "UnitNumber", rentalAgreement.ApartmentID);
            ViewBag.TenantID = new SelectList(db.Users, "UserID", "Username", rentalAgreement.TenantID);
            return View(rentalAgreement);
        }

        // GET: RentalAgreements/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            RentalAgreement rentalAgreement = db.RentalAgreements.Find(id);
            if (rentalAgreement == null)
            {
                return HttpNotFound();
            }
            return View(rentalAgreement);
        }

        // POST: RentalAgreements/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            RentalAgreement rentalAgreement = db.RentalAgreements.Find(id);
            db.RentalAgreements.Remove(rentalAgreement);
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
