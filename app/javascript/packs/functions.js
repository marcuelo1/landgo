function expandImage(image_url) {
    return `
        <div class="modal-bg">
        </div>
        <div class="modal-content">
            <img src="${image_url}" class="expanded-image">
        </div>
    `;
}

$("body").on('click', '.modal-bg', function(){
    $(this).remove();
    $('.modal-content').remove();
})