
chown -R fusecdn:fusecdn /home/


echo "加入service服务"
chmod 744 /etc/init.d/prometheus

chmod 744 /etc/init.d/grafana

chmod 744 /etc/init.d/linuxExporter

chmod 744 /etc/init.d/mysqldExporter

