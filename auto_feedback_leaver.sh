#!/bin/bash
#
# Automatically leaves feedback for sold transactions

EBAY_USER=
FEEDBACK="\"Great Buyer, Fast Payment, Thanks! A+++++\""

for item in `/usr/bin/perl /home/mike/code/ebay/ebay-get-my-sold.pl $EBAY_USER --sold | /bin/grep ItemID | /usr/bin/awk '{print $3;}' | /usr/bin/perl -pe "s/'(\d+)',?/\1/g" | /usr/bin/sort | /usr/bin/uniq` ;
do
	if /bin/grep -Fxq "$item" /home/mike/code/ebay/item_log
	then
		/bin/echo "$item already left feedback for this item"
	else
		/home/mike/code/ebay/ebay-leave-feedback.pl $item $FEEDBACK
		/bin/echo $item >> /home/mike/code/ebay/item_log
	fi
done
