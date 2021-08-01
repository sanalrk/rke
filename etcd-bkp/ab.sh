#LASTDATE=`date +"%Y-%m-%d" --date="10 days ago"`
#ssh -i /data/r-ssh/id_rsa bkp-user@10.0.100.8 'sudo rm /opt/rke/etcd-snapshots/$LASTDATE.zip -rf'
ssh -i /data/r-ssh/id_rsa bkp-user@10.0.100.8 'bash -s' < master-bkup.sh
