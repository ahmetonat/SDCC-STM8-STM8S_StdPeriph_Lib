/********************************************************************
 * Copyright 2017 Ahmet Onat
 * This program is distributed under the terms of the 
 * GNU General Public License
 *
 * This file is part of SDCC_StmPeriphLib
 *
 * SDCC_StmPeriphLib is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Barometer52 is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with SDCC_StmPeriphLib.  If not, see <http://www.gnu.org/licenses/>.
 *
 *********************************************************************/


#include "stm8s.h"
#include "stm8s_gpio.h"

#define LED_PORT  GPIOB
#define LED_PIN   GPIO_PIN_5

#define DELAYTIME 0xF000
void delay (uint16_t count);

void main(void)
{

  GPIO_Init(LED_PORT, LED_PIN, GPIO_MODE_OUT_PP_LOW_FAST);

  while (1){
    GPIO_WriteReverse(LED_PORT, LED_PIN);
    delay(DELAYTIME);
  }
}

void delay(uint16_t count)
{
  while (count != 0){
    count--;
  }
}
