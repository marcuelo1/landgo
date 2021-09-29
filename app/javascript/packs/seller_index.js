$(document).ready(function(){
    body = $("#seller-index")

    $(body).on('click', "#create-seller", function(){
        url = $(this).attr("url")
        $.ajax({
            url: url,
            dataType: "script",
            data: {},
            success: function(response){}
        });
    });

    $(body).on('click', '.image-container', function(){
        image_url = $(this).find("img").attr("src");
        $(body).prepend(expandImage(image_url));
    });
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