

#!/bin/bash
export PATH=$PATH:/usr/ensta/pack/simplescalar-3v0d/bin/:/usr/ensta/pack/simplescalar-3v0d/simplesim-3.0
alias sslittle-na-sstrix-gcc='/auto/appy/ensta/pack/simplescalar-3v0d/bin/sslittle-na-sstrix-gcc'
alias sim-outorder='/auto/appy/ensta/pack/simplescalar-3v0d/simplesim-3.0/sim-outorder'
alias sim-profile='/auto/appy/ensta/pack/simplescalar-3v0d/simplesim-3.0/sim-profile'
alias sim-cache='/usr/ensta/pack/simplescalar-3v0d/simplesim-3.0/sim-cache'
clear
for taille in 16 32 64 128 256 512; do 
 echo $taille
 for i in small; do
 sim-outorder -redir:sim data_dij_"$i"_"$taille".txt -issue:inorder false -bpred bimod -bpred:bimod 256 -fetch:mplat 8 -fetch:ifqsize 4 -decode:width 2 -issue:width 4 -commit:width 2 -ruu:size 2 -lsq:size 8 -res:ialu 1 -res:fpalu 1 -res:imult 1 -res:fpmult 1 -cache:il1 il1:"$taille":32:2:l -cache:dl1 dl1:"$taille":32:2:l -cache:il2 dl2 -cache:dl2 ul2:2048:32:8:l dijkstra_"$i" input.dat
 done
done

#!/bin/bash
clear

#performance
for donnee in sim_IPC sim_total_insn sim_cycle; do
grep "$donnee" data_dij_small_* >> sim_dij_small_"$donnee".txt
done

#memoire
for donnee in il1.miss_rate dl1.miss_rate ul2.miss_rate; do
grep "$donnee" data_dij_small_* >>sim_dij_small_"$donnee".txt
done

#branchement

foo='bpred_bimod.bpred_'
for data in addr_rate dir_rate jr_rate jr_non_ras_rate.PP; do
donnee=$pref$data
grep "$donnee" data_dij_small_* >>sim_dij_small_"$donnee".txt
done

donnee='bpred_bimod.ras_rate.PP'
grep "$donnee" data_dij_small_* >>sim_dij_small_"$donnee".txt






