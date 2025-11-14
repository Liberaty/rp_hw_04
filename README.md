# Домашнее задание к занятию «Кластеры. Ресурсы под управлением облачных провайдеров» - Лепишин Алексей

### Цели задания 

1. Организация кластера Kubernetes и кластера баз данных MySQL в отказоустойчивой архитектуре.
2. Размещение в private подсетях кластера БД, а в public — кластера Kubernetes.

---
## Задание 1. Yandex Cloud

1. Настроить с помощью Terraform кластер баз данных MySQL.

 - Используя настройки VPC из предыдущих домашних заданий, добавить дополнительно подсеть private в разных зонах, чтобы обеспечить отказоустойчивость. 
 - Разместить ноды кластера MySQL в разных подсетях.
 - Необходимо предусмотреть репликацию с произвольным временем технического обслуживания.
 - Использовать окружение Prestable, платформу Intel Broadwell с производительностью 50% CPU и размером диска 20 Гб.
 - Задать время начала резервного копирования — 23:59.
 - Включить защиту кластера от непреднамеренного удаления.
 - Создать БД с именем `netology_db`, логином и паролем.

2. Настроить с помощью Terraform кластер Kubernetes.

 - Используя настройки VPC из предыдущих домашних заданий, добавить дополнительно две подсети public в разных зонах, чтобы обеспечить отказоустойчивость.
 - Создать отдельный сервис-аккаунт с необходимыми правами. 
 - Создать региональный мастер Kubernetes с размещением нод в трёх разных подсетях.
 - Добавить возможность шифрования ключом из KMS, созданным в предыдущем домашнем задании.
 - Создать группу узлов, состояющую из трёх машин с автомасштабированием до шести.
 - Подключиться к кластеру с помощью `kubectl`.
 - *Запустить микросервис phpmyadmin и подключиться к ранее созданной БД.
 - *Создать сервис-типы Load Balancer и подключиться к phpmyadmin. Предоставить скриншот с публичным адресом и подключением к БД.

Полезные документы:

- [MySQL cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mysql_cluster).
- [Создание кластера Kubernetes](https://cloud.yandex.ru/docs/managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create)
- [K8S Cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_cluster).
- [K8S node group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_node_group).

--- 

## Решение

1. Настроим с помощью Terraform кластер баз данных MySQL:

- Описываем переменные в [**variables.tf**](https://github.com/Liberaty/rp_hw_04/blob/main/variables.tf), где указываем private и public сети во всех 3 зонах яндекса. Далее в файле [**vpc.tf**](https://github.com/Liberaty/rp_hw_04/blob/main/vpc.tf) опишем создание ресурсов сетей, nat шлюза и таблицы маршрутизации.

- В файле [**mysql.tf**](https://github.com/Liberaty/rp_hw_04/blob/main/mysql.tf) описываем создание кластера с необходимыми параметрами и созданием БД.

После применения конфигурации, проверим, что все ресурсы создались в облаке:

- Сети в разных зонах:

![1.1.png](https://github.com/Liberaty/rp_hw_04/blob/main/img/1.1.png?raw=true)

- Таблица маршрутизации через nat gateway:

![1.2.png](https://github.com/Liberaty/rp_hw_04/blob/main/img/1.2.png?raw=true)

- Кластер MySQL:

![1.3.png](https://github.com/Liberaty/rp_hw_04/blob/main/img/1.3.png?raw=true)

- Хосты:

![1.4.png](https://github.com/Liberaty/rp_hw_04/blob/main/img/1.4.png?raw=true)

- Пользователи:

![1.5.png](https://github.com/Liberaty/rp_hw_04/blob/main/img/1.5.png?raw=true)

- База данных:

![1.7.png](https://github.com/Liberaty/rp_hw_04/blob/main/img/1.6.png?raw=true)

2. Настроим с помощью Terraform кластер Kubernetes:

- Опишем создание кластера с сервисными аккаунтами в [**k8s.tf**](https://github.com/Liberaty/rp_hw_04/blob/main/k8s.tf), добавим в [**variables.tf**](https://github.com/Liberaty/rp_hw_04/blob/main/variables.tf) необходимые переменные

- Добавим возможность шифрования ключом из [**kms.tf**](https://github.com/Liberaty/rp_hw_04/blob/main/kms.tf)

После применения конфигурации, проверим, что все ресурсы создались в облаке:

- Сервисный аккаунт:

![2.1.png](https://github.com/Liberaty/rp_hw_04/blob/main/img/2.1.png?raw=true)

- Группа безопасности:

![2.2.png](https://github.com/Liberaty/rp_hw_04/blob/main/img/2.2.png?raw=true)

- Ключ шифрования:

![2.3.png](https://github.com/Liberaty/rp_hw_04/blob/main/img/2.3.png?raw=true)

- Кластер:

![2.4.png](https://github.com/Liberaty/rp_hw_04/blob/main/img/2.4.png?raw=true)

- Группы узлов с автомасштабированием:

![2.5.png](https://github.com/Liberaty/rp_hw_04/blob/main/img/2.5.png?raw=true)

- Ноды:

![2.6.png](https://github.com/Liberaty/rp_hw_04/blob/main/img/2.6.png?raw=true)

- Подключаемся к кластеру с помощью kubectl и проверяем список нод:

![2.7.png](https://github.com/Liberaty/rp_hw_04/blob/main/img/2.7.png?raw=true)

- Создание микросервиса phpmyadmin с сервисом Load Balancer описываем также в [**k8s.tf**](https://github.com/Liberaty/rp_hw_04/blob/main/k8s.tf), из [**outputs.tf**](https://github.com/Liberaty/rp_hw_04/blob/main/outputs.tf) берем IP балансера и адрес базы данных:

![2.8.png](https://github.com/Liberaty/rp_hw_04/blob/main/img/2.8.png?raw=true)

- Проверяем что страница доступна:

![2.9.png](https://github.com/Liberaty/rp_hw_04/blob/main/img/2.9.png?raw=true)

- И подключаемся к базе данных:

![2.10.png](https://github.com/Liberaty/rp_hw_04/blob/main/img/2.10.png?raw=true)

### Правила приёма работы

Домашняя работа оформляется в своём Git репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
Файл README.md должен содержать скриншоты вывода необходимых команд, а также скриншоты результатов.
Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.