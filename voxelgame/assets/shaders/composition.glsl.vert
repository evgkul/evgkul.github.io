#version 300 es
precision highp float;

in vec4 position;
in vec2 texcoord;
out vec2 pos;

void main(void) {
        
        gl_Position = position;
        pos = texcoord;
}
