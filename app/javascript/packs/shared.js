$(document).ready(function(){

    $("body").on('click', '.new-btn', function(){
        url = $(this).attr("url")
        $.ajax({
            url: url,
            dataType: "script",
            data: {},
            success: function(response){}
        });
    })

    $("body").on('click', '.edit-btn', function(){
        url = $(this).attr("url")
        $.ajax({
            url: url,
            dataType: "script",
            data: {},
            success: function(response){}
        });
    })

    $("body").on('click', '.modal-bg', function(){
        $(this).remove();
        $('.modal-content').remove();
    })
});