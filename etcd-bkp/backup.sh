TODAY=`date +"%Y-%m-%d"`
## Create backup in local directory
if [[ -z $(ls /k8bkp/etcd-backup/master1/ | grep $TODAY) ]]; then
echo "INFO (step1): creating snapshot $TODAY.zip"
rke etcd snapshot-save --config /data/rke/cluster.yml --name  $TODAY
#giving permission to copy
echo "INFO granting permission to copy backup file from master1 to admin"
ssh -i /data/r-ssh/id_rsa bkp-user@10.0.100.6 'sudo chmod -R 777 /opt/rke/etcd-snapshots'
echo "INFO granting permission to copy backup file from master2 to admin"
ssh -i /data/r-ssh/id_rsa bkp-user@10.0.100.7 'sudo chmod -R 777 /opt/rke/etcd-snapshots'
echo "INFO granting permission to copy backup file from master3 to admin"
ssh -i /data/r-ssh/id_rsa bkp-user@10.0.100.8 'sudo chmod -R 777 /opt/rke/etcd-snapshots'
#copying files from masters to admin node
echo "INFO copying backup from master1 to admin node"
scp -i /data/r-ssh/id_rsa bkp-user@10.0.100.6:/opt/rke/etcd-snapshots/$TODAY.zip /k8bkp/etcd-backup/master1/
echo "INFO copying backup from master2 to admin node"
scp -i /data/r-ssh/id_rsa bkp-user@10.0.100.7:/opt/rke/etcd-snapshots/$TODAY.zip /k8bkp/etcd-backup/master2/
echo "INFO copying backup from master3 to admin node"
scp -i /data/r-ssh/id_rsa bkp-user@10.0.100.8:/opt/rke/etcd-snapshots/$TODAY.zip /k8bkp/etcd-backup/master3/
else
echo "snapshot-$TODAY already exists"
fi
echo "INFO removing 10 days old backup file from master1"
ssh -i /data/r-ssh/id_rsa bkp-user@10.0.100.6 'bash -s' < master-bkup.sh
echo "INFO removing 10 days old backup file from master2"
ssh -i /data/r-ssh/id_rsa bkp-user@10.0.100.7 'bash -s' < master-bkup.sh
echo "INFO removing 10 days old backup file from master3"
ssh -i /data/r-ssh/id_rsa bkp-user@10.0.100.8 'bash -s' < master-bkup.sh

