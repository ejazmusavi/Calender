<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Calender._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        * Profile container */
.profile {
  margin: 20px 0;
}

/* Profile sidebar */
.profile-sidebar {
  padding: 20px 0 10px 0;
  background: #fff;
}

.profile-userpic img {
  float: none;
  margin: 0 auto;
  width: 50%;
  height: 50%;
  -webkit-border-radius: 50% !important;
  -moz-border-radius: 50% !important;
  border-radius: 50% !important;
  max-width:100px;
}

.profile-usertitle {
  text-align: center;
  margin-top: 20px;
}

.profile-usertitle-name {
  color: #5a7391;
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 7px;
}

.profile-usertitle-job {
  text-transform: uppercase;
  color: #5b9bd1;
  font-size: 12px;
  font-weight: 600;
  margin-bottom: 15px;
}

.profile-userbuttons {
  text-align: center;
  margin-top: 10px;
}

.profile-userbuttons .btn {
  text-transform: uppercase;
  font-size: 11px;
  font-weight: 600;
  padding: 6px 15px;
  margin-right: 5px;
}

.profile-userbuttons .btn:last-child {
  margin-right: 0px;
}
    
.profile-usermenu {
  margin-top: 30px;
}

.profile-usermenu ul li {
  border-bottom: 1px solid #f0f4f7;
  padding:5px 10px 5px 10px;
}

.profile-usermenu ul li:last-child {
  border-bottom: none;
}

.profile-usermenu ul li a {
  color: #93a3b5;
  font-size: 14px;
  font-weight: 400;
}

.profile-usermenu ul li a i {
  margin-right: 8px;
  font-size: 14px;
}

.profile-usermenu ul li a:hover {
  background-color: #fafcfd;
  color: #5b9bd1;
}

.profile-usermenu ul li.active {
  border-bottom: none;
}

.profile-usermenu ul li.active a {
  color: #5b9bd1;
  background-color: #f6f9fb;
  border-left: 2px solid #5b9bd1;
  margin-left: -2px;
}

/* Profile Content */
.profile-content {
  padding: 20px;
  background: #fff;
  min-height: 460px;
}
    </style>
    <div class="row">
        <h1>Appointments</h1>
        <div class="form-group row" style="padding-top:15px;">
                                <label for="inputEmail3" class="col-sm-2 col-form-label">Select Area</label>
                                <div class="col-sm-10">
                                    <select class="form-control" name="Provider">
                                        <option value="">--Select an Area--</option>
                                    </select>
                                </div>
                            </div>
        <br />
        <div id="Schedule"></div>

        
    <div id="dialog1" class="modal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">



                <div class="modal-body">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Appointment</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Customer</a>
                        </li>
                    </ul>
                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade  active in" id="home" role="tabpanel" aria-labelledby="home-tab">
                            <div class="form-group row" style="padding-top:15px;">
                                <label for="inputEmail3" class="col-sm-3 col-form-label">Provider</label>
                                <div class="col-sm-9">
                                    <select class="form-control" name="Provider">
                                        <option value="">--Select a Provider--</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="inputEmail3" class="col-sm-3 col-form-label">Service</label>
                                <div class="col-sm-9">
                                    <select class="form-control" name="Service">
                                        <option value="">--Select a Service--</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="inputEmail3" class="col-sm-3 col-form-label">Date/Time(Start)</label>
                                <div class="col-sm-9">
                                    <input type="email" class="form-control" id="FromDateTime" placeholder="date and time">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="inputEmail3" class="col-sm-3 col-form-label">Duration</label>
                                <div class="col-sm-9">
                                    <select class="form-control" name="Duration">
                                        <option value="">--Select a Duration--</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="inputEmail3" class="col-sm-3 col-form-label">Notes</label>
                                <div class="col-sm-9">
                                    <textarea class="form-control" id="inputEmail7" placeholder="Notes for the Customer"></textarea>
                                </div>
                            </div>
                               
                        </div>
                        <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                            <div class="row">
                                	<div class="col-12">
			<div class="profile-sidebar">
				<!-- SIDEBAR USERPIC -->
				<div class="profile-userpic">
					<img src="https://i.picsum.photos/id/484/200/200.jpg?hmac=3rqhoyJTHVOGelhVPMaglcnpAMl_V3cvNkHZDpSz6_g" class="img-responsive" alt="">
				</div>
				<!-- END SIDEBAR USERPIC -->
				<!-- SIDEBAR USER TITLE -->
				<div class="profile-usertitle">
					<div class="profile-usertitle-name">
						Marcus Doe
					</div>
				</div>
				<!-- END SIDEBAR USER TITLE -->
				<!-- SIDEBAR MENU -->
				<div class="profile-usermenu">
					<ul class="nav">
						<li class="active">
                            Email: customer@site.com
						</li>
						<li>
							Mobile: 
						</li>
						<li>
                            Office:
						</li>
						<li>
                            Home:
						</li>
                        						<li>
                            Address:
						</li>
					</ul>
				</div>
				<!-- END MENU -->
			</div>
		</div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                                <div style="padding-left:25px;">
                                    <label class="checkbox text-left">
                                     <input type="checkbox" class="checkbox" /> Send and email update to your staff and customer
                                    </label>
                                </div>
                     <hr  />
                    <button type="button" class="btn btn-danger float-left" onclick="SaveChanges()">Delete</button>

                    <button type="button" class="btn btn-primary" onclick="SaveChanges()">Save changes</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
        <script>
            // initialize DatePicker component
            var datepicker = new ej.calendars.DateTimePicker();

            // Render initialized DatePicker.
            datepicker.appendTo('#FromDateTime')

            var data = [{
                Id: 1,
                Subject: 'Paris',
                StartTime: new Date(2018, 1, 15, 10, 0),
                EndTime: new Date(2018, 1, 15, 12, 30),
            }];
            var scheduleObj = new ej.schedule.Schedule({
                height: '550px',
                selectedDate: new Date(2018, 1, 15),
                views: ['Day', 'Week', 'TimelineWeek', 'Month', 'Agenda'],
                eventSettings: { dataSource: data }
            });
            scheduleObj.appendTo('#Schedule');

            scheduleObj.actionBegin = function actionBegin(e) {
                console.log('action begin', e);
                if (e.requestType === "eventRemove") {
                    let url = "/Schedules/delete/";
                    $.post(url, { id: e.data[0].Id }, function (data) {
                        if (data) {
                        }
                        else {
                            e.cancel = true;
                        }
                    });
                }
                else if (e.requestType === "eventChange") {
                    let url = "/Schedules/DragDrop/";
                    $.post(url, { e: JSON.stringify(e.data) }, function (data) {
                        if (data) {
                        }
                        else {
                            e.cancel = true;
                        }
                    });
                }
            }
            let startTime = new Date();
            let type = 'edit';
            let editId = 0;
            scheduleObj.popupOpen = function onPopupOpen(args) {
                console.log(args);
                editId = 0;
                type = '';
                $('#time').html('');
                $('#patient').html('');
                if (args.type == 'QuickInfo') {
                    type = 'new';
                    startTime = args.data.startTime;
                    args.cancel = true;
                    // yyyy-mm-ddThh:mm
                    $('#time').html(moment(args.data.startTime).format("dddd, MMMM Do YYYY, h:mm a"));
                    $('#dialog1').modal('show');
                }
                else
                    if (args.type == 'Editor') {
                    type = 'edit';
                    startTime = args.data.StartTime;
                    args.cancel = true;
                    // yyyy-mm-ddThh:mm
                    editId = args.data.Id;
                    
                    $('#time').html(moment(args.data.startTime).format("dddd, MMMM Do YYYY, h:mm a"));
                    $('#patient').html(args.data.Subject);
                    $('#ServiceLocationId').val(args.data.ServiceLocationId);
                    $('#dialog1').modal('show');
                }
            }
            //Getpatients
            function SaveChanges() {
                let e = {
                    StartTime: startTime,
                    ServiceLocationId: $("#ServiceLocationId").val()
                };
                let url = "/Schedules/SaveAppointment";
                if (type == 'edit') {
                    e.id = editId;
                    url = "/Schedules/UpdateAppointment";
                }
                $.ajax({
                    type: 'POST',
                    url: url,
                    data: { e: JSON.stringify(e) },
                    success: function (data) {
                        if (data) {
                            alert('success')
                            $('#dialog1').modal('hide');
                        }
                    },
                    failure: function (response) {
                        alert('failed');
                    }
                });
            }

        </script>
    </div>

</asp:Content>
