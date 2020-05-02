#version 300 es
precision highp float;

out vec4 color;
in vec2 pos;
uniform sampler2D tex;
uniform sampler2D accum;
uniform sampler2D reveal;
void main(void) {
  vec4 o = texture(tex,pos);
  vec4 accum = texture(accum,pos);
  float ta = accum.a;
  vec4 rdata = texture(reveal,pos);
  float a = 1.0 - accum.w;
  accum.w = rdata.x;
  vec4 wboit = vec4((accum.xyz * a) / vec3(clamp(accum.w, 0.001000000047497451305389404296875, 50000.0)), a);
  
  //vec4 wboit = a;
  //color = vec4(wboit.rgb*(1.0-wboit.a)+o.rgb*(wboit.a),1.0);
  //color = wboit;
  //color = vec4(ta,0.0,0.0,1.0);
  vec3 c = o.rgb*(1.0-a)+wboit.rgb*a;
  color = vec4(c,1.0);

}