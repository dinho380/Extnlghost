uniform float u_Time;
uniform sampler2D u_Tex0;
uniform sampler2D u_Tex1;
varying vec2 v_TexCoord;

vec2 direction = vec2(-3.0,5);
float speed = 0.06;
float pressure = 0.7;
float zoom = 0.3;

void main()
{
    vec4 col = texture2D(u_Tex0, v_TexCoord);
    vec2 offset = (v_TexCoord + (direction * u_Time * speed)) / zoom;
    col.x += (1.0 + sin(d))*0.25;
    col.y += (1.0 + sin(d*2.0))*0.25;
    col.z += (1.0 + sin(d*4.0))*0.25;
    gl_FragColor = col;
}