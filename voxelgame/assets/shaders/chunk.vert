#version 300 es
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec2 aTexCoord;
layout (location = 2) in vec4 aLightLevel;

out vec2 TexCoord;
out vec3 lightlevel;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform float skylight_dec;

void main()
{
	lightlevel = max(aLightLevel.rgb,vec3(aLightLevel.a-skylight_dec))*0.9+0.1;//max(aLightLevel.r,aLightLevel.a-skylight_dec)*0.9+0.1;
	gl_Position = projection * view * model * vec4(aPos, 1.0f);
	TexCoord = vec2(aTexCoord.x, aTexCoord.y);
}