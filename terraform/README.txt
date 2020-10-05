../terraform/
  storage-bucket.tf создаёт storage
  prod/ - создаёт два инстанса в окружении prod (доступ с одного IP для SSH)
  stage/ - открыт доступ по ssh
  modules/ - модули
  ../storage-bucket/ - переписанный под tf 0.13 модуль из реестра tf
         
