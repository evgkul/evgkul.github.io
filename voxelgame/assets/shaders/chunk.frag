#version 300 es
precision mediump float;

out vec4 FragColor;

in vec2 TexCoord;
in vec3 lightlevel;

// texture samplers
uniform sampler2D tex;
//uniform sampler2D tex2;

void main()
{
	// linearly interpolate between both textures (80% container, 20% awesomeface)
	//FragColor = mix(texture(tex, TexCoord), texture(tex2, TexCoord), 0.2);
	FragColor = vec4(texture(tex,TexCoord).xyz*lightlevel,1.0);
}