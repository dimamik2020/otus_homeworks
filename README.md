ДЗ. Основные сервисы Google Cloud Platform GCP

Скрипт для запуска машины с пепедачей ей startup-скрипта:

gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=startup.sh

Скрипт, создающий правило для puma-сервера

gcloud compute firewall-rules create puma-server \
--allow=tcp:9292 \
--direction=INGRESS \
--source-ranges=0.0.0.0/0 \
--target-tags=puma-server

ДЗ Практика. Сборка образа VM при помощи Packer

immutable_run.sh

Собирает конфиги вместе, строит образ Packer-ом, создаёт правило файрвола,
запускает инстанс из построенного ранее образа
