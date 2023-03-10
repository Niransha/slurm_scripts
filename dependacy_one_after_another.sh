#!/bin/sh
#############################################################
#### dependacy jobs - unlimited time for small time jobs ####
#### this will submit one job after another 		#####
#### Niransha Kumarachchi 12/5/2022  ########################
#############################################################

#r m jobs.txt

# submit the fist job here 
jb1=$(sbatch koko.cpu.g09.init_epsilon_rot.sh)
id1=`echo $jb1 | awk '{print $4}'`

echo  " first job $id1 "
#echo  " first job $id1 "  >> jobs.txt

##################################################
# second job when for loop is 2
for (( i=2; i<=100; i++ ))    #begin with 2 here for easy naming 
do 

if [[ $i == 2 ]];
then


nid=$id1
jobsub=$(sbatch --dependency=afterany:$nid koko.cpu.g09.init_epsilon_rot.sh)
nid=`echo $jobsub | awk '{print $4}'`

echo " second job $nid depends on $id1 #####"
#echo " second job $nid depends on $id1 #####"  >> jobs.txt



############## other jobs when i is not 2 #################### 

else

nbefore=$nid

nid=$nid
jobsub=$(sbatch --dependency=afterany:$nid koko.cpu.g09.init_epsilon_rot.sh)
nid=`echo $jobsub | awk '{print $4}'`

nafter=$nid

echo " $i th $nafter depends on $nbefore #####"
#echo " $i th $nafter depends on $nbefore #####"  >> jobs.txt


fi

done 

squeue -u $USER -S S,i,M -o "%12i %15j %4t %30E"


