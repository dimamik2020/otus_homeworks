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

ДЗ. Инфраструктура как код. Terraform

- Определил input переменную для приватного ключа, зоны

Задание со *

Если добавлять в метаданные другие ключи, то добавиться только последний ключ.

"...
Добавьте в веб интерфейсе ssh ключ пользователю
appuser_web в метаданные проекта. Выполните terraform
apply и проверьте результат
Какие проблемы вы обнаружили? Добавьте описание в
README.md
..."

Вроде никаких проблем не обнаружил.

Задание с **
"... Создайте файл lb.tf и опишите в нем в коде terraform
создание HTTP балансировщика...
..."

Задание со * (09.Практика.pdf (хранение стейта в storage)

../terraform/
  storage-bucket.tf создаёт storage
  prod/ - создаёт два инстанса в окружении prod (доступ с одного IP для SSH)
  stage/ - открыт доступ по ssh
  modules/ - модули
  ../storage-bucket/ - переписанный под tf 0.13 модуль из реестра tf
         
