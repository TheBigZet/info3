#!/bin/bash

#Kopiowanie wszystkiego do nowego folderu żeby nie popsuć orginałów
rm -r temp
mkdir temp
cp drop-*.jpg ./temp/ 
cd temp

#Pierwsza kropka
for i in *.jpg
do
	convert $i -resize 90% $i
done
echo "Done 1)"

#Druga kropka
mkdir temp2
aktualna_data=date
for i in *.jpg
do	
	convert $i -resize 10% ./temp2/$i
done
echo "Done 2)"

#Czwarta kropka
mkdir gify
for i in *.jpg
do
	bez_rozszerzenia=${i%.*}
	convert $i gify/$bez_rozszerzenia.gif 
done
echo "Done 4)"

#Piąta szósta i siódma kropka
mkdir text
#Odczytanie nazwy pierwszego, niezmodyfikowanego pliku
file=$(ls ../*.jpg | head -1) #alleluja zajęło mi to 20 minut
echo $file
#Odczytanie daty utworzenia pliku
data_utworzenia=$(stat -c %y "${file}")
echo $data_utworzenia
#Odczywanie rozmiaru x zdjęcia
file=$(ls *.jpg | head -1) #tym razem z katalogu temp, b0 zdjęcia są pomniejszone względem orginału
res_x=$(identify -format '%w' "${file}")
echo $res_x
for i in *.jpg
do
	convert $i -pointsize 12 -draw "text 350,80 'TEKST'" \
	-fill white -draw "rectangle 0,0 200,50" \
	-fill black -draw "text 20,15 'Aktualna data:'" \
	-draw "text 20,35 '$(date)'" \
	-fill white -draw "rectangle $((res_x-200)),0 $((res_x)),50" \
	-fill black -draw "text $((res_x-180)),15 'Data utworzenia:'" \
	-draw "text $((res_x-180)),35 '${data_utworzenia}'" text/$i

done
echo "Done 5) 6) 7)"

convert text/*.jpg animacja.gif
echo "Done 8)"



