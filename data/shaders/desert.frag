uniform float u_Time;
uniform sampler2D u_Tex0;
uniform sampler2D u_Tex1;
varying vec2 v_TexCoord;

vec2 direction = vec2(5,5.3);
float speed = 0.11;
float pressure = 0.6;
float zoom = 0.7;

void main(void)
{
    vec2 offset = (v_TexCoord + (direction * u_Time * speed)) / zoom;
    vec3 bgcol = texture2D(u_Tex0, v_TexCoord).xyz;
    vec3 fogcol = texture2D(u_Tex1, offset).xyz;
    vec3 col = bgcol + fogcol*pressure;
    gl_FragColor = vec4(col,1.0);
}
