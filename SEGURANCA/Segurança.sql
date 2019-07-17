CREATE USER 'joao'@'10.0.0.%' identified BY 'Professor'; 

grant ALL privileges ON compubras.* to 'joao'@'10.0.0.%' ;

revoke all on compubras.* from 'joao'@'10.0.0.%';

grant select,update,insert, delete on compubras.* to 'joao'@'10.0.0.%';

create user 'joao'@'localhost' identified by 'password';

grant select,update on compubras.* to 'joao'@'localhost';

revoke all privileges on compubras.* from 'joao'@'localhost';