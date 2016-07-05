#!/bin/bash

#  Created by Rosstin Murphy on 6/19/16.

SOI_NUM_COMMONS=101
SOI_NUM_UNCOMMONS=80

EMN_NUM_COMMONS=12
EMN_NUM_UNCOMMONS=9

ALREADYEXISTS=-1

COMMON_PREFIX="c"
UNCOMMON_PREFIX="u"

EMN_COMMON="/Users/rosstin/mtg/emn/1common/"
EMN_UNCOMMON="/Users/rosstin/mtg/emn/2uncommon/"

SOI_COMMON="/Users/rosstin/mtg/soi/1c/"
SOI_UNCOMMON="/Users/rosstin/mtg/soi/2u/"

JPG=".jpg"
PNG=".png"

ONE="1"
TWO="2"
THREE="3"
FOUR="4"
FIVE="5"
SIX="6"
SLASH="/"

FOIL="/Users/rosstin/mtg/emn/f.jpg"

PACKPATH="/Users/rosstin/mtg/"
PACK1PATH=$PACKPATH$ONE$SLASH
PACK2PATH=$PACKPATH$TWO$SLASH
PACK3PATH=$PACKPATH$THREE$SLASH
PACK4PATH=$PACKPATH$FOUR$SLASH
PACK5PATH=$PACKPATH$FIVE$SLASH
PACK6PATH=$PACKPATH$SIX$SLASH

uncommon[0]=-1
uncommon[1]=-1
uncommon[2]=-1
common[0]=-1
common[1]=-1
common[2]=-1
common[3]=-1
common[4]=-1
common[5]=-1
common[6]=-1
rare[0]=-1
foil[0]=-1
raredfc[0]=-1
dfc[0]=-1

assignrandom()
{
	echo $[RANDOM%$1+1] 
}

uniquerandomcommon()
{
	UNIQUE=0
	while [ $UNIQUE -eq 0 ]
	do
		MYRANDOM=$(assignrandom $1)
		UNIQUE=1
		for var in "${common[@]}"; do
			if [ $MYRANDOM -eq $var ] ; then
				UNIQUE=0
			fi
		done
	done

	echo $MYRANDOM
}

uniquerandomuncommon()
{
	UNIQUE=0
	while [ $UNIQUE -eq 0 ]
	do
		MYRANDOM=$(assignrandom $1)
		UNIQUE=1
		for var in "${uncommon[@]}"; do
			if [ $MYRANDOM -eq $var ] ; then
				UNIQUE=0
			fi
		done
	done

	echo $MYRANDOM
}


rm -rf $PACK1PATH && mkdir $PACK1PATH
rm -rf $PACK2PATH && mkdir $PACK2PATH
rm -rf $PACK3PATH && mkdir $PACK3PATH
rm -rf $PACK4PATH && mkdir $PACK4PATH
rm -rf $PACK5PATH && mkdir $PACK5PATH
rm -rf $PACK6PATH && mkdir $PACK6PATH

generatepack()
{
	COMMON_PATH=$1
	UNCOMMON_PATH=$2

	COMMON_COUNT=$3
	UNCOMMON_COUNT=$4

	PACKNUMBER=$5

	MYDESTINATION=$PACK$PACKNUMBER$SLASH

	# commons
	for i in {0..6}
	do
		MYRAND=$(uniquerandomcommon $COMMON_COUNT)

		common[i]=$MYRAND
		
		MYSOURCE=$COMMON_PATH$COMMON_PREFIX$MYRAND$PNG

		cp $MYSOURCE $MYDESTINATION
	done

	#uncommons
	for i in {0..2}
	do
		MYRAND=$(uniquerandomuncommon $UNCOMMON_COUNT)

		uncommon[i]=$MYRAND
		
		MYSOURCE=$UNCOMMON_PATH$UNCOMMON_PREFIX$MYRAND$PNG

		cp $MYSOURCE $MYDESTINATION
	done

	#foil
	#5/6 chance for 1 common, 1/6 chance random foil
	FOILLOTTERY=$(assignrandom 6)
	if [ $FOILLOTTERY -eq 1 ] ; then
		#make a foil
		cp $FOIL $MYDESTINATION
	else
		#make a common
		MYRANDOM=$(assignrandom $COMMON_COUNT)
		MYSOURCE=$COMMON_PATH$COMMON_PREFIX$MYRANDOM$PNG
		cp $MYSOURCE $MYDESTINATION
	fi

	#rare
	#MYTHICLOTTERY=$(assignrandom 8)
	#if [ $MYTHICLOTTERY -q 1 ] ; then
	#	#make a mythic

	#raredfc

	#dfc
}

# SOI PACKS
for packnumber in {1..6}
do
	generatepack $SOI_COMMON $SOI_UNCOMMON $SOI_NUM_COMMONS $SOI_NUM_UNCOMMONS $packnumber
done




#for file in $(ls | tail -1);
#do
#mv $file "/Users/rosstin/Dropbox (Aqualuft)/twitterpre/"
#done