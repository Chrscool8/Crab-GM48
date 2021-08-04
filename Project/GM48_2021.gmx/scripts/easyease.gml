if (argument0 < .5)
    return 8 * argument0 * argument0 * argument0 * argument0;
else
    return 1 - power(-2 * argument0 + 2, 4) / 2;
