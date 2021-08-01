LASTDATE=$(date +"%Y-%m-%d" --date="10 days ago")
## Delete 10 days before backup form local directory
if [[ -z $(ls /opt/rke/etcd-snapshots/ | grep $LASTDATE) ]]; then
echo "Not existing $LASTDATE.zip "
else
sudo rm -rf /opt/rke/etcd-snapshots/$LASTDATE.zip
fi
