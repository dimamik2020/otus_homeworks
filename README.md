Коннектимся в одну строчку на internalhost через bastion-хост:

$> ssh -J Dima@34.105.235.15 Dima@10.154.0.4

Прописываем в ~/.ssh/config и коннектимся через $> ssh internalhost

### The Bastion Host
Host bastion
  HostName 34.105.235.15
  User Dima

### The Remote Host
Host internalhost
  HostName 10.154.0.4
  ProxyJump bastion
  User Dima
