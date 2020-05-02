#version 300 es
precision mediump float;
out vec2 vUV;
out vec4 vPosition;
in vec3 position;
in vec2 uv;
out vec3 opos;
out float mul;
uniform mat4 tmat;

float xParam;
float yParam;

void main(void) {
        opos = position;
        vUV = uv;
        xParam = floor(vUV.x * 0.5) - 1.;
        yParam = floor(vUV.y * 0.5);
        mul = (xParam + 3.) / 18.;
        /*mat4 tmat = mat4(
                -1.357995, 0.0, 0.0, 0.0,
                0.0, 2.4142134, 0.0, 0.0,
                0.0, 0.0, 1.0001953, 1.0,
                2.8517895, -4.5870056, -1.3002343, -1.1);*/
        gl_Position = vPosition = tmat * vec4(position, 1.);
}
