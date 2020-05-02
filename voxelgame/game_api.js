/**
 * 
 * @param {*} g 
 * @param {OffscreenCanvas|HTMLCanvasElement} canvas 
 * @param {bool} isTransfer
 */
function addGameApi(g,canvas,isTransfer){
    /** @type {OffscreenCanvas} */
    let offscreen;
    /** @type {WebGL2RenderingContext} */
    let context;
    /** @type {ImageBitmapRenderingContext} */
    let bitmapContext;
    if(isTransfer){
        offscreen = new OffscreenCanvas(canvas.width,canvas.height);
        context = offscreen.getContext('webgl2');
        bitmapContext = canvas.getContext('bitmaprenderer');
    }
}