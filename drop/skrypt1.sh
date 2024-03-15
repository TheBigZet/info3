#!/bin/bash

#Kopiowanie wszystkiego do nowego folderu żeby nie popsuć orginałów
rm -r temp
mkdir temp
cp drop-00*.jpg ./temp/ 
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
#Piąta kropka
mkdir text
files=$(ls *.jpg | head -1) #alleluja zajęło mi to 20 minut
echo $files
size_x=$(stat -c %y "${files}")
echo $size_x
for i in *.jpg
do
	convert $i -pointsize 12 -draw "text 500,30 'TEKST'" text/$i
	convert text/$i -fill white -draw "rectangle 0,0 200,50" text/$i
	
	convert text/$i -draw "text 20,15 'Aktualna data:'" text/$i
	convert text/$i -draw "text 20,35 '$(date)'" text/$i
	#convert $i -border 20x20 -pointsize 2 -draw "text 0, 0 '$aktualna_data'" $i
done
echo "Done 5)"





