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
    public class MessagesController : Controller
    {
        private RentalDBEntities db = new RentalDBEntities();

        // GET: Messages
        public ActionResult Index()
        {
            var messages = db.Messages.Include(m => m.User).Include(m => m.User1).ToList();
            return View(messages);
        }

        // GET: Messages/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Message message = db.Messages.Find(id);
            if (message == null)
            {
                return HttpNotFound();
            }
            return View(message);
        }

        // GET: Messages/Create
        public ActionResult Create()
        {
            ViewBag.ReceiverID = new SelectList(db.Users, "UserID", "Username");
            // Set the SenderID to the current user
            //var currentUserId = User.Identity.GetUserId(); // Assuming you're using Identity
            //ViewBag.SenderID = currentUserId; // This might be a direct assignment or need modification based on your user management
            return View();
        }

        // POST: Messages/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "MessageID,ReceiverID,MessageContent")] Message message)
        {
            if (ModelState.IsValid)
            {
                // message.SenderID = User.Identity.GetUserId(); // Assuming you're using Identity
                message.SentAt = DateTime.Now; // Set the SentAt timestamp
                db.Messages.Add(message);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.ReceiverID = new SelectList(db.Users, "UserID", "Username", message.ReceiverID);
            return View(message);
        }

        // GET: Messages/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Message message = db.Messages.Find(id);
            if (message == null)
            {
                return HttpNotFound();
            }
            ViewBag.ReceiverID = new SelectList(db.Users, "UserID", "Username", message.ReceiverID);
            ViewBag.SenderID = new SelectList(db.Users, "UserID", "Username", message.SenderID);
            return View(message);
        }

        // POST: Messages/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "MessageID,SenderID,ReceiverID,MessageContent,SentAt")] Message message)
        {
            if (ModelState.IsValid)
            {
                db.Entry(message).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.ReceiverID = new SelectList(db.Users, "UserID", "Username", message.ReceiverID);
            ViewBag.SenderID = new SelectList(db.Users, "UserID", "Username", message.SenderID);
            return View(message);
        }

        // GET: Messages/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Message message = db.Messages.Find(id);
            if (message == null)
            {
                return HttpNotFound();
            }
            return View(message);
        }

        // POST: Messages/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Message message = db.Messages.Find(id);
            db.Messages.Remove(message);
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
