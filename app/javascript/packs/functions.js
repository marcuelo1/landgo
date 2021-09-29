export function expandImage(image_url) {
    return `
        <div class="modal-bg">
        </div>
        <div class="modal-content">
            <img src="${image_url}" class="expanded-image">
        </div>
    `;
}