$(document).ready(function(){
    body = $("#admin-index")

    $(body).on('click', '.refind-avail-rider-btn', function(){
        checkout_seller_id = $(this).attr('cs_id')

        $.ajax({
            url: "/admin/refind_available_rider",
            method: 'POST',
            data: {checkout_seller_id: checkout_seller_id},
            success: function(response){
                console.log(response)
            }
        });
    })
})