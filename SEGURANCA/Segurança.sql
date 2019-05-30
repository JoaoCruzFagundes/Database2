CREATE USER 'joao'@'10.0.0.%' identified BY 'Professor'; 

grant ALL privileges ON compubras.* to 'joao'@'10.0.0.%' ;

revoke all on compubras.* from 'joao'@'10.0.0.%';

grant select,update,insert, delete on compubras.* to 'joao'@'10.0.0.%';