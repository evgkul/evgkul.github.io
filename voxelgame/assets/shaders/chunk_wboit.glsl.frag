#version 300 es
precision mediump float;
in vec2 vUV;
in vec4 vPosition;
uniform sampler2D tex;
in float mul;
in float depth;
layout(location=0) out vec4 accum;
layout(location=1) out vec4 reveal;

void main(void) {
  vec4 color = texture(tex, vec2(vUV.x, vUV.y), 0.);
  //color.xyz*=mul;
  float alpha = fract(color.a);

  //accum = vec4(0.0,1.0,0.0,0.5);
  /*if (alpha == 1.0) {
    discard;
  }*/
  color.w = fract(color.w);
  float z = vPosition.z;
  z = min(z, -0.5);
  float weight = max(min(1.0, max(max(color.x, color.y), color.z) * color.w), color.w) * clamp(0.02999999932944774627685546875 / (9.9999997473787516355514526367188e-06 + pow(z / 200.0, 4.0)), 0.00999999977648258209228515625, 3000.0);
  accum = vec4(((color.xyz * color.w) * weight) * mul, color.w);
  reveal = vec4(color.w * weight, 0.0, 0.0, 0.0);
}