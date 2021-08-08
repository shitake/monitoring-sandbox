# blackbox exporter
docker run \
  --name blackbox-exporter \
  -d \
  -p 9115:9115 \
  --restart always \
  -v $(pwd)/configs/blackbox-exporter:/config \
  prom/blackbox-exporter:master \
  --config.file=/config/blackbox.yml

# Prometheus
docker run \
  --name prometheus \
  -d \
  -p 9090:9090 \
  --restart always \
  -v $(pwd)/configs/prometheus:/etc/prometheus \
  prom/prometheus

# AlertManager
docker run \
  --name alertmanager \
  -d \
  -p 9093:9093 \
  --restart always \
  -v $(pwd)/configs/alertmanager:/etc/alertmanager \
  prom/alertmanager \
  --config.file=/etc/alertmanager/config.yml


# Grafana
docker run \
  --name grafana \
  -d \
  -p 3000:3000 \
  --restart always \
  -v grafana-storage:/var/lib/grafana \
  grafana/grafana
# adminでログインできないため、PWリセット
docker exec -it grafana grafana-cli admin reset-admin-password admin
