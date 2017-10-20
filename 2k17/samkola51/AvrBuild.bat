@ECHO OFF
"C:\Program Files\Atmel\AVR Tools\AvrAssembler2\avrasm2.exe" -S "D:\AVR Studio\2k17\samkola51\labels.tmp" -fI -W+ie -C V2E -o "D:\AVR Studio\2k17\samkola51\hello_world.hex" -d "D:\AVR Studio\2k17\samkola51\hello_world.obj" -e "D:\AVR Studio\2k17\samkola51\hello_world.eep" -m "D:\AVR Studio\2k17\samkola51\hello_world.map" "D:\AVR Studio\2k17\samkola51\hello_world.asm"
