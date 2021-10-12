using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;

namespace Calender.Controllers
{
    public class AppointmentController : ApiController
    {
        [HttpPost]
        public async Task<bool> SaveAppointment(string e)
        {
            var a = Newtonsoft.Json.JsonConvert.DeserializeObject<Event>(e);
            Boolean status = false;
            //Event e;
            try
            {
                //var schedule = new Schedule();
                //schedule.StartTime = a.StartTime.ToLocalTime();

                //schedule.ServiceLocationId = a.ServiceLocationId;
                //schedule.ApplicationUserId = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier).Value;


                //await _context.schedules.AddAsync(schedule);
                //await _context.SaveChangesAsync();

                status = true;
            }

            catch
            {

            }

            return status;

        }

        [HttpPost]
        public async Task<bool> UpdateAppointment(string e)
        {
            var a = Newtonsoft.Json.JsonConvert.DeserializeObject<Event>(e);
            Boolean status = false;
            //Event e;
            try
            {
               
                status = true;
            }

            catch
            {

            }

            return status;

        }

        //

       

        // POST: Schedules/Delete/5
        [HttpPost]
        public async Task<bool> Delete(int id)
        {
            //var schedule = await _context.schedules.FindAsync(id);
            //if (schedule == null)
            //{
            //    return false;
            //}
            //_context.schedules.Remove(schedule);
            //await _context.SaveChangesAsync();
            return true;
        }

        [HttpPost]
        public async Task<bool> DragDrop(string e)
        {
            var a = Newtonsoft.Json.JsonConvert.DeserializeObject<Event>(e);
            Boolean status = false;
            //Event e;
            try
            {
                //var schedule = _context.schedules.Find(a.Id);
                //if (schedule == null)
                //    return false;

                //schedule.StartTime = a.StartTime.ToLocalTime();
                ////schedule.ServiceLocationId = a.LocationId;
                //await _context.SaveChangesAsync();

                status = true;
            }

            catch
            {

            }

            return status;

        }
        private bool ScheduleExists(int id)
        {
            return true;// _context.schedules.Any(e => e.ScheduleId == id);
        }
    }
    public class Event
    {
        public int Id { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public string Title { get; set; }
        public int ServiceLocationId { get; set; }
    }
}