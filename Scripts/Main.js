
$(function () {
    //Remove the style attributes.
    //$(".navbar-nav li, .navbar-nav a, .navbar-nav ul").removeAttr('style');

    //Apply the Bootstrap class to the SubMenu.
    $(".dropdown-menu").closest("li").removeClass().addClass("dropdown-toggle");

    //Apply the Bootstrap properties to the SubMenu.
    $(".dropdown-toggle").find("a.level1").attr("data-toggle", "dropdown").attr("aria-haspopup", "true").attr("aria-expanded", "false").append(" <span class='caret'></span>");

    $(".dropdown-toggle").find("a.level1").removeAttr("onclick");
    $(".dropdown-toggle").find("a.level2").removeAttr("onclick");
    $(".dropdown-toggle").find("a.level3").removeAttr("onclick");
    $(".dropdown-toggle").find("a.level4").removeAttr("onclick");
    $(".dropdown-toggle").find("a.level5").removeAttr("onclick");
    $(".dropdown-toggle").find("a.level6").removeAttr("onclick");
    $(".dropdown-toggle").find("a.level7").removeAttr("onclick");
    $(".dropdown-toggle").find("a.level8").removeAttr("onclick");
    $(".dropdown-toggle").find("a.level9").removeAttr("onclick");
    $(".dropdown-toggle").find("a.level10").removeAttr("onclick");

    $(".static").find("a.level1").removeAttr("onclick");
    $(".dropdown-toggle").find("a.level1").css("pointer-events", "none", "cursor", "default");

    //This to remove event from all popout links
    $(".dynamic").find("popout").removeAttr("onclick");
    $(".dropdown-toggle").find("a.popout").css("pointer-events", "none", "cursor", "default");


    $(".dropdown-toggle").find(".dropdown-toggle").addClass("dropdown-submenu");

    //popout level2 dynamic

    //Apply the Bootstrap "active" class to the selected Menu item.
    //$("a.selected").closest("li").addClass("active");
    //$("a.selected").closest(".dropdown-toggle").addClass("active");

    function Scroll() {
        //we stop nice scroll for the content becuase telerik affected on it
        //$("#Content").niceScroll({ cursorcolor: "#000" });
        //$('body').niceScroll({ cursorcolor: "#000" });
    }

    Scroll();

    $("#Expand").click(function () {
        if ($('.aside-2').hasClass('Expanded')) {

            $('.aside-2').removeClass('Expanded');
            $('.aside-2').animate(
                { width: '0%' },
                500,
                function () {
                    // Animation complete.
                    $("#Content").css("width", "88%");
                });
        } else {

            $('.aside-2').addClass('Expanded');
            $("#Content").css("width", "79%");

            $('.aside-2').animate(
                { width: '10%' },
                500,
                function () {
                    // Animation complete.

                });
        }
    });

});