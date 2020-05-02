#version 300 es
precision mediump float;
in vec2 vUV;
uniform sampler2D tex;
in vec3 opos;
in float mul;
out vec4 color;

void main(void) {
  color = texture(tex, vec2(vUV.x, vUV.y), 0.);
  if (color.a < 1.0) {
    discard;
  }
  color.xyz *= mul;
  //color.w = 1.;
  //color = vec4(1.0,0.0,0.0,1.0);
  //color = vec4(vUV.xy,0.0,1.0);
}