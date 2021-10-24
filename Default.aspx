<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Calender._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        #appt-loader {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0,0,0,.2);
            z-index: 99;
            align-items: center;
            display: grid;
            padding: 10px;
        }
       .e-work-cells:not(.e-work-hours), .e-disableCell{
            background-color:rgba(0,0,0,.2) !important;
        }
        .e-canceled {
            background-color: red !important;
        }
        /* modal backdrop fix */
        #diallog-customer, #diallog-vin {
            z-index: 1053 !important;
        }

        .modal-backdrop.show:nth-of-type(even) {
            z-index: 1052 !important;
        }

        #diallog-customer .modal-body, #diallog-vin .modal-body {
            padding: 0px 15px;
        }

        .select2-container--open .select2-dropdown {
            z-index: 1055;
        }

        .modal-body {
            padding: 0;
        }

        .tab-content {
            padding: 15px;
            padding-bottom: 0;
        }

        .input-group .select2-container {
            min-width: calc(100% - 127px);
        }

            .input-group .select2-container--default .select2-selection--single .select2-selection__arrow,
            .input-group .select2-container .select2-selection--single {
                height: 38px;
                border-radius: 0;
                border-color: #ced4da;
            }

        #txtDuration {
            max-width: 95px;
            float: right;
            padding-top: 0;
            padding-bottom: 0;
            line-height: 12px;
            height: 31px;
        }
        /* Profile container */
        .profile {
            margin: 20px 0;
        }

        /* Profile sidebar */
        .profile-sidebar {
            padding: 0px;
            background: #fff;
        }

        .profile-userpic img {
            display: block;
            float: none;
            margin: 0 auto;
            width: 50%;
            height: 50%;
            -webkit-border-radius: 50% !important;
            -moz-border-radius: 50% !important;
            border-radius: 50% !important;
            max-width: 100px;
        }

        .profile-usertitle {
            text-align: center;
            margin-top: 0px;
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
            margin-bottom: 5px;
        }

        .profile-userbuttons {
            text-align: center;
            margin-top: 5px;
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
            margin-top: 0px;
        }

            .profile-usermenu ul li {
                border-bottom: 1px solid #f0f4f7;
                padding: 10px;
                width: 100%;
                float: left;
                display: block;
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
        <div class="col-lg-12 property-section">
            <div class="row" id="area-container">
            </div>
            <div class="row">
                <div class="mb-2 text-right col-12">
                    <a href="/Report" class="btn btn-info float-right">Generate Report</a>
                </div>
            </div>
        </div>
        <div class="col-12">
            <div id="Schedule"></div>
        </div>
        </div>
        <script id="apptemplate" type="text/x-template">
    <div class="template-wrap" style="background:${SecondaryColor}">
        <div class="e-subject" style="background:${PrimaryColor}">${Subject}</div>
        <div class="e-time" style="background:${PrimaryColor}">Time: ${getTimeString(data.StartTime)} - ${getTimeString(data.EndTime)}</div>
    </div>

        </script>

        <div id="dialog1" class="modal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">

                    <div id="appt-loader" style="display: none">
                        <div class="progress">
                            <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%"></div>
                        </div>
                    </div>

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
                            <div class="tab-pane fade  show active in" id="home" role="tabpanel" aria-labelledby="home-tab">
                                
                                <input type="hidden" id="txtCenterId" value="0" />
                                <input type="hidden" id="txtAppointmentId" value="0" />

                                <div class="form-group row mt-3">
                                    <label for="inputEmail3" class="col-sm-3 col-form-label">Service</label>
                                    <div class="col-sm-9">
                                        <select class="form-control" id="drpService" name="Service" multiple>
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

                                    <div class="col" style="display:none">
                                        <div class="row">
                                            <label for="inputEmail3" class="col-sm-3 col-form-label">Duration</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" value="0" readonly id="txtDuration" name="TotalDuration" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-group row">
                                            <label for="inputEmail3" class="col-sm-3 col-form-label">Status</label>
                                            <div class="col-sm-9">
                                                <select class="form-control" id="drpStatus" name="LabelId">
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="inputEmail3" class="col-sm-3 col-form-label">Notes</label>
                                    <div class="col-sm-9">
                                        <textarea class="form-control" id="txtNotes" placeholder="Notes for the Customer"></textarea>
                                    </div>
                                </div>

                            </div>
                            <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="search-customer mt-3">
                                            <div class="input-group mb-3">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text">Search</span>
                                                </div>
                                                <select id="search-customer" class="form-control select2remote">
                                                </select>
                                                <div class="input-group-append">
                                                    <span class="input-group-text"><a href="#" data-toggle="modal" data-target="#diallog-customer">Add</a></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="profile-sidebar">
                                            <!-- SIDEBAR USERPIC
                                            <div class="profile-userpic">
                                                <img src="https://i.picsum.photos/id/484/200/200.jpg?hmac=3rqhoyJTHVOGelhVPMaglcnpAMl_V3cvNkHZDpSz6_g" class="img-responsive" alt="">
                                            </div> -->

                                            <!-- END SIDEBAR USERPIC -->
                                            <!-- SIDEBAR USER TITLE
                                            <div class="profile-usertitle">
                                                <div class="profile-usertitle-name" id="lblcustname">
                                                </div>
                                            </div> -->
                                            <!-- END SIDEBAR USER TITLE -->
                                            <!-- SIDEBAR MENU -->
                                            <div class="profile-usermenu">
                                                <ul class="nav">
                                                    <li>Name: <span id="lblcustname"></span></li>
                                                    <li>Mobile: <span id="lblmobile"></span></li>
                                                    <li>
                                                        <div class="form-group">
                                                            <label>Select VIN</label>
                                                            <div class="input-group mb-3">

                                                                <select class="form-control" name="VIN" id="drpVIN">
                                                                </select>
                                                                <div class="input-group-append">
                                                                    <span class="input-group-text">
                                                                        <a href="#" data-toggle="modal" data-target="#diallog-vin"><i class="fa fa-plus"></i>Add</a>
                                                                    </span>
                                                                </div>
                                                            </div>

                                                        </div>
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
                        <div class="w-100">
                            <label class="checkbox text-left">
                                <input type="checkbox" class="checkbox" id="cbxReminder" checked />
                                Send SMS reminder for Customer
                            </label>
                        </div>
                        <hr />
                        <div class="w-100" id="response"></div>
                        <div class="text-right w-100">
                            <button type="button" id="btnCloseCustomer" class="btn btn-default float-left mr-3" data-dismiss="modal">Close</button>

                            <button type="button" class="btn btn-danger float-left" id="btnDelete" onclick="DeleteEvent()">Delete</button>

                            <button type="button" class="btn btn-primary" id="btnSave" onclick="SaveChanges()">Save changes</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="diallog-customer" class="modal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4>Add New Customer</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group row" style="padding-top: 15px;">
                            <label for="inputEmail3" class="col-sm-3 col-form-label">First Name</label>
                            <div class="col-sm-9">
                                <input type="text" id="FirstName" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="inputEmail3" class="col-sm-3 col-form-label">Last Name</label>
                            <div class="col-sm-9">

                                <input type="text" id="LastName" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="inputEmail3" class="col-sm-3 col-form-label">Mobile</label>
                            <div class="col-sm-9">

                                <input type="text" id="Mobile" class="form-control" />
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">

                        <div class="w-100" id="customer-response"></div>

                        <button type="button" class="btn btn-primary" id="btnSaveCustomer" onclick="SaveCustomer()">Save changes</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>


        <div id="diallog-vin" class="modal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4>Add New VIN</h4>
                    </div>
                    <div class="modal-body ">

                        <div class="form-group row mt-3">
                            <label for="inputEmail3" class="col-sm-3 col-form-label">Vehicle No</label>
                            <div class="col-sm-9">
                                <input type="text" id="VehicleNo" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group row mt-3">
                            <label for="inputEmail3" class="col-sm-3 col-form-label">Palette No</label>
                            <div class="col-sm-9">
                                <input type="text" id="PaletteNo" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="inputEmail3" class="col-sm-3 col-form-label">Brand</label>
                            <div class="col-sm-9">
                                <select class="form-control" id="drpBrand" name="Service">
                                </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="inputEmail3" class="col-sm-3 col-form-label">Model</label>
                            <div class="col-sm-9">
                                <select class="form-control" id="drpModel" name="Service">
                                </select>
                            </div>
                        </div>
                        <div class="form-group row mt-3">
                            <label for="inputEmail3" class="col-sm-3 col-form-label">Year</label>
                            <div class="col-sm-9">
                                <input type="text" id="ModelYear" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">

                        <div class="w-100" id="vin-response"></div>
                        <button type="button" class="btn btn-primary" id="btnSaveVIN" onclick="SaveVIN()">Save changes</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <script>

            
            let token = localStorage.getItem("token");
            if (!token || token == '') {
                $(location).attr("href", '/Login');
            }
            var base = 'http://api.markaziasystems.com/api/v1/';
            //base = 'http://localhost:4500/api/v1/';
            let serviceCenterCollection = [];
            let autoSearch = false;
            function select2_search($el, term) {
                $el.select2('open');

                // Get the search box within the dropdown or the selection
                // Dropdown = single, Selection = multiple
                var $search = $el.data('select2').dropdown.$search || $el.data('select2').selection.$search;
                // This is undocumented and may change in the future

                $search.val(term);
                autoSearch = true;
                $search.trigger('input');

            }

            let drpCustomer = $('#search-customer').select2({
                placeholder: "Search Customer",
                allowClear: true,
                minimumInputLength: 1,
                ajax: {
                    url: base + 'Customers/SC_GetCustomerInfo',
                    headers: {
                        'Access-Control-Allow-Headers': 'Authorization',
                        'Authorization': 'Bearer ' + token
                    },
                    data: function (params) {
                        var query = {
                            SearchTerm: params.term,
                            type: 'public'
                        }

                        // Query parameters will be ?SearchTerm=[term]&type=public
                        return query;
                    },
                    processResults: function (data) {
                        if (autoSearch) {
                            setTimeout(function () { $('#select2-search-customer-results .select2-results__option').trigger("mouseup") }, 300);
                        }
                        autoSearch = false;
                        return {
                            results: data.Data.Result.map(function (v) { return { id: v.AccId, text: v.AccName, name: v.AccName, mobile: v.AccMobile1 }; })
                        }
                    }
                }
            });

            drpCustomer.on('change', function () {
                var selected = $(this).select2('data')[0];
                if (selected) {
                    var id = selected.id;
                    $('#lblcustname').html(selected.name);
                    $('#lblmobile').html(selected.mobile);

                    $.ajax(
                        {
                            url: base + 'Customers/SC_GetCustomersVins?CustomerId=' + id,
                            type: "GET",
                            headers: {
                                'Access-Control-Allow-Headers': 'Authorization',
                                'Authorization': 'Bearer ' + token
                            },
                            dataType: 'json',
                            success: function (result, status, xhr) {
                                let data = result.Data.Result.map(function (v) { return { id: v.VinId, text: v.VinNo + ', ' + v.Brand + ', ' + v.ModelName }; });
                                $("#drpVIN").select2({
                                    data: data
                                })
                                if (VINId > 0)
                                    $('#drpVIN').val(VINId).trigger('change');
                            },
                            error: function (xhr, status, error) {
                                alert(xhr);
                            }
                        }
                    )
                }
                else {
                    $('#lblcustname').html('');
                    $('#lblmobile').html('');
                    $("#drpVIN").html('').select2({
                        data: [],
                        placeholder: 'Select VIN'
                    });
                }
            });

            function LoadEvents() {
                scheduleObj.showSpinner();
                if (scheduleObj.eventsData.length > 0) {
                    scheduleObj.deleteEvent(scheduleObj.eventsData);
                    scheduleObj.eventsData = [];
                }
                let StartDate = scheduleObj.activeView.renderDates[0];
                let EndDate = scheduleObj.activeView.renderDates[scheduleObj.activeView.renderDates.length - 1];

                var data = { StartDate: moment(StartDate).format('MM/DD/YYYY'), EndDate: moment(EndDate).format('MM/DD/YYYY') };
                $.ajax({
                    type: "GET",
                    url: base + "Appointments/SC_Apt_GetCalenderAppointments",
                    headers: {
                        'Access-Control-Allow-Headers': 'Authorization',
                        'Authorization': 'Bearer ' + token
                    },
                    data: data,
                    contentType: "application/json; charset=utf8",
                    dataType: 'json',
                    success: function (result, status, xhr) {
                        var events = result.Data.map(function (v, i) {
                            return {
                                AppointmentID: v.AppointmentId,
                                Id: v.AppointmentId,
                                Notes: v.Notes,
                                Subject: v.CustomerName,
                                StartTime: new Date(v.AppointmentDate),
                                EndTime: moment(new Date(v.AppointmentDate))
                                    .add(v.TotalDuration, 'minutes').toDate(),
                                ServiceCenterId: v.CenterID,
                                AppointmentServices: v.SCAppointmentServices,
                                VINID: v.VINID,
                                CustomerID: v.CustomerID,
                                SendReminder: v.SendReminder,
                                Status: v.Status,
                                LabelId: v.LabelId
                            }
                        });
                        scheduleObj.addEvent(events);
                        //scheduleObj.hideSpinner();

                    },
                    error: function (xhr, status, error) {
                        scheduleObj.hideSpinner();
                    }
                });
            }


            // initialize DatePicker component
            var datepicker = new ej.calendars.DateTimePicker();
            datepicker.step = 1;
            datepicker.firstDayOfWeek = 6;
            datepicker.allowEdit = false;
            datepicker.placeholder = 'Appointment date';
            // Render initialized DatePicker.
            datepicker.appendTo('#FromDateTime')
            datepicker.renderDayCell = function (args) {
                if (args.date.getDay() == 5) { args.isDisabled = true; }
            }
            

            var data = [];
            var scheduleObj = new ej.schedule.Schedule({
                height: '550px',
                selectedDate: new Date(),
                allowDragAndDrop:false,
                views: ['Day', 'Week', 'TimelineWeek', 'Month', 'Agenda'],
                eventSettings: { dataSource: data },
                startHour: '08:00',
                endHour: '22:00',
                workDays: [0, 1, 2, 3, 4, 6],
                firstDayOfWeek: 5,
                timeScale: {
                    enable: true,
                    interval: 60,
                    slotCount: 4
                },
                group: {
                    resources: ['ServiceCenter']
                },
                resources: [{
                    field: 'ServiceCenterId', title: 'Service Center',
                    name: 'ServiceCenter', allowMultiple: true,
                    dataSource: serviceCenterCollection,
                    textField: 'Name', idField: 'Id', workDaysField: 'workDays'
                }],
            });
            scheduleObj.appendTo('#Schedule');
            scheduleObj.showSpinner();
            var ele;
            scheduleObj.eventRendered = function (args) {
                if (args.data.Status == 'Cancelled' || args.data.Status == 'Canceled') {
                    args.element.classList.add('e-canceled')
                }
            }
            scheduleObj.renderCell = function (args) {
                if (args.date < new Date(new Date().setHours(0, 0, 0, 0))) {
                    args.element.classList.add('e-disableCell');
                }
            }
            var workingDays = [];
            workingDays["Sunday"] = 0;
            workingDays["Monday"] = 1;
            workingDays["Tuesday"] = 2;
            workingDays["Wednesday"] = 3;
            workingDays["Thursday"] = 4;
            workingDays["Friday"] = 5;
            workingDays["Saturday"] = 6;
            //Get Service Centers
            $.ajax({
                type: "GET",
                url: base + "ServiceCenters/SC_GetServiceCenters",
                headers: {
                    'Access-Control-Allow-Headers': 'Authorization',
                    'Authorization': 'Bearer ' + token
                },
                dataType: 'json',
                success: function (result, status, xhr) {
                    if (!result.Success)
                        return false;

                    $.each(result.Data, function (i, v) {
                        let chk = ''
                        let resourceWorkingDays = [];
                        let resourceWorkingHours = [];
                        $.each(v.AptCenterWorkingDays, function (j, d) {
                            resourceWorkingDays.push(workingDays[d.DayName] ?? 3);
                            resourceWorkingHours.push({ dayIndex: workingDays[d.DayName] ?? 3, startHour: d.StartingHour, endHour: d.EndingHour });
                        });
                        var col = { Name: v.ServiceCenterName, Id: v.ServiceCenterId, workDays: resourceWorkingDays, workHours: resourceWorkingHours };
                        serviceCenterCollection.push(col);
                            scheduleObj.addResource(col, 'ServiceCenter', i);
                        if (i == 0) {
                            if (col.workHours[0]?.startHour)
                                scheduleObj.scrollTo(col.workHours[0].startHour.substr(0, 5));
                        }
                        var html = '<div class="col-6 col-sm-4 col-md-3"><label> <input value="' + v.ServiceCenterId + '" checked class="e-resource-calendar e-personal" type="checkbox" onchange="onChange(this,\'' + v.ServiceCenterName + '\',' + i + ')" /> ' + v.ServiceCenterName + '</label></div>';
                        $('#area-container').append(html);

                    });
                    LoadEvents();
                },
                error: function (xhr, status, error) {
                    //alert(xhr);
                    scheduleObj.hideSpinner();

                }
            });
            //End Get Service Centers

            //Get Status from lookup
            $.ajax(
                {
                    url: base + 'Appointments/SC_GetAppintmentStatus',
                    type: "GET",
                    headers: {
                        'Access-Control-Allow-Headers': 'Authorization',
                        'Authorization': 'Bearer ' + token
                    },
                    dataType: 'json',
                    success: function (result, status, xhr) {
                        let data = result.Data.Result.map(function (v) { return { id: v.CodeId, text: v.CodeData }; });
                        $("#drpStatus").select2({
                            width: '100%',
                            data: data
                        });
                    },
                    error: function (xhr, status, error) {
                        alert(xhr);
                    }
                }
            );
            //End Get Status from Lookup

            function onChange(args, name, i) {
                let checked = $(args).is(':checked')
                var value = parseInt($(args).val());
                var col = serviceCenterCollection[i];
                if (checked) {
                    scheduleObj.addResource(col, 'ServiceCenter', i);
                } else {
                    scheduleObj.removeResource(value, 'ServiceCenter');
                    //scheduleObj.removeResource(4, 'ServiceCenter')
                }
            }
            scheduleObj.dataBound = function (e) {
                var renderedDates = scheduleObj.activeView.getRenderDates();
                scheduleObj.resetWorkHours();
                for (var j = 0; j < scheduleObj.activeView.colLevels[0].length; j++) {
                    let workHours1 = scheduleObj.activeView.colLevels[0][j].resourceData.workHours;
                    for (var i = 0; i < renderedDates.length; i++) {
                        var dayIndex = renderedDates[i].getDay();
                        let dayTimes = workHours1.find(function (v, i) { return v.dayIndex == dayIndex });
                        if (dayTimes) {
                            scheduleObj.setWorkHours([renderedDates[i]], dayTimes.startHour.substr(0, 5), dayTimes.endHour.substr(0, 5), j);
                        }
                    }
                }
            }
            scheduleObj.actionComplete = function (e) {
                if (e.requestType == 'dateNavigate' || e.requestType == 'viewNavigate') {
                    LoadEvents();
                }
            }
            scheduleObj.navigating = function (e) {
                //if (e.action == 'date' || e.action == 'view') {
                //    LoadEvents();
                //}
            }
            
            scheduleObj.popupOpen = function (args) {
                Reset();
                var event = args.data;
                if (args.target.classList.contains('e-disableCell') || !args.target.classList.contains('e-work-hours') & !event.Id) {
                    args.cancel = true;
                    return;
                }
                $('#appt-loader').show();
                //$('.nav-tabs a[href="#home-tab"]').tab('show');
                $('#myTab a:first').tab('show')
                let time = new Date(new Date().toLocaleString());
                datepicker.min = time;
                datepicker.value = event.StartTime;
                $('#txtCenterId').val(event.ServiceCenterId);
                if (event.Id && event.Id > 0) {
                    $('#txtAppointmentId').val(event.Id);
                    $('#drpStatus').val(event.LabelId).trigger('change');
                    $('#txtNotes').val(event.Notes);
                    //SearchCustomer(event.CustomerID);
                    VINId = event.VINID;
                    select2_search($('#search-customer'), event.CustomerID);
                    $('#cbxReminder').attr('checked', event.SendReminder);

                    $('#btnDelete').show();
                }
                else {
                    $('#btnDelete').hide();
                }
                $.ajax({
                    type: "GET",
                    url: base + 'ServiceCenterWorkshops/SC_WS_GetServices?CenterId=' + args.data.ServiceCenterId,
                    headers: {
                        'Access-Control-Allow-Headers': 'Authorization',
                        'Authorization': 'Bearer ' + token
                    },
                    dataType: 'json',
                    success: function (result, status, xhr) {
                        let data = result.Data.map(function (v) { return { id: v.Service.ServiceId, text: v.Service.ServiceName, timeReq: v.Service.TimeRequiredMin }; });
                        let selectedValues = event.AppointmentServices?.map(function (v, i) {
                            return v.ServiceID
                        });

                        $("#drpService").select2({
                            data: data,
                            width: '100%',
                            placeholder: 'Select Services',
                        });

                        $("#drpService").val(selectedValues).trigger('change');

                        $('#appt-loader').hide();
                    },
                    error: function (xhr, status, error) {
                        //alert(xhr);
                        $('#appt-loader').hide();
                    }
                })
                if (args.type == 'QuickInfo') {
                    type = 'new';
                    args.cancel = true;
                    $('#dialog1').modal('show');
                }
                else
                    if (args.type == 'Editor') {
                        type = 'edit';
                        args.cancel = true;
                        // yyyy-mm-ddThh:mm


                        $('#dialog1').modal('show');
                    }
            }
            let startTime = new Date();
            let type = 'edit';
            let VINId = 0;
            $("#drpService").on('change', function () {

                $('#txtDuration').val(0);
                //let selected = $(this).select2('data');
                let total = 15;
                //$.each(selected, function (i, v) {
                //    total += v.timeReq;
                //});
                $('#txtDuration').val(total);

            })
            function SaveChanges() {

                var mybutton = document.getElementById("btnSave");
                $(mybutton).css("opacity", "0.5");
                $(mybutton).css("cursor", "default");
                $(mybutton).attr("disabled", "disabled");
                mybutton.innerHTML = "Save changes &nbsp;<i style='font-size:20px;' class='fa fa-spinner faa-spin animated'></i>";
                var model = {};
                model.AppointmentId = parseInt($('#txtAppointmentId').val());
                model.CustomerID = parseInt($('#search-customer').val());
                model.CenterID = parseInt($('#txtCenterId').val());
                model.VINID = parseInt($('#drpVIN').val());
                model.AppointmentDate = datepicker.value;
                model.SendReminder = $('#cbxReminder').is(':checked');
                model.LabelId = $('#drpStatus').val();
                model.Notes = $('#txtNotes').val();

                if (!model.AppointmentId)
                    model.AppointmentId = 0;

                if (!model.CustomerID) {
                    showError('Please select a Customer to continue.', mybutton);
                    return false;
                }
                if (!model.VINID) {
                    showError('Please select a VIN to continue.', mybutton);
                    return false;
                }
                var services = $('#drpService').select2('data');
                model.AppointmentServices = services.map(function (v) { return { ServiceID: v.id, Duration: v.timeReq } });
                if (!model.AppointmentServices || model.AppointmentServices.length == 0) {
                    showError('Please atlease One Service to continue.', mybutton);
                    return false;
                }
                var options = {};
                options.url = base + (model.AppointmentId > 0 ? "Appointments/SC_Edit_Appointment" : "Appointments/SC_Add_Appointment");
                options.type = "POST";
                options.headers = {
                    'Access-Control-Allow-Headers': 'Authorization',
                    'Authorization': 'Bearer ' + token
                }
                options.data = JSON.stringify(model);
                options.contentType = "application/json";
                options.dataType = "json";

                options.success = function (response) {
                    if (response.Success) {
                        if (model.AppointmentId > 0) {
                            scheduleObj.deleteEvent(response.Data)
                        }
                        let newEvent = {
                            Id: response.Data,
                            Subject: $('#search-customer').select2('data')[0].text,
                            StartTime: model.AppointmentDate,
                            EndTime: moment(model.AppointmentDate)
                                .add($('#txtDuration').val(), 'minutes').toDate(),
                            ServiceCenterId: model.CenterID,
                            AppointmentServices: model.AppointmentServices,
                            VINID: model.VINID,
                            CustomerID: model.CustomerID,
                            SendReminder: model.SendReminder,
                            Notes: model.Notes,
                            Status: $('#drpStatus').select2('data')[0].text,
                            LabelId: $('#drpStatus').val()
                        };
                        var added = scheduleObj.addEvent(newEvent);
                        Reset();
                        $("#response").html("<span class='alert alert-info text-info my-2 d-block'>Appointment Saved successfully.</span> ");
                        $(mybutton).css("opacity", "1");
                        $(mybutton).css("cursor", "pointer");
                        $(mybutton).removeAttr("disabled");
                        mybutton.innerHTML = "Save changes";
                        $('#btnCloseCustomer').trigger('click');
                    }
                    else {
                        showError('Error occured while trying to save the appointment!.', mybutton);
                    }
                };
                options.error = function () {
                    showError('Error occured while trying to save the appointment!.', mybutton);
                };
                $.ajax(options);
            }

            function showError(message, mybutton, errorcontainer) {
                if (!errorcontainer || errorcontainer == '')
                    errorcontainer = 'response';
                $("#" + errorcontainer + "").html("<span class='alert alert-danger text-danger my-2 d-block' >" + message + "</span> ");
                setTimeout(function () {
                    $("#" + errorcontainer + "").html("");
                }, 5000);

                $(mybutton).css("opacity", "1");
                $(mybutton).css("cursor", "pointer");
                $(mybutton).removeAttr("disabled");
                mybutton.innerHTML = "Save changes";
            }

            function Reset() {

                var mybutton = document.getElementById("btnSave");
                $(mybutton).css("opacity", "1");
                $(mybutton).css("cursor", "pointer");
                $(mybutton).removeAttr("disabled");
                mybutton.innerHTML = "Save changes";
                $('#response').html('');
                $('#customer-response').html('');
                $('#vin-response').html('');
                VINId = 0;

                $('#drpService').html('').select2({
                    width: '100%',
                    data: [],
                    placeholder: 'Select Services'
                });

                $('#txtCenterId').val('');
                $('#txtAppointmentId').val('');

                $('#txtDuration').val('');
                $('#txtNotes').val('');
                $('#txtCenterId').val('');
                $('#search-customer').val('').trigger('change');
                $('#cbxReminder').prop('checked', true);
                $('#drpVIN').html('').select2({
                    data: [],
                    placeholder: 'Select VIN'
                }).trigger('change');

                $('#lblmobile').html('');
                $('#lblcustname').html('');


                $('#FirstName').html('');
                $('#LastNmae').html('');
                $('#Mobile').html('');
                $('#VehicleNo').html('');

                $('#drpBrand').val('').trigger('change');


                $('#drpModel').html('').select2({
                    data: [],
                    placeholder: 'Select Model'
                }).trigger('change');

            }

            function DeleteEvent() {
                if (!confirm('Are you sure to delete this appointment?')) {
                    return false;
                }
                var mybutton = document.getElementById("btnDelete");
                $(mybutton).css("opacity", "0.5");
                $(mybutton).css("cursor", "default");
                $(mybutton).attr("disabled", "disabled");
                mybutton.innerHTML = "Delete &nbsp;<i style='font-size:20px;' class='fa fa-spinner faa-spin animated'></i>";


                let AppointmentID = parseInt($('#txtAppointmentId').val());

                var options = {};
                options.url = base + "Appointments/SC_Delete_Appointment?Id=" + AppointmentID;
                options.type = "POST";
                options.headers = {
                    'Access-Control-Allow-Headers': 'Authorization',
                    'Authorization': 'Bearer ' + token
                }
                options.contentType = "application/json";
                options.dataType = "json";

                options.success = function (response) {
                    if (response.Success) {
                        scheduleObj.deleteEvent(response.Data)
                        Reset();
                        $("#response").html("<span class='alert alert-info text-info my-2 d-block' >Appointment deleted successfully.</span> ");
                        $(mybutton).css("opacity", "1");
                        $(mybutton).css("cursor", "pointer");
                        $(mybutton).removeAttr("disabled");
                        mybutton.innerHTML = "Delete";
                        $('#btnCloseCustomer').trigger('click');
                    }
                    else {
                        showError('Error occured while trying to delete the appointment!.', mybutton);
                    }
                };
                options.error = function () {
                    showError('Error occured while trying to delete the appointment!.', mybutton);
                };
                $.ajax(options);
            }

            function SaveCustomer() {

                var mybutton = document.getElementById("btnSaveCustomer");
                $(mybutton).css("opacity", "0.5");
                $(mybutton).css("cursor", "default");
                $(mybutton).attr("disabled", "disabled");
                mybutton.innerHTML = "Save changes &nbsp;<i style='font-size:20px;' class='fa fa-spinner fa-spin animated'></i>";
                var model = {};
                model.FirstName = $('#FirstName').val();
                model.LastName = $('#LastName').val();
                model.Mobile = $('#Mobile').val();

                if (!model.FirstName) {
                    showError('Please enter First name to continue.', mybutton, 'customer-response');
                    return false;
                }
                if (!model.LastName) {
                    showError('Please enter Last name to continue.', mybutton, 'customer-response');
                    return false;
                }
                if (!model.Mobile) {
                    showError('Please enter Mobile to continue.', mybutton, 'customer-response');
                    return false;
                }

                var options = {};
                options.url = base + "Customers/SC_Add_Customer";
                options.type = "POST";
                options.headers = {
                    'Access-Control-Allow-Headers': 'Authorization',
                    'Authorization': 'Bearer ' + token
                }
                options.data = JSON.stringify(model);
                options.contentType = "application/json";
                options.dataType = "json";

                options.success = function (response) {
                    if (response.Success) {
                        select2_search($('#search-customer'), response.Data);
                        $('#FirstName').val('');
                        $('#LastName').val('');
                        $('#Mobile').val('');
                        $("#customer-response").html("<span class='alert alert-info text-info my-2 d-block'>Customer Saved successfully.</span> ");
                        setTimeout(function () {
                            $("#customer-response").html("");
                        }, 5000);

                        $(mybutton).css("opacity", "1");
                        $(mybutton).css("cursor", "pointer");
                        $(mybutton).removeAttr("disabled");
                        mybutton.innerHTML = "Save changes";
                    }
                    else {
                        showError('Error occured while trying to save the Customer!.', mybutton, 'customer-response');
                    }
                };
                options.error = function () {
                    showError('Error occured while trying to save the Customer!.', mybutton, 'customer-response');
                };
                $.ajax(options);
            }


            $.ajax(
                {
                    url: base + 'Lookups/SC_GetLookups?CodeType=1301',
                    type: "GET",
                    headers: {
                        'Access-Control-Allow-Headers': 'Authorization',
                        'Authorization': 'Bearer ' + token
                    },
                    dataType: 'json',
                    success: function (result, status, xhr) {
                        let data = result.Data.Result.map(function (v) { return { id: v.CodeId, text: v.CodeData }; });
                        $("#drpBrand").select2({
                            width: '100%',
                            data: data
                        });
                    },
                    error: function (xhr, status, error) {
                        alert(xhr);
                    }
                }
            );

            $("#drpBrand").on('change', function () {
                let id = $(this).val();

                $("#drpModel").html('').select2({
                    width: '100%',
                    data: []
                });
                if (!id)
                    return;
                $.ajax(
                    {
                        url: base + 'Lookups/SC_GetBrandModels?BrandId=' + id,
                        type: "GET",
                        headers: {
                            'Access-Control-Allow-Headers': 'Authorization',
                            'Authorization': 'Bearer ' + token
                        },
                        dataType: 'json',
                        success: function (result, status, xhr) {
                            let data1 = result.Data.Result.map(function (v) { return { id: v.ModelId, text: v.ModelName }; });
                            $("#drpModel").select2({
                                width: '100%',
                                data: data1
                            });
                        },
                        error: function (xhr, status, error) {
                            alert(xhr);
                        }
                    }
                );

            })

            function SaveVIN() {

                var mybutton = document.getElementById("btnSaveVIN");
                $(mybutton).css("opacity", "0.5");
                $(mybutton).css("cursor", "default");
                $(mybutton).attr("disabled", "disabled");
                mybutton.innerHTML = "Save changes &nbsp;<i style='font-size:20px;' class='fa fa-spinner fa-spin animated'></i>";
                var model = {};
                model.AccountId = parseInt($('#search-customer').val())
                model.VehicleNumber = $('#VehicleNo').val();
                model.BrandId = $('#drpBrand').val();
                model.ModelId = $('#drpModel').val();
                model.ModelYear = $('#ModelYear').val();
                model.PlateNumber = $('#PaletteNo').val();

                if (!model.AccountId) {
                    showError('Please select a Customer to continue.', mybutton, 'vin-response');
                    return false;
                }
                if (model.VehicleNumber == '') {
                    //showError('Please enter Vehicle Number to continue.', mybutton, 'vin-response');
                    //return false;
                    model.VehicleNumber = GenerateFakeVin(11)
                }
                if (!model.BrandId) {
                    showError('Please select a Brand to continue.', mybutton, 'vin-response');
                    return false;
                }

                var options = {};
                options.url = base + "Customers/SC_Add_CustomerVin";
                options.type = "POST";
                options.headers = {
                    'Access-Control-Allow-Headers': 'Authorization',
                    'Authorization': 'Bearer ' + token
                }
                options.data = JSON.stringify(model);
                options.contentType = "application/json";
                options.dataType = "json";

                options.success = function (response) {
                    if (response.Success) {
                        $('#search-customer').trigger('change');
                        $('#VehicleNo').val('');
                        $("#vin-response").html("<span class='alert alert-info text-info my-2 d-block'>VIN Saved successfully.</span> ");
                        setTimeout(function () {
                            $("#vin-response").html("");
                        }, 5000);

                        $(mybutton).css("opacity", "1");
                        $(mybutton).css("cursor", "pointer");
                        $(mybutton).removeAttr("disabled");
                        mybutton.innerHTML = "Save changes";
                    }
                    else {
                        showError('Error occured while trying to save the VIN!.', mybutton, 'vin-response');
                    }
                };
                options.error = function () {
                    showError('Error occured while trying to save the VIN!.', mybutton, 'vin-response');
                };
                $.ajax(options);
            }

            function GenerateFakeVin(n) {
                var add = 1, max = 12 - add;   // 12 is the min safe number Math.random() can generate without it starting to pad the end with zeros.   

                if (n > max) {
                    return GenerateFakeVin(max) + GenerateFakeVin(n - max);
                }

                max = Math.pow(10, n + add);
                var min = max / 10; // Math.pow(10, n) basically
                var number = Math.floor(Math.random() * (max - min + 1)) + min;

                return ("" + number).substring(add);
            }
        </script>
    </div>

</asp:Content>
