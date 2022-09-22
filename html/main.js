var success = $("#success-sound")[0];
console.log(success);
var wrong = $("#wrong-sound")[0];
console.log(wrong);

// CONFIG TEXT




window.addEventListener('message', function(event) {
    var item = event.data;

    if (item.showUI) {
        $('body').fadeIn(200);
    } else {
        $('body').fadeOut(200);
    }
    $(".welcome-name").html(data.firstname + " " + data.lastname);
    if (item.playerName) {
        createPlayers()
    }

});

$(".on-duty").click(function(e2) {
    success.play();
    $.post('https://zort-duty/Mesaigir', JSON.stringify({}));
});
$(".off-duty").click(function(e1) {
    wrong.play();
    $.post('https://zort-duty/Mesaicik', JSON.stringify({}));
});

$(".close").click(function(e) {
    $.post('https://zort-duty/close', JSON.stringify({}));

});

const createPlayers = function(filter) {
    $.post("https://zort-duty/lod:RequestPlayers", JSON.stringify({}), function(result) {
        if (result) {
            console.log(`${result.firstname} ${result.lastname}`)
            $('.welcome-name').text(`${result.firstname} ${result.lastname}`)
        }
    })
}


$(document).ready(function() {
    $.post('https://zort-duty/lod:loaded', JSON.stringify({}));
});
