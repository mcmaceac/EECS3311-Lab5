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

mytictac.exe -b at6.txt > at6.actual.txt
tictac.exe -b at6.txt > at6.expected.txt
diff at6.actual.txt at6.expected.txt

mytictac.exe -b at7.txt > at7.actual.txt
tictac.exe -b at7.txt > at7.expected.txt
diff at7.actual.txt at7.expected.txt

mytictac.exe -b at8.txt > at8.actual.txt
tictac.exe -b at8.txt > at8.expected.txt
diff at8.actual.txt at8.expected.txt


