draw_set_font(myFont);
draw_set_halign(myHa);
draw_set_valign(myVa);
draw_set_alpha(min(1.0, (3/2)*shadow_alpha*(lifeTime/lifeTime_full)));
draw_set_color(shadow_color);
draw_text(x + shadow_offset.x, y + shadow_offset.y, myMessage);
draw_set_alpha(min(1.0, (3/2)*(lifeTime/lifeTime_full)));
draw_set_color(myColor);
draw_text(x, y, myMessage);
mWidth = string_width(myMessage);
mHeight = string_height(myMessage);