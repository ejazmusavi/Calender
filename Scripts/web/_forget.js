
(function ($) {
    "use strict";


    /*==================================================================
    [ Focus Contact2 ]*/
    $('.forgotinputval').each(function () {
        $(this).on('blur', function () {
            if ($(this).val().trim() != "") {
                $(this).addClass('has-val');
            }
            else {
                $(this).removeClass('has-val');
            }
        })
    })


    /*==================================================================
    [ Validate ]*/
    var input = $('.validate-input .forgotinputval');

    //$('.validate-form').on('submit',function(){
    //    var check = true;

    //    for(var i=0; i<input.length; i++) {
    //        if(validate(input[i]) == false){
    //            showValidate(input[i]);
    //            check=false;
    //        }
    //    }

    //    return check;
    //});

    $('#btnSend').on('click', function () {
        var check = true;

        //////////////////////////////////////////////////////////
        ////  TURN TEXTBOX VALIDATION ON  ///////////////////////
        /////////////////////////////////////////////////////////
        //for (var i = 0; i < input.length; i++) {
        //    if (validate(input[i]) == false) {
        //        showValidate(input[i]);
        //        check = false;
        //    }
        //}

        //if (check == true) {
        //    forgetPasswordMessage();
        //}

        forgetPasswordMessage();

        return check;
    });

    $('a.panel1').click(function() {
        //clear label message if there is an old message on it
        $('#lblForgetMsg').html(' ');
    });


    $('.validate-form .forgotinputval').each(function () {
        $(this).focus(function () {
            hideValidate(this);
        });
    });

    function validate(input) {
        if ($(input).attr('type') == 'email' || $(input).attr('name') == 'email') {
            if ($(input).val().trim().match(/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/) == null) {
                return false;
            }
        }
        else {
            if ($(input).val().trim() == '') {
                return false;
            }
        }
    }

    function showValidate(input) {
        var thisAlert = $(input).parent();

        $(thisAlert).addClass('alert-validate');
    }

    function hideValidate(input) {
        var thisAlert = $(input).parent();

        $(thisAlert).removeClass('alert-validate');
    }

    function forgetPasswordMessage() {
        //clear label message if there is an old message on it
        $('#lblForgetMsg').html(' ');

        var userLog = $('#txtForgetPass').val();
        var parameter = {
            "userLog": userLog
        };

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../Services/Home/Srvc_ForgetPassword.asmx/ForgetPasswordMessage",
            //data: "{}",
            data: JSON.stringify(parameter),
            beforeSend: function () {
                $('#loading').html('<img src="../../Images/GIF/Loader.gif" width="34" height="30" />&nbsp; Please Wait ...');
            },
            dataType: "json",
            success: function (data) {
                var result = jQuery.parseJSON(data.d);
                //debugger;lblForgetMsg
                $('#lblForgetMsg').html(result);
                $('#txtForgetPass').val("");

                $('#loading').html(' ');
            },
            error: function () {
                alert("Error");
            }
        });
    }


})(jQuery);