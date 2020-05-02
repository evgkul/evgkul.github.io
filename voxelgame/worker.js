console.log('Hello from worker!', requestAnimationFrame);
self.onmessage = function(e){
    console.log("TEST!");
    let data = e.data;
    /** @type {OffscreenCanvas} */
    let transferred = data.canvas;
    let bitmap_target = transferred.getContext('bitmaprenderer');
    let offscreen = new OffscreenCanvas(transferred.width,transferred.height);
    let cont = offscreen.getContext('webgl2');
    let events = [];
    self.onmessage = function(e){
        let data = e.data;
        if(data.type=='event'){
            events.push(data.event);
        }
    }
    self.getSize = function(){
        return {
            w: Math.ceil(offscreen.width),
            h: Math.ceil(offscreen.height)
        };
    }
    self.print_log = function(msg){
        console.log("RUST: ",msg);
    }
    self.get_context = function(){
        return cont;
    }
    self.render_loop = function(f){
        function l(delta){
            f(events);
            //console.log('STEP');
            var bitmap = offscreen.transferToImageBitmap();
            bitmap_target.transferFromImageBitmap(bitmap);
            events = [];
            requestAnimationFrame(l);
        }
        requestAnimationFrame(l);
    }
    self.get_asset = function(store,path){
        let res = fetch("assets/"+path).then(response=>response.arrayBuffer());
        return res;
    }
    importScripts("rust_voxelgame.js");

}