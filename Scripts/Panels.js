function getUrlVars() {
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < hashes.length; i++) {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars;
}

$(function () {

    var forget = getUrlVars()["for"];
    if (forget == 1) {
        $("#tabs-2").show();
        $("#tabs-2").addClass('active');
    } else {
        $("#tabs-1").show();
        $("#tabs-1").addClass('active');
    }

    //$("#tabs-1").show();
    //$("#tabs-1").addClass('active');

    $('a.panel1').click(function () {

        var $target = $($(this).attr('href')),
            $other = $target.siblings('.active'),
            animIn = function () {
                $target.addClass('active').show().css({
                    left: -($target.width())
                }).animate({
                    left: 0
                }, 500);
            };

        if (!$target.hasClass('active') && $other.length > 0) {
            $other.each(function (index, self) {
                var $this = $(this);
                $this.removeClass('active').animate({
                    left: -$this.width()
                }, 500, animIn);
            });
        } else if (!$target.hasClass('active')) {
            animIn();
        }
    });
});