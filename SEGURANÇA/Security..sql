CREATE USER 'Joao'@'local_host' identified by 'aaa';
-- grant :give acess to action in database 
grant all privileges on compubras.*  to 'Joao'@'local_host';
-- Revoke remove acess --
REVOKE ALL privileges ON compubras.* from 'Joao'@'local_host';
-- rename and drop are also action with security--
