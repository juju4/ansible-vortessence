#!/bin/sh
## http://vortessence.org/usage/
## ex: time python ~/Toolset/vortessence/vortessence/vort.py -a preprocess --profile WinXPSP2x86 -f ~/Toolset/sample/xp-infected.bin

profile=$1
memoryimage=$2
memoryimageafter=$3
vol=vol.py
vdir=$HOME/Toolset/vortessence/vortessence
vupload=/cases/vortessence_upload

[ -z "$memoryimage" -o ! -r "$memoryimage" ] && echo "Incorrect input: not a readable memory image file" && exit 1
[ -z "$profile" ] && echo "Missing memory profile. Check /usr/lib/python2.7/dist-packages/volatility/plugins/overlays"

set -x
export VOLATILITY_LOCATION=$memoryimage
#$vol imageinfo

## if Linux/lmg capture, can set
#export VOLATILITY_PLUGINS=/mnt/usb/capture/caribou-2014-03-29_12.06.01
export VOLATILITY_PLUGINS=/vagrant/aptcache-incidentreport/capture/aptcache-2015-10-06_22.28.55
export VOLATILITY_PROFILE=$profile
#vol --info |grep 'A Profile for'
echo $VOLATILITY_PLUGINS / $VOLATILITY_LOCATION / $VOLATILITY_PROFILE
#vol linux_pslist
#OR
#VOLATILITY_PLUGINS=/vagrant/aptcache-incidentreport/capture/aptcache-2015-10-06_22.28.55 vol -f /vagrant/aptcache-incidentreport/capture/aptcache-2015-10-06_22.28.55/aptcache-2015-10-06_22.28.55-memory.lime --profile Linuxaptcache-2015-10-06_22_28_55-profilex64 linux_pslist

# install profile?
#sudo install -m 644 $profilefile /usr/lib/python2.7/dist-packages/volatility/plugins/overlays/#system#

## Step 1: Uploading memory image
#rsync -a $memoryimage $vupload/

## Step 2: Pre-processing memory images.
## for each image, ~180 extracts, ~300-500 searches
time python $vdir/vort.py -a preprocess --profile $VOLATILITY_PROFILE -f $memoryimage | tee $memoryimage.vortimport.log
time python $vdir/vort.py -a preprocess --profile $VOLATILITY_PROFILE -f $memoryimageafter [ tee $memoryimageafter.vort.log
python $vdir/vort.py -l

## Step 3: Whitelisting or anomaly detection
#python vort.py -a whitelist -s <IMAGE_ID>

# To detect anomalies in preprocessed image:
#python vort.py -a detect -s <IMAGE_ID>

## Step 4: Viewing detection results (w webserver)
#python $vdir/vortessence_web/manage.py runserver and browse http://127.0.0.1:8000


unset VOLATILITY_LOCATION VOLATILITY_PLUGINS VOLATILITY_PROFILE

# Database to backup/restore? vortessence, mysql-save.sh

## from cli
# python $vdir/vort.py -l -a output -s 3
# python $vdir/vort.py -a output -s <IMAGE_ID> [--plugin <volatility_plugin_name>] [-p PID]

