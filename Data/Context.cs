using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace Calender.Data
{
    public class Context : DbContext
    {
        public Context() : base("DefaultConnection")
        {

        }
        public DbSet<Appointment> Appointments { get; set; }
    }


    [Table("SC_Apt_Appointments")]
    public class Appointment
    {
        public int Id { get; set; }
        public int ServiceCenterId { get; set; }
        public int CustomerId { get; set; }
        public int ProviderId { get; set; }
        public int ServiceId { get; set; }
        public DateTime AppointmentDate { get; set; }
        public int Duration { get; set; }
        public string Notes { get; set; }
        public bool SendReminder { get; set; }
        public bool IsActive { get; set; }
        public bool IsDeleted { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedAt { get; set; }

    }
}