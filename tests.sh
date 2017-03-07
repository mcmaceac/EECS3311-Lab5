#!/bin/bash
mytictac.exe -b at1.txt > at1.actual.txt
tictac.exe -b at1.txt > at1.expected.txt
diff at1.actual.txt at1.expected.txt

mytictac.exe -b at2.txt > at2.actual.txt
tictac.exe -b at2.txt > at2.expected.txt
diff at2.actual.txt at2.expected.txt

mytictac.exe -b at3.txt > at3.actual.txt
tictac.exe -b at3.txt > at3.expected.txt
diff at3.actual.txt at3.expected.txt

mytictac.exe -b at4.txt > at4.actual.txt
tictac.exe -b at4.txt > at4.expected.txt
diff at4.actual.txt at4.expected.txt

mytictac.exe -b at5.txt > at5.actual.txt
tictac.exe -b at5.txt > at5.expected.txt
diff at5.actual.txt at5.expected.txt
