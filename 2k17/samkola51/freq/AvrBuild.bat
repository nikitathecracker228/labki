@ECHO OFF
"C:\Program Files\Atmel\AVR Tools\AvrAssembler2\avrasm2.exe" -S "D:\AVR Studio\2k17\samkola51\freq\labels.tmp" -fI -W+ie -C V2E -o "D:\AVR Studio\2k17\samkola51\freq\freq.hex" -d "D:\AVR Studio\2k17\samkola51\freq\freq.obj" -e "D:\AVR Studio\2k17\samkola51\freq\freq.eep" -m "D:\AVR Studio\2k17\samkola51\freq\freq.map" "D:\AVR Studio\2k17\samkola51\freq\freq.asm"
