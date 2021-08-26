$(document).ready(function(){
    $("#create-seller ").on('click', function(){
        url = $(this).attr("url")
        $.ajax({
            url: url,
            dataType: "script",
            data: {},
            success: function(response){}
        });
    });

    $('.image-container').on('click', function(){
        image_url = $(this).find("img").attr("src");
        $("body").prepend(expandImage(image_url));
    });

    $("body").on('click', '.modal-bg', function(){
        $(this).remove();
        $('.modal-content').remove();
    })
});

function expandImage(image_url) {
    return `
        <div class="modal-bg">
        </div>
        <div class="modal-content">
            <img src="${image_url}" class="expanded-image">
        </div>
    `;
}