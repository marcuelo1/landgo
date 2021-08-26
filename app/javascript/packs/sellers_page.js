$(document).ready(function(){
    $("body").on('click', '#details', function(){
        $("#seller-details").css('display', 'block')
        $("#seller-products").css('display', 'none')
    })
    
    $("body").on('click', '#products', function(){
        $("#seller-details").css('display', 'none')
        $("#seller-products").css('display', 'block')
    })

    $("body").on('change', '.product-size', function(){
        price = $(this).val()
        $(this).parent().parent().find('.product-price').text(price)
    })

    $('body').on('click', '#add-product', function(){
        url = $(this).attr("url")
        $.ajax({
            url: url,
            dataType: "script",
            data: {},
            success: function(response){}
        });
    })

    $('.product-image').on('click', function(){
        image_url = $(this).find("img").attr("src");
        $("body").prepend(expandImage(image_url));
    });

    $("body").on('click', '.modal-bg', function(){
        $(this).remove();
        $('.modal-content').remove();
    })

    $("body").on('click', '#add-size', function(){
        count =  $("#input-sizes-container").find("li").length
        optionsRaw = $("#input-sizes-container").data("options")
        options = ""

        optionsRaw.forEach(opt => {
            options += `
                <option value="${opt[0]}">${opt[1]}</option>
            `
        });

        $("#input-sizes-container").append(`
            <li class="input-size">
                <div class="number">
                    <i class="icon-remove size-remove"></i>
                    <div class="val">${count + 1}</div>
                </div>
                <select class="form-select" name="product_size_ids[]" id="">
                    ${options}
                </select>
                <input class="form-control" placeholder="Price" type="text" name="prices[]" id="">
            </li>
        `)
    })

    $('body').on('click', '.size-remove', function(){
        $(this).parent().parent().remove()
        count = 1
        $("#input-sizes-container").find("li").each(function(){
            $(this).find(".val").text(count)
            count++
        })
    })

    $("body").on("click", "#add-add-ons", function(){
        count =  $("#input-addons-container").find("li").length
        optionsRaw = $("#input-addons-container").data("options")
        options = ""

        optionsRaw.forEach(opt => {
            options += `
                <option value="${opt[0]}">${opt[1]}</option>
            `
        });

        $("#input-addons-container").append(`
            <li class="input-addon" id="first-adddon">
                <div class="number">
                    <i class="icon-remove addon-remove"></i>
                    <div class="val">${count + 1}</div>
                </div>
                <select class="form-select" name="add_on_group_ids[]" id="add_on_group_ids[]">
                    ${options}
                </select>
            </li>
        `)
    })

    $('body').on('click', '.addon-remove', function(){
        $(this).parent().parent().remove()
        count = 1
        $("#input-addons-container").find("li").each(function(){
            $(this).find(".val").text(count)
            count++
        })
    })
})

function expandImage(image_url) {
    return `
        <div class="modal-bg">
        </div>
        <div class="modal-content">
            <img src="${image_url}" class="expanded-image">
        </div>
    `;
}