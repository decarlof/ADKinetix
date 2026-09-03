
#!/bin/bash

#echo
#echo "# arguments called with ---->  ${@}     "
#echo "# \$1 ---------------------->  $1       "
#echo "# \$2 ---------------------->  $2       "
#echo "# \$3 ---------------------->  $3       "
#echo "# \$4 ---------------------->  $4       "
#echo "# path to me --------------->  ${0}     "
#echo "# parent path -------------->  ${0%/*}  "
#echo "# my name ------------------>  ${0##*/} "
#echo


#if [ "$1" == "medm" ]; then 
#  ${0%/*}/start_medm  $2 &
#export WHATAMI=MEDM
#fi

#if [ "$1" == "caqtdm" ]; then
#  ${0%/*}/start_caqtdm $2 &
#export WHATAMI=CAQTDM
#fi


export XXX="$2"
export STARTUP="$3"
export TYPE="$4"

#echo "${XXX}"
#echo "${STARTUP}"
#echo "${TYPE}"

function parse_header() {

input="$1/envPaths"

while IFS=',' read -r f1 f2
do
f1=${f1#"epicsEnvSet("}
f1=${f1:1:-1}

f2=${f2%")"}
f2=${f2:1:-1}

#echo "$f1=$f2" 
f3="$f1=$f2" 

export $f3
#echo $f3

done < "$input"
}

function parse_medm_paths()
{

# must be first since User/beamlines override go here so that they get found first

if [ -n "$TOP" ];           then EDP=${TOP}/op/adl; fi

#actually defined Area Detectors or plugins are tested for here

if [ -n "$ADARAVIS" ];      then EDP=$EDP:${ADARAVIS}/aravisApp/op/adl; fi
if [ -n "$ADCORE" ];        then EDP=$EDP:${ADCORE}/ADApp/op/adl; fi
if [ -n "$ADGENICAM" ];     then EDP=$EDP:${ADGENICAM}/GenICamApp/op/adl; fi
if [ -n "$ADPIXIRAD" ];     then EDP=$EDP:${ADPIXIRAD}/pixiradApp/op/adl; fi
if [ -n "$ADPOINTGREY" ];   then EDP=$EDP:${ADPOINTGREY}/pointGreyApp/op/adl; fi
if [ -n "$ADPROSILICA" ];   then EDP=$EDP:${ADPROSILICA}/prosilicaApp/op/adl; fi
if [ -n "$ADSPINNAKER" ];   then EDP=$EDP:${ADSPINNAKER}/spinnakerApp/op/adl; fi
if [ -n "$ADSIMDETECTOR" ]; then EDP=$EDP:${ADSIMDETECTOR}/simDetectorApp/op/adl; fi
if [ -n "$ADURL" ];         then EDP=$EDP:${ADURL}/urlApp/op/adl; fi
if [ -n "$ADVIMBA" ];       then EDP=$EDP:${ADVIMBA}/vimbaApp/op/adl; fi

if [ -n "$ADMAR345" ];       then EDP=$EDP:${ADMAR345}/mar345App/op/adl; fi
if [ -n "$ADPILATUS" ];      then EDP=$EDP:${ADPILATUS}/pilatusApp/op/adl; fi
if [ -n "$ADEIGER" ];        then EDP=$EDP:${ADEIGER}/eigerApp/op/adl; fi
if [ -n "$PVADRIVER" ];      then EDP=$EDP:${PVADRIVER}/pvaDriverApp/op/adl; fi
if [ -n "$ADPVCAM" ];        then EDP=$EDP:${ADPVCAM}/pvcamApp/op/adl; fi
if [ -n "$ADKINETIX" ];      then EDP=$EDP:${ADKINETIX}/kinetixApp/op/adl; fi

if [ -n "$FFMPEGSERVER" ];   then EDP=$EDP:${FFMPEGSERVER}/ffmpegServerApp/op/adl; fi
if [ -n "$ADCOMPVISION" ];   then EDP=$EDP:${ADCOMPVISION}/adcvApp/op/adl; fi
if [ -n "$ADPLUGINEDGE" ];   then EDP=$EDP:${ADPLUGINEDGE}/edgeApp/op/adl; fi
if [ -n "$ADEDFPLUGIN" ];    then EDP=$EDP:${ADEDFPLUGIN}/EDFApp/op/adl; fi
if [ -n "$ADPLUGINBAR" ];    then EDP=$EDP:${ADPLUGINBAR}/barApp/op/adl; fi

if [ -n "$XSPRESS3" ];       then EDP=$EDP:${XSPRESS3}/xspress3App/opi/adl; fi


# commonly used synApps module screen are tested for here 

if [ -n "$ASYN" ];          then EDP=$EDP:${ASYN}/opi/medm; fi
if [ -n "$ALIVE" ];         then EDP=$EDP:${ALIVE}/aliveApp/op/adl; fi
if [ -n "$AUTOSAVE" ];      then EDP=$EDP:${AUTOSAVE}/asApp/op/adl; fi
if [ -n "$BUSY" ];          then EDP=$EDP:${BUSY}/busyApp/op/adl; fi
if [ -n "$CALC" ];          then EDP=$EDP:${CALC}/calcApp/op/adl; fi
if [ -n "$DEVIOCSTATS" ];   then EDP=$EDP:${DEVIOCSTATS}/op/adl; fi
if [ -n "$LUA" ];           then EDP=$EDP:${LUA}/luaApp/op/adl; fi
if [ -n "$SSCAN" ];         then EDP=$EDP:${SSCAN}/sscanApp/op/adl; fi

# there should be an XXX , but if it exists changeprefix trashes it.


#Export 
f4="EPICS_DISPLAY_PATH=$EDP"

#echo $f4
export $f4

#CAQTDM can also parse adl files if all the paths can be found using its conventions

#f5="CAQTDM_DISPLAY_PATH=$EDP"

#echo $f5
#export $f5


}

function parse_caqtdm_paths()
{

# must be first since User/beamlines override go here so that they get found first

if [ -n "$TOP" ];           then EDP=${TOP}/op/ui:${TOP}/op/ui/autoconvert; fi

#actually defined Area Detectors or plugins are tested for here

if [ -n "$ADARAVIS" ];      then EDP=$EDP:${ADARAVIS}/aravisApp/op/ui/autoconvert; fi
if [ -n "$ADCORE" ];        then EDP=$EDP:${ADCORE}/ADApp/op/ui/autoconvert:${ADCORE}/ADApp/op/ui/; fi
if [ -n "$ADGENICAM" ];     then EDP=$EDP:${ADGENICAM}/GenICamApp/op/ui/autoconvert; fi

if [ -n "$ADPOINTGREY" ];   then EDP=$EDP:${ADPOINTGREY}/pointGreyApp/op/ui/autoconvert; fi
if [ -n "$ADPROSILICA" ];   then EDP=$EDP:${ADPROSILICA}/prosilicaApp/op/ui/autoconvert; fi
if [ -n "$ADSPINNAKER" ];   then EDP=$EDP:${ADSPINNAKER}/spinnakerApp/op/ui/autoconvert; fi
if [ -n "$ADSIMDETECTOR" ]; then EDP=$EDP:${ADSIMDETECTOR}/simDetectorApp/op/ui/autoconvert; fi
if [ -n "$ADURL" ];         then EDP=$EDP:${ADURL}/urlApp/op/ui/autoconvert; fi
if [ -n "$ADVIMBA" ];       then EDP=$EDP:${ADVIMBA}/vimbaApp/op/ui/autoconvert; fi
if [ -n "$ADPIXIRAD" ];     then EDP=$EDP:${ADPIXIRAD}/pixiradApp/op/ui/autoconvert; fi
if [ -n "$ADMAR345" ];      then EDP=$EDP:${ADMAR345}/mar345App/op/ui/autoconvert; fi
if [ -n "$ADPILATUS" ];     then EDP=$EDP:${ADPILATUS}/pilatusApp/op/ui/autoconvert; fi
if [ -n "$ADEIGER" ];       then EDP=$EDP:${ADEIGER}/eigerApp/op/ui/autoconvert; fi
if [ -n "$PVADRIVER" ];     then EDP=$EDP:${PVADRIVER}/pvaDriverApp/op/ui/autoconvert; fi
if [ -n "$ADPVCAM" ];       then EDP=$EDP:${ADPVCAM}/pvcamApp/op/ui/autoconvert; fi
if [ -n "$ADKINETIX" ];     then EDP=$EDP:${ADKINETIX}/kinetixApp/op/ui/autoconvert; fi

if [ -n "$FFMPEGSERVER" ];  then EDP=$EDP:${FFMPEGSERVER}/ffmpegServerApp/op/ui/autoconvert; fi
if [ -n "$ADCOMPVISION" ];  then EDP=$EDP:${ADCOMPVISION}/adcvApp/op/ui/autoconvert; fi
if [ -n "$ADPLUGINEDGE" ];  then EDP=$EDP:${ADPLUGINEDGE}/edgeApp/op/ui/autoconvert; fi
if [ -n "$ADEDFPLUGIN" ];   then EDP=$EDP:${ADEDFPLUGIN}/EDFApp/op/ui/autoconvert; fi
if [ -n "$ADPLUGINBAR" ];   then EDP=$EDP:${ADPLUGINBAR}/barApp/op/ui/autoconvert; fi

if [ -n "$XSPRESS3" ];       then EDP=$EDP:${XSPRESS3}/xspress3App/opi/ui; fi


# commonly used synApps module screen are tested for here 

if [ -n "$ASYN" ];          then EDP=$EDP:${ASYN}/opi/caqtdm/autoconvert; fi
if [ -n "$ALIVE" ];         then EDP=$EDP:${ALIVE}/aliveApp/ui/autoconvert; fi
if [ -n "$AUTOSAVE" ];      then EDP=$EDP:${AUTOSAVE}/asApp/op/ui/autoconvert; fi
if [ -n "$BUSY" ];          then EDP=$EDP:${BUSY}/busyApp/op/ui/autoconvert; fi
if [ -n "$CALC" ];          then EDP=$EDP:${CALC}/calcApp/ui/autoconvert; fi
if [ -n "$DEVIOCSTATS" ];   then EDP=$EDP:${DEVIOCSTATS}/op/ui; fi
if [ -n "$LUA" ];           then EDP=$EDP:${LUA}/luaApp/op/ui/autoconvert; fi
if [ -n "$SSCAN" ];         then EDP=$EDP:${SSCAN}/sscanApp/op/ui/autoconvert; fi

# there should be an XXX , but if it exists changeprefix trashes it.

#Export 
# make caqtdm use the medm paths defined before 
f5="CAQTDM_DISPLAY_PATH=$EDP"

#echo $f5
export $f5





}

function do_caqtdm ()
{
parse_header ${0%/*}
parse_caqtdm_paths
#parse_medm_paths

#/APSshare/caqtdm/caqtdm-4.2.0/caQtDM_Binaries/caQtDM -x -macro "P=$3, R=cam1:, C=$2" $1.ui &

# or whatever the os is 7/8/9

#/APSshare/caqtdm/caqtdm-4.4.0-APS/caQtDM_Binaries/rhel9-x86_64/caQtDM -x -macro "P=$3, R=cam1:, C=$2" $1.adl &

/APSshare/caqtdm/caqtdm-4.4.1/caQtDM_Binaries/rhel9-x86_64/caQtDM -x -macro "P=$3, R=cam1:, C=$2" $1.ui &
#/APSshare/caqtdm/caqtdm-4.4.1/caQtDM_Binaries/rhel9-x86_64/caQtDM -x -macro "P=$3, R=cam1:, C=$2" $1.adl &
#expensive !!!!! very CPU intensive to use ad_cam_image , also still only support b&w images

#/APSshare/caqtdm/caqtdm-4.2.0/caQtDM_Binaries/caQtDM -attach -x -macro "P=$3, R=cam1:, C=$2" ad_cam_image.ui &

}

function do_medm ()
{
parse_header ${0%/*}
parse_medm_paths
echo $1.adl $2 $3
medm -x -macro "P=$3, R=cam1:, C=$2" $1.adl &
#/APSshare/caqtdm/caqtdm-4.4.0-APS/caQtDM_Binaries/caQtDM -x -macro "P=$3, R=cam1:, C=$2" $1.adl &

}

###########################################################################

#as required to supress dulipcate interface GUI messages
#export EPICS_CA_AUTO_ADDR_LIST=NO
#export EPICS_CA_ADDR_LIST=169.254.255.255

# start main Area Detector screen here . . . 

#export STARTUP=ADAravis
#export STARTUP=pixirad
#export STARTUP=pointGrey
#export STARTUP=prosilica
#export STARTUP=pixirad
#export STARTUP=ADSpinnaker
#export STARTUP=simDetector
#export STARTUP=URLDriver
#export STARTUP=ADVimba
#export STARTUP=mar345
#export STARTUP=pilatusDetector
#export STARTUP=eigerDetector

#export TYPE=
#export TYPE=FLIR-Oryx-ORX-10G-310S9M


if [ "$1" == "MEDM" ]; then 
do_medm ${STARTUP} ${TYPE} ${XXX}
fi

if [ "$1" == "CAQTDM" ]; then 
do_caqtdm ${STARTUP} ${TYPE} ${XXX}
fi





