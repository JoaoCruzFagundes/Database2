delimiter $$
create event atualizaDolarSeuguna every week
starts now() + interval dayofweek(now())
 
delimiter ;