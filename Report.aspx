<%@ Page Title="Report" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="Calender.Report" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container">
        <div class="row">
            <div class="col-12 col-md-3">
                <div class="form-group row no-gutters">
                                    <label for="inputEmail3" class="col-sm-12">Start Date</label>
                                    <div class="col-sm-9">
                                        <input type="email" class="form-control" id="FromDateTime" placeholder="date and time">
                                    </div>
                                </div>
            </div>
            <div class="col-12 col-md-3">
                <div class="form-group row no-gutters">
                                    <label for="inputEmail3" class="col-sm-12">End Date</label>
                                    <div class="col-sm-9">
                                        <input type="email" class="form-control" id="ToDateTime" placeholder="date and time">
                                    </div>
                                </div>
            </div>
            <div class="col-12 col-md-3">
                <div class="form-group row no-gutters">
                                    <label for="inputEmail3" class="col-sm-12">Centers</label>
                                    <div class="col-sm-9">
                                        <select class="form-control" id="drpCenter" name="Service" >
                                        </select>
                                    </div>
                                </div>
            </div>
            <div class="col-12 col-md">
                <div class="form-group row no-gutters">
                                    <label for="inputEmail3" class="col-sm-12">Service</label>
                                    <div class="col-sm-9">
                                        <select class="form-control" id="drpService" name="Service" multiple>
                                        </select>
                                    </div>
                                </div>
            </div>
            <div class="col-12 pb-2 text-right">
            <a href="#" onclick="LoadReport()" id="btnLoadReport" class="btn btn-info">Generate Report</a>
            </div>

            <div class="w-100"></div>
            <div class="col-12">
                <div id="Grid"></div>
            </div>
        </div>
    </div>
    <script>

        let token = localStorage.getItem("token");
        var base = 'http://api.markaziasystems.com/api/v1/';
        //base = 'http://localhost:4500/api/v1/';
        $('#drpService').select2();
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
                let data = result.Data.map(function (v, i) { return { id: v.ServiceCenterId, text: v.ServiceCenterName } });
                console.log(data);
                $("#drpCenter").select2({
                    data: data,
                    width: '100%',
                    placeholder: 'Select Services',
                }).trigger('change');
            },
            error: function (xhr, status, error) {
                //alert(xhr);

            }
        });
        $("#drpCenter").on('change', function () {
            var id = $(this).val();
            $.ajax({
                type: "GET",
                url: base + 'ServiceCenterWorkshops/SC_WS_GetServices?CenterId=' + id,
                headers: {
                    'Access-Control-Allow-Headers': 'Authorization',
                    'Authorization': 'Bearer ' + token
                },
                dataType: 'json',
                success: function (result, status, xhr) {
                    let data = result.Data.map(function (v) { return { id: v.Service.ServiceId, text: v.Service.ServiceName }; });

                    $("#drpService").select2({
                        data: data,
                        width: '100%',
                        placeholder: 'Select Services',
                    }).trigger('change');

                },
                error: function (xhr, status, error) {
                    //alert(xhr);
                }
            })
        });
        // initialize DatePicker component
        var datepicker = new ej.calendars.DatePicker();

        // Render initialized DatePicker.
        datepicker.appendTo('#FromDateTime')
        // initialize DatePicker component
        var datepicker2 = new ej.calendars.DatePicker();

        // Render initialized DatePicker.
        datepicker2.appendTo('#ToDateTime')
        

        var grid = new ej.grids.Grid({
            toolbar: ['ExcelExport', 'Search'],
            allowExcelExport: true,
            allowPaging: true,
            pageSettings: { pageSizes: true, pageSize: 10 },
            columns: [
                { field: 'ApptDate', headerText: 'Appt. Date', width: 140, format: 'MMMM dd,  y' },
                { field: 'Time', headerText: 'Appt. Time', width: 140 },//, format: 'hh:mm a'
                { field: 'ServiceName', headerText: 'Service/Class', width: 140},
                { field: 'CustomerName', headerText: 'Customer', width: 140 },
                { field: 'Mobile', headerText: 'Phone', width: 140 },
                { field: 'Status', headerText: 'Status', width: 140 },
                { field: 'AppointmentId', headerText: 'Booking ID', width: 140 }
            ]
        });
        grid.appendTo('#Grid');
        grid.toolbarClick = (args) => {
            if (args['item'].id === 'Grid_excelexport') {
                grid.excelExport();
            }
        }
        function LoadReport() {
            var mybutton = document.getElementById("btnLoadReport");
            $(mybutton).css("opacity", "0.5");
            $(mybutton).css("cursor", "default");
            $(mybutton).attr("disabled", "disabled");
            mybutton.innerHTML = "Generate Report &nbsp;<i style='font-size:20px;' class='fa fa-spinner faa-spin animated'></i>";

            grid.dataSource = [];
            var fromTime = datepicker.value;
            var toTime = datepicker2.value;
            //var services = $('#drpService').select2('data').map(function (v) { return parseInt(v.id) });
            let model = {};
            model.StartDate = fromTime;
            model.EndDate = toTime;
            model.Services = $('#drpService').val().join(",");
            
            grid.showSpinner();
            var data = { StartDate: moment(fromTime).format('MM/DD/YYYY'), EndDate: moment(toTime).format('MM/DD/YYYY'), Services: $('#drpService').val().join(",") };
            
            $.ajax({
                type: "GET",
                url: base + 'Appointments/SC_Apt_GetReportAppointments',
                headers: {
                    'Access-Control-Allow-Headers': 'Authorization',
                    'Authorization': 'Bearer ' + token
                },
                data: data,
                contentType: "application/json; charset=utf8",
                dataType: 'json',
                success: function (result, status, xhr) {
                    let data = result.Data.map(function (v) {
                        return {
                            AppointmentId: v.AppointmentId, CustomerName: v.Customer.AccName, Mobile: v.Customer.AccMobile1,
                            ServiceName: v.ServiceName, ApptDate: new Date(v.AppointmentDate), Status: v.Status, Time:v.Time
                        };
                    });
                    console.log(data);
                    grid.dataSource = data;

                    $(mybutton).css("opacity", "1");
                    $(mybutton).css("cursor", "pointer");
                    $(mybutton).removeAttr("disabled");
                    mybutton.innerHTML = "Generate Report";

                },
                error: function (xhr, status, error) {
                    grid.dataSource = [];
                    
                    $(mybutton).css("opacity", "1");
                    $(mybutton).css("cursor", "pointer");
                    $(mybutton).removeAttr("disabled");
                    mybutton.innerHTML = "Generate Report";
                }
            })
        }
    </script>
</asp:Content>
