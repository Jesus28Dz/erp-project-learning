# erp-project-learning
Aprendizaje de Python y PostgreSQL a través del desarrollo de un sitio web e ERP para un ISP

--- Tables structure ---

#=== clients ===
Camp_name      Type
id             number
name           text
reference      text
address        text
phone1         text
phone2         text
email          text

#=== users ===
Camp_name        Type
id               number
name             text
address          text
phone            text
email            text
role_id          number

#=== roles ===
Camp_name        Type
id               number
name             text
privilege        number

#=== payment_method ===
Camp_name       Type
id              number
method          text

#=== top_ups ===  
Camp_name                        Type
id                               number
vendor_id                        number
client_id                        number
payment_id                       number
company_platform_mode_amount_id  number
number                           text
folio                            text

#=== services ===  
Camp_name                        Type
id                               number
vendor_id                        number
client_id                        number
payment_id                       number
company_platform_id              number
amount                           number
service_number                   text
folio                            text

#=== epin ===  
Camp_name                        Type
id                               number
vendor_id                        number
client_id                        number
payment_id                       number
company_platform_amount_id       number
number                           text
folio                            text

#=== payment ===
Camp_name          Type
id                 number
payment               text
  
#=== companies a===
Camp_name          Type
id                 number
company               text

#=== platforms ===
Camp_name          Type
id                 number
platform           text

#=== modes ===
Camp_name          Type
id                 number
mode               text

#=== amounts ===
Camp_name          Type
id                 number
amount             text

#=== company_platform_mode_amount ===
Camp_name          Type
id                 number
company_id         number
platform_id        number
mode_id            number
amount_id          number 

#=== company_platform ===
Camp_name          Type
id                 number
company_id         number
platform_id        number

#=== company_platform_amount ===
Camp_name          Type
id                 number
company_id         number
platform_id        number
amount_id          number 

#=== ticket ===#  
Camp_name          Type
id                 number
vendor id          number
client_id          number
payment_method_id  number
amount             number
created_at         date

#=== sales ===
Camp_name           Type
id                  number
ticket_id           text
module_type         number
module_id           number
amount              number
