@ECHO OFF
"C:\Program Files\Atmel\AVR Tools\AvrAssembler2\avrasm2.exe" -S "D:\AVR Studio\2k17\password\labels.tmp" -fI -W+ie -C V2E -o "D:\AVR Studio\2k17\password\password.hex" -d "D:\AVR Studio\2k17\password\password.obj" -e "D:\AVR Studio\2k17\password\password.eep" -m "D:\AVR Studio\2k17\password\password.map" "D:\AVR Studio\2k17\password\password.asm"
