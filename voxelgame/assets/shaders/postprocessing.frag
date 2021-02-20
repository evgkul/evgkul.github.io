#version 300 es
precision mediump float;
out vec4 FragColor;
  
in vec2 TexCoords;

uniform sampler2D opaque;
uniform sampler2D alpha;

void main()
{ 
    vec4 opaque_val = texture(opaque, TexCoords);
    vec4 alpha_val = texture(alpha, TexCoords);
    FragColor = vec4(mix(opaque_val.xyz,alpha_val.xyz,alpha_val.a),1.0);
}