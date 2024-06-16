PGDMP      6        
        |            iipiixxiiaksenovno    16.1    16.1 m   F           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            G           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            H           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            I           1262    16399    iipiixxiiaksenovno    DATABASE     �   CREATE DATABASE iipiixxiiaksenovno WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
 "   DROP DATABASE iipiixxiiaksenovno;
                postgres    false            J           0    0    DATABASE iipiixxiiaksenovno    ACL     0  GRANT CONNECT ON DATABASE iipiixxiiaksenovno TO res_guest;
GRANT CONNECT ON DATABASE iipiixxiiaksenovno TO res_dguest;
GRANT CONNECT ON DATABASE iipiixxiiaksenovno TO res_waiter;
GRANT CONNECT ON DATABASE iipiixxiiaksenovno TO res_chef;
GRANT CONNECT ON DATABASE iipiixxiiaksenovno TO res_administrator;
                   postgres    false    5193                        3079    59682 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                   false            K           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                        false    2            D           1255    26829    booking_delete(integer) 	   PROCEDURE     ]  CREATE PROCEDURE public.booking_delete(IN p_booking_kod integer)
    LANGUAGE plpgsql
    AS $$
declare meeting_count int := count(*) from planning_orders where book_kod = p_booking_kod;
	begin 
	if (meeting_count > 0) then
	raise notice 'this booking is used';
	else
		 delete from booking 
		 where booking_kod = p_booking_kod;
	end if;
	end;
$$;
 @   DROP PROCEDURE public.booking_delete(IN p_booking_kod integer);
       public          postgres    false            L           0    0 2   PROCEDURE booking_delete(IN p_booking_kod integer)    ACL       GRANT ALL ON PROCEDURE public.booking_delete(IN p_booking_kod integer) TO res_guest;
GRANT ALL ON PROCEDURE public.booking_delete(IN p_booking_kod integer) TO res_dguest;
GRANT ALL ON PROCEDURE public.booking_delete(IN p_booking_kod integer) TO res_administrator;
          public          postgres    false    324            H           1255    26787 o   booking_insert(date, time without time zone, date, time without time zone, integer, integer, character varying) 	   PROCEDURE     A  CREATE PROCEDURE public.booking_insert(IN p_book_making_date date, IN p_book_making_time time without time zone, IN p_book_plan_date date, IN p_book_plan_time time without time zone, IN p_book_guests_count integer, IN p_wood_table_kod integer, IN p_v_kod character varying)
    LANGUAGE plpgsql
    AS $$
		declare p_new_book_number text:= 1 + count(*) from booking;
		declare p_new_book_year text:=  right(left(p_book_plan_date::text, 4),2);
		declare p_loop_max_length int= 10 - length(p_new_book_number);
		declare p_new_number varchar(10) := '';
		declare p_booking_number text = '';
	begin 
		for i in 1..p_loop_max_length loop
			p_new_number := p_new_number||'0';
		end loop;
		p_booking_number := 'БР/'||p_new_book_year||'/'||p_new_number||p_new_book_number;
		
		insert into booking(book_number,book_making_date,book_making_time,book_plan_date,
							book_plan_time,book_guests_count,wood_table_kod,v_kod)
		values(p_booking_number, p_book_making_date, 
			   p_book_making_time,p_book_plan_date,
				p_book_plan_time, p_book_guests_count,p_wood_table_kod, p_v_kod);
	end;
$$;
   DROP PROCEDURE public.booking_insert(IN p_book_making_date date, IN p_book_making_time time without time zone, IN p_book_plan_date date, IN p_book_plan_time time without time zone, IN p_book_guests_count integer, IN p_wood_table_kod integer, IN p_v_kod character varying);
       public          postgres    false            M           0    0   PROCEDURE booking_insert(IN p_book_making_date date, IN p_book_making_time time without time zone, IN p_book_plan_date date, IN p_book_plan_time time without time zone, IN p_book_guests_count integer, IN p_wood_table_kod integer, IN p_v_kod character varying)    ACL     {  GRANT ALL ON PROCEDURE public.booking_insert(IN p_book_making_date date, IN p_book_making_time time without time zone, IN p_book_plan_date date, IN p_book_plan_time time without time zone, IN p_book_guests_count integer, IN p_wood_table_kod integer, IN p_v_kod character varying) TO res_guest;
GRANT ALL ON PROCEDURE public.booking_insert(IN p_book_making_date date, IN p_book_making_time time without time zone, IN p_book_plan_date date, IN p_book_plan_time time without time zone, IN p_book_guests_count integer, IN p_wood_table_kod integer, IN p_v_kod character varying) TO res_dguest;
GRANT ALL ON PROCEDURE public.booking_insert(IN p_book_making_date date, IN p_book_making_time time without time zone, IN p_book_plan_date date, IN p_book_plan_time time without time zone, IN p_book_guests_count integer, IN p_wood_table_kod integer, IN p_v_kod character varying) TO res_administrator;
          public          postgres    false    328            E           1255    26824 �   booking_update(character varying, date, time without time zone, date, time without time zone, integer, integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.booking_update(IN p_booking_number character varying, IN p_book_making_date date, IN p_book_making_time time without time zone, IN p_book_plan_date date, IN p_book_plan_time time without time zone, IN p_book_guests_count integer, IN p_wood_table_kod integer, IN p_v_kod character varying)
    LANGUAGE plpgsql
    AS $$
	begin 
		 update booking set
		 book_making_date = p_book_making_date,
		 book_making_time = p_book_making_time,
		 book_plan_date = p_book_plan_date,
		 book_plan_time = p_book_plan_time,
		 book_guests_count = p_book_guests_count,
		 wood_table_kod = p_wood_table_kod,
		 v_kod = p_v_kod
		 where book_number = p_booking_number;
		
	end;
$$;
 8  DROP PROCEDURE public.booking_update(IN p_booking_number character varying, IN p_book_making_date date, IN p_book_making_time time without time zone, IN p_book_plan_date date, IN p_book_plan_time time without time zone, IN p_book_guests_count integer, IN p_wood_table_kod integer, IN p_v_kod character varying);
       public          postgres    false            N           0    0 *  PROCEDURE booking_update(IN p_booking_number character varying, IN p_book_making_date date, IN p_book_making_time time without time zone, IN p_book_plan_date date, IN p_book_plan_time time without time zone, IN p_book_guests_count integer, IN p_wood_table_kod integer, IN p_v_kod character varying)    ACL     �  GRANT ALL ON PROCEDURE public.booking_update(IN p_booking_number character varying, IN p_book_making_date date, IN p_book_making_time time without time zone, IN p_book_plan_date date, IN p_book_plan_time time without time zone, IN p_book_guests_count integer, IN p_wood_table_kod integer, IN p_v_kod character varying) TO res_guest;
GRANT ALL ON PROCEDURE public.booking_update(IN p_booking_number character varying, IN p_book_making_date date, IN p_book_making_time time without time zone, IN p_book_plan_date date, IN p_book_plan_time time without time zone, IN p_book_guests_count integer, IN p_wood_table_kod integer, IN p_v_kod character varying) TO res_dguest;
GRANT ALL ON PROCEDURE public.booking_update(IN p_booking_number character varying, IN p_book_making_date date, IN p_book_making_time time without time zone, IN p_book_plan_date date, IN p_book_plan_time time without time zone, IN p_book_guests_count integer, IN p_wood_table_kod integer, IN p_v_kod character varying) TO res_administrator;
          public          postgres    false    325            '           1255    25013    checkue_insert(character varying, date, time without time zone, integer, integer, integer, character varying, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.checkue_insert(IN p_checkue_number character varying, IN p_checkue_date date, IN p_checkue_time time without time zone, IN p_checkue_sumfinal integer, IN p_checkue_sumgotten integer, IN p_checkue_changesum integer, IN p_checkue_paytype character varying, IN p_checkue_finalcost integer, IN p_order_kod integer)
    LANGUAGE plpgsql
    AS $$
	declare metteng_count int := count(*) from checkues where checkue_number = p_Checkue_number;
	begin
	if (metteng_count > 0) then
	raise notice 'such check is already in base';
	else
		insert into checkues(Checkue_number, Checkue_date, Checkue_time, 
						Checkue_sumFinal, Checkue_sumGotten, Checkue_changeSum, Checkue_PayType, 
						 Checkue_finalCost, Order_kod)
		values (p_Checkue_number, p_Checkue_date, p_Checkue_time, 
						 p_Checkue_sumFinal, p_Checkue_sumGotten, p_Checkue_changeSum, p_Checkue_PayType, 
						p_Checkue_finalCost, p_Order_kod);	
	end if;
	end;
$$;
 N  DROP PROCEDURE public.checkue_insert(IN p_checkue_number character varying, IN p_checkue_date date, IN p_checkue_time time without time zone, IN p_checkue_sumfinal integer, IN p_checkue_sumgotten integer, IN p_checkue_changesum integer, IN p_checkue_paytype character varying, IN p_checkue_finalcost integer, IN p_order_kod integer);
       public          postgres    false                       1255    24804    checkues_delete(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.checkues_delete(IN p_checkue_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin 
		delete from checkues
			where 
				checkue_kod = p_checkue_kod;
	end;
$$;
 A   DROP PROCEDURE public.checkues_delete(IN p_checkue_kod integer);
       public          postgres    false            O           0    0 3   PROCEDURE checkues_delete(IN p_checkue_kod integer)    ACL     W   GRANT ALL ON PROCEDURE public.checkues_delete(IN p_checkue_kod integer) TO res_waiter;
          public          postgres    false    274            )           1255    25014 �   checkues_update(character varying, date, time without time zone, integer, integer, integer, character varying, integer, integer, integer) 	   PROCEDURE       CREATE PROCEDURE public.checkues_update(IN p_checkue_number character varying, IN p_checkue_date date, IN p_checkue_time time without time zone, IN p_checkue_sumfinal integer, IN p_checkue_sumgotten integer, IN p_checkue_changesum integer, IN p_checkue_paytype character varying, IN p_checkue_finalcost integer, IN p_checkue_kod integer, IN p_order_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin
		update Checkues set
		checkue_number = p_Checkue_number,
		checkue_date = p_Checkue_date,
		checkue_time = p_Checkue_time,
		checkue_sumfinal = p_Checkue_sumFinal,
		checkue_changesum = p_Checkue_changeSum,
		checkue_sumgotten = p_Checkue_sumGotten,
		checkue_paytype = p_Checkue_PayType,
		order_kod = p_order_kod
			where 
				checkue_kod = p_checkue_kod;
	end;
$$;
 i  DROP PROCEDURE public.checkues_update(IN p_checkue_number character varying, IN p_checkue_date date, IN p_checkue_time time without time zone, IN p_checkue_sumfinal integer, IN p_checkue_sumgotten integer, IN p_checkue_changesum integer, IN p_checkue_paytype character varying, IN p_checkue_finalcost integer, IN p_checkue_kod integer, IN p_order_kod integer);
       public          postgres    false                       1255    24808    dishes_delete(integer) 	   PROCEDURE     L  CREATE PROCEDURE public.dishes_delete(IN p_dish_kod integer)
    LANGUAGE plpgsql
    AS $$
	declare meeting_count int := count(*) from orders where orders.dish_kod = p_dish_kod;
	begin
	if (meeting_count > 0) then
		raise notice 'such dish is used';
	else
		delete from dishes
		where
			dish_kod = p_dish_kod;
	end if;

	end;
$$;
 <   DROP PROCEDURE public.dishes_delete(IN p_dish_kod integer);
       public          postgres    false            P           0    0 .   PROCEDURE dishes_delete(IN p_dish_kod integer)    ACL     P   GRANT ALL ON PROCEDURE public.dishes_delete(IN p_dish_kod integer) TO res_chef;
          public          postgres    false    273                       1255    24805 E   dishes_insert(character varying, integer, numeric, character varying) 	   PROCEDURE       CREATE PROCEDURE public.dishes_insert(IN p_dish_name character varying, IN p_dish_cost integer, IN p_dish_weight numeric, IN p_dish_picture character varying)
    LANGUAGE plpgsql
    AS $$
	declare meeting_count int := count(*) from dishes where dish_name = p_dish_name;
	begin
	if (meeting_count > 0) then
	raise notice 'such dish is already it table';
	else
		insert into dishes(dish_name, dish_cost, dish_weight, dish_picture)
		values (p_dish_name, p_dish_cost, p_dish_weight, p_dish_picture);
	end if;
	end;
$$;
 �   DROP PROCEDURE public.dishes_insert(IN p_dish_name character varying, IN p_dish_cost integer, IN p_dish_weight numeric, IN p_dish_picture character varying);
       public          postgres    false            Q           0    0 �   PROCEDURE dishes_insert(IN p_dish_name character varying, IN p_dish_cost integer, IN p_dish_weight numeric, IN p_dish_picture character varying)    ACL     �   GRANT ALL ON PROCEDURE public.dishes_insert(IN p_dish_name character varying, IN p_dish_cost integer, IN p_dish_weight numeric, IN p_dish_picture character varying) TO res_chef;
          public          postgres    false    272                       1255    24807 N   dishes_update(character varying, integer, numeric, character varying, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.dishes_update(IN p_dish_name character varying, IN p_dish_cost integer, IN p_dish_weight numeric, IN p_dish_picture character varying, IN p_dish_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin
		update dishes set 
		dish_name = p_dish_name,
		dish_cost = p_dish_cost,
		dish_weight = p_dish_weight,
		dish_picture = p_dish_picture
		where
			dish_kod = p_dish_kod;
	end;
$$;
 �   DROP PROCEDURE public.dishes_update(IN p_dish_name character varying, IN p_dish_cost integer, IN p_dish_weight numeric, IN p_dish_picture character varying, IN p_dish_kod integer);
       public          postgres    false            R           0    0 �   PROCEDURE dishes_update(IN p_dish_name character varying, IN p_dish_cost integer, IN p_dish_weight numeric, IN p_dish_picture character varying, IN p_dish_kod integer)    ACL     �   GRANT ALL ON PROCEDURE public.dishes_update(IN p_dish_name character varying, IN p_dish_cost integer, IN p_dish_weight numeric, IN p_dish_picture character varying, IN p_dish_kod integer) TO res_chef;
          public          postgres    false    275            G           1255    24813    employee_delete(integer) 	   PROCEDURE     n  CREATE PROCEDURE public.employee_delete(IN p_employee_kod integer)
    LANGUAGE plpgsql
    AS $$
	declare meeting_count int := count(*) from orders where orders.employee_login = p_employee_login;
	begin
	if (meeting_count > 0) then
			raise notice 'employee is working lol';
	else
		delete from employee
		where
			employee_kod = p_employee_kod;
	end if;
	end;
$$;
 B   DROP PROCEDURE public.employee_delete(IN p_employee_kod integer);
       public          postgres    false            S           0    0 4   PROCEDURE employee_delete(IN p_employee_kod integer)    ACL     _   GRANT ALL ON PROCEDURE public.employee_delete(IN p_employee_kod integer) TO res_administrator;
          public          postgres    false    327            9           1255    26488 n   employee_insert(character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.employee_insert(IN p_employee_surname character varying, IN p_employee_name character varying, IN p_employee_patronymic character varying, IN p_employee_login character varying, IN p_employee_password character varying)
    LANGUAGE plpgsql
    AS $$
	declare meeting_count int := count(*) from Employee where employee_login = p_employee_login;
	begin
		if (meeting_count > 0) then
			raise notice 'such dish is used';
		else
			insert into employee(employee_surname,
								 employee_name,employee_patronymic, employee_login, employee_password)
			values (p_employee_surname,
								 p_employee_name,p_employee_patronymic, p_employee_login, p_employee_password);
	end if;
	end;
$$;
 �   DROP PROCEDURE public.employee_insert(IN p_employee_surname character varying, IN p_employee_name character varying, IN p_employee_patronymic character varying, IN p_employee_login character varying, IN p_employee_password character varying);
       public          postgres    false            T           0    0 �   PROCEDURE employee_insert(IN p_employee_surname character varying, IN p_employee_name character varying, IN p_employee_patronymic character varying, IN p_employee_login character varying, IN p_employee_password character varying)    ACL       GRANT ALL ON PROCEDURE public.employee_insert(IN p_employee_surname character varying, IN p_employee_name character varying, IN p_employee_patronymic character varying, IN p_employee_login character varying, IN p_employee_password character varying) TO res_chef;
GRANT ALL ON PROCEDURE public.employee_insert(IN p_employee_surname character varying, IN p_employee_name character varying, IN p_employee_patronymic character varying, IN p_employee_login character varying, IN p_employee_password character varying) TO res_administrator;
          public          postgres    false    313            1           1255    26489 w   employee_update(character varying, character varying, character varying, character varying, character varying, integer) 	   PROCEDURE     I  CREATE PROCEDURE public.employee_update(IN p_employee_surname character varying, IN p_employee_name character varying, IN p_employee_patronymic character varying, IN p_employee_login character varying, IN p_employee_password character varying, IN p_employee_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin
		update employee set
		employee_surname = p_employee_surname,
		employee_name = p_employee_name,
		employee_patronymic = p_employee_patronymic,
		employee_login = p_employee_login,
		employee_password = p_employee_password
		where
			employee_kod = p_employee_kod;
	end;
$$;
   DROP PROCEDURE public.employee_update(IN p_employee_surname character varying, IN p_employee_name character varying, IN p_employee_patronymic character varying, IN p_employee_login character varying, IN p_employee_password character varying, IN p_employee_kod integer);
       public          postgres    false            U           0    0    PROCEDURE employee_update(IN p_employee_surname character varying, IN p_employee_name character varying, IN p_employee_patronymic character varying, IN p_employee_login character varying, IN p_employee_password character varying, IN p_employee_kod integer)    ACL     q  GRANT ALL ON PROCEDURE public.employee_update(IN p_employee_surname character varying, IN p_employee_name character varying, IN p_employee_patronymic character varying, IN p_employee_login character varying, IN p_employee_password character varying, IN p_employee_kod integer) TO res_waiter;
GRANT ALL ON PROCEDURE public.employee_update(IN p_employee_surname character varying, IN p_employee_name character varying, IN p_employee_patronymic character varying, IN p_employee_login character varying, IN p_employee_password character varying, IN p_employee_kod integer) TO res_chef;
GRANT ALL ON PROCEDURE public.employee_update(IN p_employee_surname character varying, IN p_employee_name character varying, IN p_employee_patronymic character varying, IN p_employee_login character varying, IN p_employee_password character varying, IN p_employee_kod integer) TO res_administrator;
          public          postgres    false    305            Y           1255    59722    fc_orders_history_delete()    FUNCTION     T  CREATE FUNCTION public.fc_orders_history_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
insert into orders_history(order_name,wood_table_name,sostav,orders_history_status)
values (old.order_name, 
	   (select wood_table_name
		from public.wood_tables where table_kod = (select table_kod from public.orders where orders.order_name = old.order_name)),
		(select string_agg(dish_name, ', ') from  public.orders 
		 inner join public.dishes
		 on dishes.dish_kod = orders.dish_kod
		 where orders.order_name = old.order_name),
		'Удалённая'	  
	   );
	   return old;
end;
$$;
 1   DROP FUNCTION public.fc_orders_history_delete();
       public          postgres    false            V           1255    59716    fc_orders_history_insert()    FUNCTION     Y  CREATE FUNCTION public.fc_orders_history_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
insert into orders_history(order_name,wood_table_name,sostav,orders_history_status)
values (new.order_name, 
	   (select wood_table_name
		from public.wood_tables where table_kod = (select table_kod from public.orders where orders.order_name = new.order_name)),
		(select string_agg(dish_name, ', ') from  public.orders 
		 inner join public.dishes
		 on dishes.dish_kod = orders.dish_kod
		 where orders.order_name = new.order_name),
		'Новая запись'	  
	   );
	   return new;
end;
$$;
 1   DROP FUNCTION public.fc_orders_history_insert();
       public          postgres    false            W           1255    59718    fc_orders_history_update()    FUNCTION     T  CREATE FUNCTION public.fc_orders_history_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
insert into orders_history(order_name,wood_table_name,sostav,orders_history_status)
values (new.order_name, 
	   (select wood_table_name
		from public.wood_tables where table_kod = (select table_kod from public.orders where orders.order_name = new.order_name)),
		(select string_agg(dish_name, ', ') from  public.orders 
		 inner join public.dishes
		 on dishes.dish_kod = orders.dish_kod
		 where orders.order_name = new.order_name),
		'Изменение'	  
	   );
	   return new;
end;
$$;
 1   DROP FUNCTION public.fc_orders_history_update();
       public          postgres    false            Z           1255    59678    get_booking_discription(text)    FUNCTION     ^  CREATE FUNCTION public.get_booking_discription(p_booking_number text) RETURNS TABLE(client text, date_and_time text, wod_table_name text, guests_count text, dishes text)
    LANGUAGE plpgsql
    AS $$
begin 

if (select count(*) from booking where book_number =p_booking_number)> 0 and (select count(*) from planning_dishes where
book_number = p_booking_number) > 0 then 
	return query
	select
concat(rv_surname,' ',rv_name,' ',rv_patronymic)::text,
concat(book_plan_date,book_plan_time)::text,
wood_table_name::text,
book_guests_count::text,
string_agg(concat('"',dish_name,'"',' X',dishes_count,' - ',planning_dishes_time),', ')::text
from public.booking
inner join public.registered_visitors
on registered_visitors.rv_kod = booking.v_kod
inner join public.wood_tables
on wood_tables.table_kod = booking.wood_table_kod
left join public.planning_dishes
on planning_dishes.book_number = booking.book_number
left join public.dishes
on dishes.dish_kod = planning_dishes.dish_kod
where booking.book_number =p_booking_number
group by concat(rv_surname,' ',rv_name,' ',rv_patronymic),concat(book_plan_date,book_plan_time),wood_table_name,book_guests_count;



elsif (select count(*) from booking where book_number =p_booking_number)> 0 and (select count(*) from planning_dishes
 where book_number = p_booking_number) = 0 then
return query select
concat(rv_surname,' ',rv_name,' ',rv_patronymic)::text,
concat(book_plan_date,book_plan_time)::text,
wood_table_name::text,
book_guests_count::text,
'нет информации о блюдах в предварительных заказах'
from public.booking
inner join public.registered_visitors
on registered_visitors.rv_kod = booking.v_kod
inner join public.wood_tables
on wood_tables.table_kod = booking.wood_table_kod
where booking.book_number =p_booking_number
group by concat(rv_surname,' ',rv_name,' ',rv_patronymic),concat(book_plan_date,book_plan_time),wood_table_name,book_guests_count;

else
return query select
'нет информации',
'нет информации',
'нет информации',
'нет информации',
'нет информации';
end if;
end;
$$;
 E   DROP FUNCTION public.get_booking_discription(p_booking_number text);
       public          postgres    false            V           0    0 7   FUNCTION get_booking_discription(p_booking_number text)    ACL     [   GRANT ALL ON FUNCTION public.get_booking_discription(p_booking_number text) TO res_waiter;
          public          postgres    false    346            [           1255    59681    get_dish_discription(text)    FUNCTION     �  CREATE FUNCTION public.get_dish_discription(p_dish_name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare answer text; 
begin
	if (select count(*) from public.dishes where dishes.dish_name = p_dish_name) > 0 then 
		answer:= concat(dish_weight, 'гр., цена: ',dish_cost, 'р., состав: ', string_agg(ingredient_name,',')) from public.dishes
		inner join public.sostav on
		sostav.dish_kod = dishes.dish_kod
		inner join public.ingredientes on
		ingredientes.ingredient_kod = sostav.ingredient_kod
		where dishes.dish_name = p_dish_name
		group by dish_weight, dish_cost;
	else
		answer := 'неверный логин или пароль';
	end if;
	return answer;
end;
$$;
 =   DROP FUNCTION public.get_dish_discription(p_dish_name text);
       public          postgres    false            W           0    0 /   FUNCTION get_dish_discription(p_dish_name text)    ACL     �   GRANT ALL ON FUNCTION public.get_dish_discription(p_dish_name text) TO res_dguest;
GRANT ALL ON FUNCTION public.get_dish_discription(p_dish_name text) TO res_guest;
          public          postgres    false    347            J           1255    59666 H   get_employee_by_login_and_password(character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.get_employee_by_login_and_password(p_login character varying, p_password character varying) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare final_result text;
	begin
	if (select count(*) from public.employee where employee.employee_login = 
		p_login and employee.employee_password = p_password) > 0 then 
		final_result := employee_surname||' '||employee_name||' '||employee_patronymic from employee where employee.employee_login = 
		p_login and employee.employee_password = p_password;
		
	elsif (select count(*) from public.registered_visitors where 
		   registered_visitors.rv_login = p_login and registered_visitors.rv_password = p_password) > 0 then
		final_result := concat(rv_surname,' ',rv_name,' ',rv_patronymic) from registered_visitors where registered_visitors.rv_login = 
		p_login and registered_visitors.rv_password = p_password;
	else
		final_result := 'неверный логин или пароль';
	end if;
	return final_result;
	end;
$$;
 r   DROP FUNCTION public.get_employee_by_login_and_password(p_login character varying, p_password character varying);
       public          postgres    false            X           0    0 d   FUNCTION get_employee_by_login_and_password(p_login character varying, p_password character varying)    ACL       GRANT ALL ON FUNCTION public.get_employee_by_login_and_password(p_login character varying, p_password character varying) TO res_chef;
GRANT ALL ON FUNCTION public.get_employee_by_login_and_password(p_login character varying, p_password character varying) TO res_administrator;
          public          postgres    false    330            U           1255    59726 "   get_orders_list_for_employee(text)    FUNCTION     �  CREATE FUNCTION public.get_orders_list_for_employee(p_employee_login text) RETURNS TABLE(order_name text, wood_table_name text, sostav text, orders_history_status text, timestamp_create timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
begin
return query
select orders_history.order_name,orders_history.wood_table_name,orders_history.sostav,
orders_history.orders_history_status,orders_history.timestamp_create
from public.orders_history;


end;
$$;
 J   DROP FUNCTION public.get_orders_list_for_employee(p_employee_login text);
       public          postgres    false            X           1255    59725    get_orders_list_for_user(text)    FUNCTION     �  CREATE FUNCTION public.get_orders_list_for_user(p_user_login text) RETURNS TABLE(order_name text, wood_table_name text, sostav text, orders_history_status text, timestamp_create timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
begin
return query
select orders_history.order_name,orders_history.wood_table_name,orders_history.sostav,
orders_history.orders_history_status,orders_history.timestamp_create
from public.orders_history
inner join orders
on orders.order_name = orders_history.order_name
inner join public.individualorders
on individualorders.order_kod = orders.order_kod
inner join public.registered_visitors
on registered_visitors.rv_login = p_user_login;
end;
$$;
 B   DROP FUNCTION public.get_orders_list_for_user(p_user_login text);
       public          postgres    false            3           1255    26503     individualorders_delete(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.individualorders_delete(IN p_individualorder_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin
		delete from individualorders
		where
			individualorder_kod = p_individualorder_kod;
	end;
$$;
 Q   DROP PROCEDURE public.individualorders_delete(IN p_individualorder_kod integer);
       public          postgres    false            (           1255    25009 <   individualorders_insert(integer, character varying, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.individualorders_insert(IN p_order_kod integer, IN p_v_kod character varying, IN p_person_cost integer)
    LANGUAGE plpgsql
    AS $$
	declare meeting_count int := count(*) from individualorders_Insert 
	where order_kod = p_order_kod and _v_kod = p_v_kod;
	begin
	if (meeting_count > 0) then
			raise notice 'such relation is made';
	else
		insert into individualorders(order_kod,
							 v_kod, person_cost)
		values (p_order_kod, p_v_kod, p_person_cost);
	end if;
	end;
$$;
    DROP PROCEDURE public.individualorders_insert(IN p_order_kod integer, IN p_v_kod character varying, IN p_person_cost integer);
       public          postgres    false            Y           0    0 q   PROCEDURE individualorders_insert(IN p_order_kod integer, IN p_v_kod character varying, IN p_person_cost integer)    ACL     �   GRANT ALL ON PROCEDURE public.individualorders_insert(IN p_order_kod integer, IN p_v_kod character varying, IN p_person_cost integer) TO res_waiter;
          public          postgres    false    296            2           1255    26502 E   individualorders_update(integer, character varying, integer, integer) 	   PROCEDURE     t  CREATE PROCEDURE public.individualorders_update(IN p_order_kod integer, IN p_v_kod character varying, IN p_person_cost integer, IN p_individualorder_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin
		update individualorders set
		order_kod = p_order_kod,
		v_kod = p_v_kod,	
		person_cost= p_person_cost
		where
			individualorder_kod = p_individualorder_kod;
	end;
$$;
 �   DROP PROCEDURE public.individualorders_update(IN p_order_kod integer, IN p_v_kod character varying, IN p_person_cost integer, IN p_individualorder_kod integer);
       public          postgres    false            .           1255    24819    ingredientes_delete(integer) 	   PROCEDURE     �  CREATE PROCEDURE public.ingredientes_delete(IN p_ingredient_kod integer)
    LANGUAGE plpgsql
    AS $$
	declare p_count_of_usage int = count(*) from sostav
	where ingredient_kod = p_ingredient_kod;
	begin
	if (p_count_of_usage > 0) then
	raise notice 'Данный ингредиент уже используется';
	else
		delete from ingredientes
		where
			ingredient_kod = p_ingredient_kod;
	end if;
	end;
$$;
 H   DROP PROCEDURE public.ingredientes_delete(IN p_ingredient_kod integer);
       public          postgres    false            Z           0    0 :   PROCEDURE ingredientes_delete(IN p_ingredient_kod integer)    ACL     \   GRANT ALL ON PROCEDURE public.ingredientes_delete(IN p_ingredient_kod integer) TO res_chef;
          public          postgres    false    302                        1255    24817 &   ingredientes_insert(character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.ingredientes_insert(IN p_ingredient_name character varying)
    LANGUAGE plpgsql
    AS $$
declare meeting_count int := count(*) from ingredientes where ingredient_name = p_ingredient_name;
	begin
	if (meeting_count > 0) then
			raise notice 'such ingredient is made';
	else
		insert into ingredientes(ingredient_name)
		values (p_ingredient_name);
	end if;
	end;
$$;
 S   DROP PROCEDURE public.ingredientes_insert(IN p_ingredient_name character varying);
       public          postgres    false            [           0    0 E   PROCEDURE ingredientes_insert(IN p_ingredient_name character varying)    ACL     g   GRANT ALL ON PROCEDURE public.ingredientes_insert(IN p_ingredient_name character varying) TO res_chef;
          public          postgres    false    288            -           1255    24818 /   ingredientes_update(character varying, integer) 	   PROCEDURE       CREATE PROCEDURE public.ingredientes_update(IN p_ingredient_name character varying, IN p_ingredient_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin
		update ingredientes set
		ingredient_name = p_ingredient_name
		where
			ingredient_kod = p_ingredient_kod;
	end;
$$;
 p   DROP PROCEDURE public.ingredientes_update(IN p_ingredient_name character varying, IN p_ingredient_kod integer);
       public          postgres    false            \           0    0 b   PROCEDURE ingredientes_update(IN p_ingredient_name character varying, IN p_ingredient_kod integer)    ACL     �   GRANT ALL ON PROCEDURE public.ingredientes_update(IN p_ingredient_name character varying, IN p_ingredient_kod integer) TO res_chef;
          public          postgres    false    301                       1255    26066    insert_data() 	   PROCEDURE     �  CREATE PROCEDURE public.insert_data()
    LANGUAGE plpgsql
    AS $$
	begin
insert into smeta (smeta_number, smeta_date)
values ('СП-0000001-23', '16.09.2023');
call smeta_insert('16.09.2023','СП-0000002-23');

insert into providers(provider_city, provider_street, provider_house,
					 provider_flatnumber, provider_name, provider_okpo)
values('Москва','Тимерязевская',15,8,
					 'ООО Офощ тот', '5981561046');
call providers_insert('Москва','Нахимоский проспект', 
					  45, 1, 'ООО «Мясной завод»', '8311967835');
					  
insert into shipments(smeta_kod, provider_kod)
values (1,1);
call shipments_insert(2,2);


insert into ingredientes(ingredient_name)
values ('Свиная шейка'), ('Собственный сок'), ('Мясной маринад'),
('Лук'), ('Чеснок'), ('Говядина'), ('Вода (чистая)'),
('Морковь'), ('Капуста'), ('Приправы'),
('Картофель в обжарке доведенный до угля');
call ingredientes_insert('Соль');
call ingredientes_insert('Куриные крылья');
call ingredientes_insert('Копченные колбаски');
call ingredientes_insert('Помидоры чери');
call ingredientes_insert('Сельдерей');
call ingredientes_insert('Листья салата');
call ingredientes_insert('Оливковое мясо');
call ingredientes_insert('Огурцы');
call ingredientes_insert('яблоки');
call ingredientes_insert('Вяленое мясо');



insert into purchaseingredient(ingredient_weight,
							 shipment_kod, ingredient_kod)
values (50,1,16),(30,1,9),(30,1,21);
call purchaseingredient_insert(150,2,6);
call purchaseingredient_insert(150,2,13);



insert into dishes(dish_name, dish_cost,
				  dish_weight, dish_picture)
values ('Филе порося', 950, 350.00, '-'),	
('Суп мечты', 750, 200.00, '-'),
('Картофель по своему', 120, 120.00, '-');

call dishes_insert('Мясная тарелка', 1670, 1200.00, '-');
call dishes_insert('Гарнир офощной', 950, 350.00, '-');


insert into sostav(dish_kod, ingredient_kod)
values(1, 1),(1,2),(1,3),(1,4),(2,6),(2,7),
(2,8),(2,10),(3,11),(3,5);
call sostav_insert(12,3);
call sostav_insert(13,4);
call sostav_insert(14,4);
call sostav_insert(15,4);
call sostav_insert(2,5);
call sostav_insert(16,5);
call sostav_insert(17,5);
call sostav_insert(18,5);
call sostav_insert(20,5);
call sostav_insert(21,5);




insert into employee(employee_surname, employee_name,
					employee_patronymic, employee_login,
					employee_password)
values ('Семенов',	'Кирилл',	'Николаевич','of_SemenovKN', 'PaSSw0rd'),
		('Дмитриев',	'Олег',	'Иванович',	
		'of_DmitrievOI', 'PaSSw0rd');
call employee_insert('Андреев','Андрей',
					 'of_AndreevAA','PaSSw0rd','Андреевич');



insert into status(status_value)
values('Выдан');
call status_insert('Ожидается');



insert into zones(zona_name)
values ('Общая зона'),('Детская зона');
call zones_insert('Частная зона');


insert into registered_visitors(rv_surname,rv_name,
rv_patronymic,rv_login,rv_password,rv_pasports,
							   rv_pasportn,rv_card, rv_kod)	
values ('Петров',	'Алексей',	'Алексеевич',	'PetrovAA',	
		'PaSSw0rd',	'4678',	'239712',	'565211479921', 'зп1');
call registered_visitors_insert('Павлов',	'Евгений',	
		'Геннадьевич',	'PavlovEG',	
		'PaSSw0rd',	'4515',	'009426',	'313477425677', 'зп2');	
call registered_visitors_insert('Иванов',	'Иван',	
		'Иванович',	'IvanovII',	
		'PaSSw0rd',	'4510',	'665764',	'4825773177881750','зп3');


insert into wood_tables(table_placescount,
					   wood_table_name,zona_kod)
values (4,'ОБ1',1),(4,'ОБ2',1),	
(2,'ОБ3',1),(2,'ОБ4',1);
call wood_tables_insert(5,'д1',2);
call wood_tables_insert(5,'д2',2);
call wood_tables_insert(5,'д3',2);
call wood_tables_insert(4,'ч1',3);
call wood_tables_insert(2,'ч2',3);



insert into visitors(v_surname,v_name,v_patronymic, v_kod)
values ('Фёдоров',	'Владимир',	'Алексеевич', 'п1'),
('Владимиров',	'Андрей',	'Иванович', 'п2');
call visitors_insert('Романова','Екатерина','Анатольевна', 'п3');



insert into orders(order_name,order_dishcount,order_dishtime,order_date,
				   order_opentime,table_kod,employee_kod,status_kod,dish_kod)
values
('ЗКЗ-000000001-23', 2, '14:05:01', '2023.09.01', '14:00:24', 3, 1, 1, 1),
('ЗКЗ-000000001-23', 1, '14:05:34', '2023.09.01', '14:00:24', 3, 1, 1, 2),
('ЗКЗ-000000001-23', 2, '14:05:35', '2023.09.01', '14:00:24', 3, 1, 1, 3),
('ЗКЗ-000000002-23', 1, '16:26:01', '2023.09.01', '16:17:37', 1, 2, 2, 3),
('ЗКЗ-000000002-23', 1, '17:30:16', '2023.09.01', '16:17:37', 1, 2, 2, 1),
('ЗКЗ-000000003-23', 2, '12:18:27', '2023.09.03', '12:10:41', 8, 3, 1, 5);
call orders_insert('ЗКЗ-000000003-23', 1, '12:20:35', '2023.09.03', '12:10:41', 8, 3, 1, 1);
call orders_insert('ЗКЗ-000000003-23', 1, '14:29:53', '2023.09.03', '12:10:41', 8, 3, 1, 4);
call orders_insert('ЗКЗ-000000003-23', 1, '14:29:53', '2023.09.03', '12:10:41', 8, 3, 1, 4);
call orders_insert('ЗКЗ-000000004-23', 3, '16:40:36', '2023.09.04', '16:35:01', 2, 1, 2, 2);
call orders_insert('ЗКЗ-000000004-23', 3, '17:20:13', '2023.09.04', '16:35:01', 2, 1, 2, 2);
call orders_insert('ЗКЗ-000000004-23', 3, '19:40:41', '2023.09.04', '16:35:01', 2, 1, 1, 2);



insert into individualorders(order_kod, v_kod, person_cost)
VALUES
(1,	'Зп1',	1900),
(2,	'П1',	750),
(3,	'П1',	240),
(4,	'Зп1',	120),
(5,	'Зп1',	950),
(6,	'Зп3',	1300);
call  individualorders_insert(7,	'П2',	950);
call  individualorders_insert(8,	'П3',	1670);
call  individualorders_insert(9,	'П3',	1670);
call  individualorders_insert(10,	'Зп3',	1670);
call  individualorders_insert(11,	'Зп3',	1670);
call  individualorders_insert(12,	'Зп3',	1670);


insert into checkues(checkue_number, checkue_date, checkue_time, checkue_sumfinal,
					checkue_sumgotten, checkue_changesum, checkue_paytype, checkue_finalcost, order_kod)
values
('КЧ-0000001/23',	 '2023.09.01',	 '18:56:54',	 3468,	 3500,	 32,	 'Наличный',	 2890,	 1),
('КЧ-0000002/23',	 '2023.09.03',	 '15:21:47',	 5484,	 5484,	 0,	 'Безналичный',	 4570,	 2);
call checkue_insert('КЧ-0000003/23',	 '2023.09.04',	 '20:02:52',	 2700,	 3000,	 300,	 'Наличный',	 2250,	 3);
	end;
$$;
 %   DROP PROCEDURE public.insert_data();
       public          postgres    false            *           1255    24823    orders_delete(integer) 	   PROCEDURE     a  CREATE PROCEDURE public.orders_delete(IN p_order_kod integer)
    LANGUAGE plpgsql
    AS $$
declare meeting_count int := count(*) from checkues where checkues.order_kod = p_order_kod;
	begin
	if (meeting_count > 0) then
			raise notice 'such order is in documentation';
	else
		delete from orders
		where
			order_kod = p_order_kod;
	end if;
	end;
$$;
 =   DROP PROCEDURE public.orders_delete(IN p_order_kod integer);
       public          postgres    false            ]           0    0 /   PROCEDURE orders_delete(IN p_order_kod integer)    ACL     S   GRANT ALL ON PROCEDURE public.orders_delete(IN p_order_kod integer) TO res_waiter;
          public          postgres    false    298            F           1255    26813 �   orders_insert(character varying, integer, time without time zone, date, time without time zone, integer, integer, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.orders_insert(IN p_order_name character varying, IN p_order_dishcount integer, IN p_order_dishtime time without time zone, IN p_order_date date, IN p_order_opentime time without time zone, IN p_table_kod integer, IN p_empoyee_kod integer, IN p_status_kod integer, IN p_dish_kod integer)
    LANGUAGE plpgsql
    AS $$
	declare total_cost decimal(7,2)=  sum(dish_cost * p_order_dishcount) from orders 
	join dishes on dishes.dish_kod = p_dish_kod
	where order_name = p_order_name;
	begin
		update checkues set
		checkue_sumfinal = total_cost
		where checkues.order_name = p_order_name;
		insert into orders(order_name, order_dishcount, order_dishtime, order_date, order_opentime, table_kod,employee_kod,
						  status_kod, dish_kod)
		values (p_order_name, p_order_dishcount, 
										  p_order_dishtime, p_order_date,
										  p_order_opentime,  p_table_kod,p_empoyee_kod,   
										  p_status_kod, p_dish_kod);
	end;
$$;
 6  DROP PROCEDURE public.orders_insert(IN p_order_name character varying, IN p_order_dishcount integer, IN p_order_dishtime time without time zone, IN p_order_date date, IN p_order_opentime time without time zone, IN p_table_kod integer, IN p_empoyee_kod integer, IN p_status_kod integer, IN p_dish_kod integer);
       public          postgres    false            4           1255    26504 �   orders_update(character varying, integer, time without time zone, date, time without time zone, integer, integer, integer, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.orders_update(IN p_order_name character varying, IN p_order_dishcount integer, IN p_order_dishtime time without time zone, IN p_order_date date, IN p_order_opentime time without time zone, IN p_table_kod integer, IN p_employee_kod integer, IN p_status_kod integer, IN p_dish_kod integer, IN p_order_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin
		update orders set
		order_name = p_order_name,
		order_dishcount = p_order_dishcount,
		order_dishtime = p_order_dishtime,
		order_date = p_order_date,
		order_opentime = p_order_opentime,
		table_kod = p_table_kod,
		employee_kod = p_employee_kod,
		status_kod = p_status_kod,
		dish_kod  = p_dish_kod
		where
			order_kod = p_order_kod;
	end;
$$;
 O  DROP PROCEDURE public.orders_update(IN p_order_name character varying, IN p_order_dishcount integer, IN p_order_dishtime time without time zone, IN p_order_date date, IN p_order_opentime time without time zone, IN p_table_kod integer, IN p_employee_kod integer, IN p_status_kod integer, IN p_dish_kod integer, IN p_order_kod integer);
       public          postgres    false            C           1255    26844    planning_dishes_delete(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.planning_dishes_delete(IN p_planning_dishes_kod integer)
    LANGUAGE plpgsql
    AS $$
begin
		 delete from planning_dishes 
		 where planning_dishes_kod = p_planning_dishes_kod;
	end;
$$;
 P   DROP PROCEDURE public.planning_dishes_delete(IN p_planning_dishes_kod integer);
       public          postgres    false            ^           0    0 B   PROCEDURE planning_dishes_delete(IN p_planning_dishes_kod integer)    ACL     �   GRANT ALL ON PROCEDURE public.planning_dishes_delete(IN p_planning_dishes_kod integer) TO res_guest;
GRANT ALL ON PROCEDURE public.planning_dishes_delete(IN p_planning_dishes_kod integer) TO res_dguest;
          public          postgres    false    323            I           1255    35056 S   planning_dishes_insert(time without time zone, integer, character varying, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.planning_dishes_insert(IN p_planning_dishes_time time without time zone, IN p_dish_kod integer, IN p_book_number character varying, IN p_dishes_count integer)
    LANGUAGE plpgsql
    AS $$
begin
		 insert into planning_dishes(planning_dishes_time, dish_kod, book_number, dishes_count) 
		 values (p_planning_dishes_time, p_dish_kod, p_book_number, p_dishes_count);
	end;
$$;
 �   DROP PROCEDURE public.planning_dishes_insert(IN p_planning_dishes_time time without time zone, IN p_dish_kod integer, IN p_book_number character varying, IN p_dishes_count integer);
       public          postgres    false            B           1255    26845 I   planning_dishes_update(time without time zone, integer, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.planning_dishes_update(IN p_planning_dishes_time time without time zone, IN p_dish_kod integer, IN p_book_kod integer, IN p_planning_dishes_kod integer)
    LANGUAGE plpgsql
    AS $$
begin
		 update planning_dishes set
		 planning_dishes_time = p_planning_dishes_time,
		 dish_kod = p_dish_kod,
		 book_kod = p_book_kod
		 where planning_dishes_kod = p_planning_dishes_kod;
	end;
$$;
 �   DROP PROCEDURE public.planning_dishes_update(IN p_planning_dishes_time time without time zone, IN p_dish_kod integer, IN p_book_kod integer, IN p_planning_dishes_kod integer);
       public          postgres    false            _           0    0 �   PROCEDURE planning_dishes_update(IN p_planning_dishes_time time without time zone, IN p_dish_kod integer, IN p_book_kod integer, IN p_planning_dishes_kod integer)    ACL     �  GRANT ALL ON PROCEDURE public.planning_dishes_update(IN p_planning_dishes_time time without time zone, IN p_dish_kod integer, IN p_book_kod integer, IN p_planning_dishes_kod integer) TO res_guest;
GRANT ALL ON PROCEDURE public.planning_dishes_update(IN p_planning_dishes_time time without time zone, IN p_dish_kod integer, IN p_book_kod integer, IN p_planning_dishes_kod integer) TO res_dguest;
          public          postgres    false    322            @           1255    26847    planning_orders_delete(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.planning_orders_delete(IN p_planning_order_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin 
		 delete from planning_orders 
		 where planning_order_kod = p_planning_order_kod;
	end;
$$;
 O   DROP PROCEDURE public.planning_orders_delete(IN p_planning_order_kod integer);
       public          postgres    false            `           0    0 A   PROCEDURE planning_orders_delete(IN p_planning_order_kod integer)    ACL     d   GRANT ALL ON PROCEDURE public.planning_orders_delete(IN p_planning_order_kod integer) TO res_guest;
          public          postgres    false    320            ?           1255    26841 (   planning_orders_insert(integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.planning_orders_insert(IN p_order_kod integer, IN p_book_kod integer)
    LANGUAGE plpgsql
    AS $$
declare meeting_count int := count(*) from planning_orders 
where order_kod = p_order_kod and book_kod = p_book_kod;
	begin 
	if (meeting_count > 0) then
	raise notice 'this plan is made';
	else
		 insert into booking(order_kod, book_kod) 
		 values (p_order_kod, p_book_kod);
	end if;
	end;
$$;
 ]   DROP PROCEDURE public.planning_orders_insert(IN p_order_kod integer, IN p_book_kod integer);
       public          postgres    false            a           0    0 O   PROCEDURE planning_orders_insert(IN p_order_kod integer, IN p_book_kod integer)    ACL     r   GRANT ALL ON PROCEDURE public.planning_orders_insert(IN p_order_kod integer, IN p_book_kod integer) TO res_guest;
          public          postgres    false    319            A           1255    26842 1   planning_orders_update(integer, integer, integer) 	   PROCEDURE     e  CREATE PROCEDURE public.planning_orders_update(IN p_order_kod integer, IN p_book_kod integer, IN p_planning_order_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin 
		 update planning_orders set
		 order_kod = p_order_kod,
		 book_kod = p_book_kod,
		 planning_order_kod = p_planning_order_kod
		 where planning_order_kod = p_planning_order_kod;
	end;
$$;
 ~   DROP PROCEDURE public.planning_orders_update(IN p_order_kod integer, IN p_book_kod integer, IN p_planning_order_kod integer);
       public          postgres    false            b           0    0 p   PROCEDURE planning_orders_update(IN p_order_kod integer, IN p_book_kod integer, IN p_planning_order_kod integer)    ACL     �   GRANT ALL ON PROCEDURE public.planning_orders_update(IN p_order_kod integer, IN p_book_kod integer, IN p_planning_order_kod integer) TO res_guest;
          public          postgres    false    321                       1255    24826    providers_delete(integer) 	   PROCEDURE     j  CREATE PROCEDURE public.providers_delete(IN p_provider_kod integer)
    LANGUAGE plpgsql
    AS $$
declare meeting_count int := count(*) from shipments where shipments.provider_kod = p_provider_kod;
	begin
	if (meeting_count > 0) then
			raise notice 'provider is used';
	else
		delete from providers
		where
			provider_kod = p_provider_kod;
	end if;
	end;
$$;
 C   DROP PROCEDURE public.providers_delete(IN p_provider_kod integer);
       public          postgres    false            c           0    0 5   PROCEDURE providers_delete(IN p_provider_kod integer)    ACL     �   GRANT ALL ON PROCEDURE public.providers_delete(IN p_provider_kod integer) TO res_chef;
GRANT ALL ON PROCEDURE public.providers_delete(IN p_provider_kod integer) TO res_administrator;
          public          postgres    false    278            0           1255    24824 n   providers_insert(character varying, character varying, integer, integer, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.providers_insert(IN p_provider_city character varying, IN p_provider_street character varying, IN p_provider_house integer, IN p_provider_flatnumber integer, IN p_provider_name character varying, IN p_provider_okpo character varying)
    LANGUAGE plpgsql
    AS $$
declare meeting_count int := count(*) from providers where provider_name = p_provider_name;

	begin
	if (meeting_count > 0) then
			raise notice 'such provider if made';
	else
		insert into providers(provider_city, provider_street, provider_house, provider_flatnumber,
											provider_name, provider_okpo)
		values (p_provider_city, p_provider_street, p_provider_house, p_provider_flatnumber,
											p_provider_name, p_provider_okpo);
	end if;
	end;
$$;
   DROP PROCEDURE public.providers_insert(IN p_provider_city character varying, IN p_provider_street character varying, IN p_provider_house integer, IN p_provider_flatnumber integer, IN p_provider_name character varying, IN p_provider_okpo character varying);
       public          postgres    false            d           0    0 �   PROCEDURE providers_insert(IN p_provider_city character varying, IN p_provider_street character varying, IN p_provider_house integer, IN p_provider_flatnumber integer, IN p_provider_name character varying, IN p_provider_okpo character varying)    ACL     3  GRANT ALL ON PROCEDURE public.providers_insert(IN p_provider_city character varying, IN p_provider_street character varying, IN p_provider_house integer, IN p_provider_flatnumber integer, IN p_provider_name character varying, IN p_provider_okpo character varying) TO res_chef;
GRANT ALL ON PROCEDURE public.providers_insert(IN p_provider_city character varying, IN p_provider_street character varying, IN p_provider_house integer, IN p_provider_flatnumber integer, IN p_provider_name character varying, IN p_provider_okpo character varying) TO res_administrator;
          public          postgres    false    304            5           1255    24825 w   providers_update(character varying, character varying, integer, integer, character varying, character varying, integer) 	   PROCEDURE     q  CREATE PROCEDURE public.providers_update(IN p_provider_city character varying, IN p_provider_street character varying, IN p_provider_house integer, IN p_provider_flatnumber integer, IN p_provider_name character varying, IN p_provider_okpo character varying, IN p_provider_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin
		update providers set
		provider_city = p_provider_city,
		provider_street = p_provider_street,
		provider_house = p_provider_house,
		provider_flatnumber = p_provider_flatnumber,
		provider_name = p_provider_name,
		provider_okpo = p_provider_okpo
		where
			provider_kod = p_provider_kod;
	end;
$$;
   DROP PROCEDURE public.providers_update(IN p_provider_city character varying, IN p_provider_street character varying, IN p_provider_house integer, IN p_provider_flatnumber integer, IN p_provider_name character varying, IN p_provider_okpo character varying, IN p_provider_kod integer);
       public          postgres    false            e           0    0   PROCEDURE providers_update(IN p_provider_city character varying, IN p_provider_street character varying, IN p_provider_house integer, IN p_provider_flatnumber integer, IN p_provider_name character varying, IN p_provider_okpo character varying, IN p_provider_kod integer)    ACL     i  GRANT ALL ON PROCEDURE public.providers_update(IN p_provider_city character varying, IN p_provider_street character varying, IN p_provider_house integer, IN p_provider_flatnumber integer, IN p_provider_name character varying, IN p_provider_okpo character varying, IN p_provider_kod integer) TO res_chef;
GRANT ALL ON PROCEDURE public.providers_update(IN p_provider_city character varying, IN p_provider_street character varying, IN p_provider_house integer, IN p_provider_flatnumber integer, IN p_provider_name character varying, IN p_provider_okpo character varying, IN p_provider_kod integer) TO res_administrator;
          public          postgres    false    309                       1255    24829 "   purchaseingredient_delete(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.purchaseingredient_delete(IN p_purchase_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin
		delete from purchaseingredient
		where
			purchase_kod = p_purchase_kod;
	end;
$$;
 L   DROP PROCEDURE public.purchaseingredient_delete(IN p_purchase_kod integer);
       public          postgres    false            f           0    0 >   PROCEDURE purchaseingredient_delete(IN p_purchase_kod integer)    ACL     `   GRANT ALL ON PROCEDURE public.purchaseingredient_delete(IN p_purchase_kod integer) TO res_chef;
          public          postgres    false    277            /           1255    24827 4   purchaseingredient_insert(integer, integer, integer) 	   PROCEDURE     +  CREATE PROCEDURE public.purchaseingredient_insert(IN p_ingredient_weight integer, IN p_shipment_kod integer, IN p_ingredient_kod integer)
    LANGUAGE plpgsql
    AS $$
declare meeting_count int := count(*) from purchaseingredient 
where shipment_kod = p_shipment_kod and ingredient_kod = p_ingredient_kod;
	begin
	if (meeting_count > 0) then
			raise notice 'such purchase is made';
	else
		insert into purchaseingredient(ingredient_weight,shipment_kod,ingredient_kod)
		values (p_ingredient_weight, p_shipment_kod, p_ingredient_kod);
	end if;
	end;
$$;
 �   DROP PROCEDURE public.purchaseingredient_insert(IN p_ingredient_weight integer, IN p_shipment_kod integer, IN p_ingredient_kod integer);
       public          postgres    false            g           0    0 {   PROCEDURE purchaseingredient_insert(IN p_ingredient_weight integer, IN p_shipment_kod integer, IN p_ingredient_kod integer)    ACL     C  GRANT ALL ON PROCEDURE public.purchaseingredient_insert(IN p_ingredient_weight integer, IN p_shipment_kod integer, IN p_ingredient_kod integer) TO res_chef;
GRANT ALL ON PROCEDURE public.purchaseingredient_insert(IN p_ingredient_weight integer, IN p_shipment_kod integer, IN p_ingredient_kod integer) TO res_administrator;
          public          postgres    false    303                       1255    24828 =   purchaseingredient_update(integer, integer, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.purchaseingredient_update(IN p_ingredient_weight integer, IN p_shipment_kod integer, IN p_ingredient_kod integer, IN p_purchase_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin
		update purchaseingredient set
		ingredient_weight = p_ingredient_weight,
		shipment_kod = p_shipment_kod,
		ingredient_kod = p_ingredient_kod
		where
			purchase_kod = p_purchase_kod;
	end;
$$;
 �   DROP PROCEDURE public.purchaseingredient_update(IN p_ingredient_weight integer, IN p_shipment_kod integer, IN p_ingredient_kod integer, IN p_purchase_kod integer);
       public          postgres    false            h           0    0 �   PROCEDURE purchaseingredient_update(IN p_ingredient_weight integer, IN p_shipment_kod integer, IN p_ingredient_kod integer, IN p_purchase_kod integer)    ACL     �   GRANT ALL ON PROCEDURE public.purchaseingredient_update(IN p_ingredient_weight integer, IN p_shipment_kod integer, IN p_ingredient_kod integer, IN p_purchase_kod integer) TO res_chef;
          public          postgres    false    276            7           1255    26494 -   registered_visitors_delete(character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.registered_visitors_delete(IN p_rv_kod character varying)
    LANGUAGE plpgsql
    AS $$
	begin
		delete from registered_visitors
		where
				rv_kod = p_rv_kod;
	end;
$$;
 Q   DROP PROCEDURE public.registered_visitors_delete(IN p_rv_kod character varying);
       public          postgres    false            i           0    0 C   PROCEDURE registered_visitors_delete(IN p_rv_kod character varying)    ACL     n   GRANT ALL ON PROCEDURE public.registered_visitors_delete(IN p_rv_kod character varying) TO res_administrator;
          public          postgres    false    311            +           1255    24987 �   registered_visitors_insert(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.registered_visitors_insert(IN p_rv_surname character varying, IN p_rv_name character varying, IN p_rv_patronymic character varying, IN p_rv_login character varying, IN p_rv_password character varying, IN p_rv_pasports character varying, IN p_rv_pasportn character varying, IN p_rv_card character varying, IN p_rv_kod character varying)
    LANGUAGE plpgsql
    AS $$
	declare meeting_count int := count(*) from registered_visitors where rv_login = p_rv_login;
	begin
		if (meeting_count > 0) then
			raise notice 'such person is added';
		else
		insert into registered_visitors(rv_surname, rv_name, 
													  rv_patronymic, rv_login, 
													rv_password,  rv_pasports,
													  rv_pasportn, rv_card, rv_kod)
		values (p_rv_surname, p_rv_name, 
							p_rv_patronymic, p_rv_login, 
							p_rv_password,  p_rv_pasports,
							p_rv_pasportn, p_rv_card, p_rv_kod);
	end if;
	end;
$$;
 g  DROP PROCEDURE public.registered_visitors_insert(IN p_rv_surname character varying, IN p_rv_name character varying, IN p_rv_patronymic character varying, IN p_rv_login character varying, IN p_rv_password character varying, IN p_rv_pasports character varying, IN p_rv_pasportn character varying, IN p_rv_card character varying, IN p_rv_kod character varying);
       public          postgres    false            j           0    0 Y  PROCEDURE registered_visitors_insert(IN p_rv_surname character varying, IN p_rv_name character varying, IN p_rv_patronymic character varying, IN p_rv_login character varying, IN p_rv_password character varying, IN p_rv_pasports character varying, IN p_rv_pasportn character varying, IN p_rv_card character varying, IN p_rv_kod character varying)    ACL     |  GRANT ALL ON PROCEDURE public.registered_visitors_insert(IN p_rv_surname character varying, IN p_rv_name character varying, IN p_rv_patronymic character varying, IN p_rv_login character varying, IN p_rv_password character varying, IN p_rv_pasports character varying, IN p_rv_pasportn character varying, IN p_rv_card character varying, IN p_rv_kod character varying) TO res_waiter;
GRANT ALL ON PROCEDURE public.registered_visitors_insert(IN p_rv_surname character varying, IN p_rv_name character varying, IN p_rv_patronymic character varying, IN p_rv_login character varying, IN p_rv_password character varying, IN p_rv_pasports character varying, IN p_rv_pasportn character varying, IN p_rv_card character varying, IN p_rv_kod character varying) TO res_chef;
GRANT ALL ON PROCEDURE public.registered_visitors_insert(IN p_rv_surname character varying, IN p_rv_name character varying, IN p_rv_patronymic character varying, IN p_rv_login character varying, IN p_rv_password character varying, IN p_rv_pasports character varying, IN p_rv_pasportn character varying, IN p_rv_card character varying, IN p_rv_kod character varying) TO res_administrator;
          public          postgres    false    299            6           1255    24988 �   registered_visitors_update(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.registered_visitors_update(IN p_rv_surname character varying, IN p_rv_name character varying, IN p_rv_patronymic character varying, IN p_rv_login character varying, IN p_rv_password character varying, IN p_rv_pasports character varying, IN p_rv_pasportn character varying, IN p_rv_card character varying, IN p_rv_kod character varying)
    LANGUAGE plpgsql
    AS $$
	begin
		update registered_visitors set
		rv_surname = p_rv_surname,
		rv_name = p_rv_name,
		rv_patronymic = p_rv_patronymic,
		rv_login = p_rv_login,
		rv_password = p_rv_password,
		rv_pasports = p_rv_pasports,
		rv_pasportn = p_rv_pasportn,
		rv_card = p_rv_card
		where
			rv_kod = p_rv_kod;
	end;
$$;
 g  DROP PROCEDURE public.registered_visitors_update(IN p_rv_surname character varying, IN p_rv_name character varying, IN p_rv_patronymic character varying, IN p_rv_login character varying, IN p_rv_password character varying, IN p_rv_pasports character varying, IN p_rv_pasportn character varying, IN p_rv_card character varying, IN p_rv_kod character varying);
       public          postgres    false            k           0    0 Y  PROCEDURE registered_visitors_update(IN p_rv_surname character varying, IN p_rv_name character varying, IN p_rv_patronymic character varying, IN p_rv_login character varying, IN p_rv_password character varying, IN p_rv_pasports character varying, IN p_rv_pasportn character varying, IN p_rv_card character varying, IN p_rv_kod character varying)    ACL     }  GRANT ALL ON PROCEDURE public.registered_visitors_update(IN p_rv_surname character varying, IN p_rv_name character varying, IN p_rv_patronymic character varying, IN p_rv_login character varying, IN p_rv_password character varying, IN p_rv_pasports character varying, IN p_rv_pasportn character varying, IN p_rv_card character varying, IN p_rv_kod character varying) TO res_waiter;
GRANT ALL ON PROCEDURE public.registered_visitors_update(IN p_rv_surname character varying, IN p_rv_name character varying, IN p_rv_patronymic character varying, IN p_rv_login character varying, IN p_rv_password character varying, IN p_rv_pasports character varying, IN p_rv_pasportn character varying, IN p_rv_card character varying, IN p_rv_kod character varying) TO res_guest;
GRANT ALL ON PROCEDURE public.registered_visitors_update(IN p_rv_surname character varying, IN p_rv_name character varying, IN p_rv_patronymic character varying, IN p_rv_login character varying, IN p_rv_password character varying, IN p_rv_pasports character varying, IN p_rv_pasportn character varying, IN p_rv_card character varying, IN p_rv_kod character varying) TO res_administrator;
          public          postgres    false    310            &           1255    24839    shipments_delete(integer) 	   PROCEDURE     n  CREATE PROCEDURE public.shipments_delete(IN p_shipment_kod integer)
    LANGUAGE plpgsql
    AS $$
	declare meeting_count int := count(*) from purchaseingredient where shipment_kod = p_shipment_kod;
	begin
		if (meeting_count > 0) then
			raise notice 'shipment is used';
		else
		delete from shipments
		where
				shipment_kod = p_shipment_kod;
		end if;
	end;
$$;
 C   DROP PROCEDURE public.shipments_delete(IN p_shipment_kod integer);
       public          postgres    false            l           0    0 5   PROCEDURE shipments_delete(IN p_shipment_kod integer)    ACL     W   GRANT ALL ON PROCEDURE public.shipments_delete(IN p_shipment_kod integer) TO res_chef;
          public          postgres    false    294                       1255    24837 "   shipments_insert(integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.shipments_insert(IN p_smeta_kod integer, IN p_provider_kod integer)
    LANGUAGE plpgsql
    AS $$
	declare meeting_count int := count(*) from shipments 
	where smeta_kod = p_smeta_kod and provider_kod = p_provider_kod;
	begin
		if (meeting_count > 0) then
			raise notice 'such shipment is made';
		else
		insert into shipments(smeta_kod, provider_kod)
		values (p_smeta_kod, p_provider_kod);
		end if;
	end;
$$;
 [   DROP PROCEDURE public.shipments_insert(IN p_smeta_kod integer, IN p_provider_kod integer);
       public          postgres    false            m           0    0 M   PROCEDURE shipments_insert(IN p_smeta_kod integer, IN p_provider_kod integer)    ACL     o   GRANT ALL ON PROCEDURE public.shipments_insert(IN p_smeta_kod integer, IN p_provider_kod integer) TO res_chef;
          public          postgres    false    279            "           1255    24838 +   shipments_update(integer, integer, integer) 	   PROCEDURE     #  CREATE PROCEDURE public.shipments_update(IN p_smeta_kod integer, IN p_provider_kod integer, IN p_shipment_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin
		update shipments set
		smeta_kod = p_smeta_kod,
		provider_kod = p_provider_kod
		where
			shipment_kod = p_shipment_kod;
	end;
$$;
 v   DROP PROCEDURE public.shipments_update(IN p_smeta_kod integer, IN p_provider_kod integer, IN p_shipment_kod integer);
       public          postgres    false            n           0    0 h   PROCEDURE shipments_update(IN p_smeta_kod integer, IN p_provider_kod integer, IN p_shipment_kod integer)    ACL     �   GRANT ALL ON PROCEDURE public.shipments_update(IN p_smeta_kod integer, IN p_provider_kod integer, IN p_shipment_kod integer) TO res_chef;
          public          postgres    false    290            <           1255    24843    smeta_delete(integer) 	   PROCEDURE     P  CREATE PROCEDURE public.smeta_delete(IN p_smeta_kod integer)
    LANGUAGE plpgsql
    AS $$
	declare meeting_count int := count(*) from shipments where smeta_kod = p_smeta_kod;
	begin
		if (meeting_count > 0) then
			raise notice 'such smeta is used';
		else
		delete from smeta
		where
				smeta_kod = p_smeta_kod;
		end if;
	end;
$$;
 <   DROP PROCEDURE public.smeta_delete(IN p_smeta_kod integer);
       public          postgres    false            o           0    0 .   PROCEDURE smeta_delete(IN p_smeta_kod integer)    ACL     �   GRANT ALL ON PROCEDURE public.smeta_delete(IN p_smeta_kod integer) TO res_chef;
GRANT ALL ON PROCEDURE public.smeta_delete(IN p_smeta_kod integer) TO res_administrator;
          public          postgres    false    316            :           1255    24841 %   smeta_insert(date, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.smeta_insert(IN p_smeta_date date, IN p_smeta_number character varying)
    LANGUAGE plpgsql
    AS $$
	declare meeting_count int := count(*) from smeta where smeta_number = p_smeta_number;
	begin
		if (meeting_count > 0) then
			raise notice 'such smeta is made';
		else
		insert into smeta(smeta_date, smeta_number)
		values (p_smeta_date, p_smeta_number);
		end if;
	end;
$$;
 _   DROP PROCEDURE public.smeta_insert(IN p_smeta_date date, IN p_smeta_number character varying);
       public          postgres    false            p           0    0 Q   PROCEDURE smeta_insert(IN p_smeta_date date, IN p_smeta_number character varying)    ACL     �   GRANT ALL ON PROCEDURE public.smeta_insert(IN p_smeta_date date, IN p_smeta_number character varying) TO res_chef;
GRANT ALL ON PROCEDURE public.smeta_insert(IN p_smeta_date date, IN p_smeta_number character varying) TO res_administrator;
          public          postgres    false    314            8           1255    24842 .   smeta_update(date, character varying, integer) 	   PROCEDURE       CREATE PROCEDURE public.smeta_update(IN p_smeta_date date, IN p_smeta_number character varying, IN p_smeta_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin
		update smeta set
		smeta_date = p_smeta_date,
		smeta_number = p_smeta_number
		where
			smeta_kod = p_smeta_kod;
	end;
$$;
 w   DROP PROCEDURE public.smeta_update(IN p_smeta_date date, IN p_smeta_number character varying, IN p_smeta_kod integer);
       public          postgres    false            q           0    0 i   PROCEDURE smeta_update(IN p_smeta_date date, IN p_smeta_number character varying, IN p_smeta_kod integer)    ACL       GRANT ALL ON PROCEDURE public.smeta_update(IN p_smeta_date date, IN p_smeta_number character varying, IN p_smeta_kod integer) TO res_chef;
GRANT ALL ON PROCEDURE public.smeta_update(IN p_smeta_date date, IN p_smeta_number character varying, IN p_smeta_kod integer) TO res_administrator;
          public          postgres    false    312            $           1255    24846    sostav_delete(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.sostav_delete(IN p_sostav_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin
		delete from sostav
		where
				sostav_kod = p_sostav_kod;
	end;
$$;
 >   DROP PROCEDURE public.sostav_delete(IN p_sostav_kod integer);
       public          postgres    false            r           0    0 0   PROCEDURE sostav_delete(IN p_sostav_kod integer)    ACL     R   GRANT ALL ON PROCEDURE public.sostav_delete(IN p_sostav_kod integer) TO res_chef;
          public          postgres    false    292            %           1255    24844    sostav_insert(integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.sostav_insert(IN p_ingredient_kod integer, IN p_dish_kod integer)
    LANGUAGE plpgsql
    AS $$
declare count_of_usage int = count(*) from sostav
where 
ingredient_kod = p_ingredient_kod and
dish_kod = p_dish_kod;
	begin 
	if (count_of_usage > 0) then
	raise notice 'такой ингредмент уже есть у блюда';
	else
		insert into sostav(ingredient_kod, dish_kod)
		values (p_ingredient_kod, p_dish_kod);
	end if;
	end;
$$;
 Y   DROP PROCEDURE public.sostav_insert(IN p_ingredient_kod integer, IN p_dish_kod integer);
       public          postgres    false            s           0    0 K   PROCEDURE sostav_insert(IN p_ingredient_kod integer, IN p_dish_kod integer)    ACL     m   GRANT ALL ON PROCEDURE public.sostav_insert(IN p_ingredient_kod integer, IN p_dish_kod integer) TO res_chef;
          public          postgres    false    293            #           1255    24845 (   sostav_update(integer, integer, integer) 	   PROCEDURE       CREATE PROCEDURE public.sostav_update(IN p_ingredient_kod integer, IN p_dish_kod integer, IN p_sostav_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin
		update sostav set
		ingredient_kod = p_ingredient_kod,
		dish_kod = p_dish_kod
		where
			sostav_kod = p_sostav_kod;
	end;
$$;
 r   DROP PROCEDURE public.sostav_update(IN p_ingredient_kod integer, IN p_dish_kod integer, IN p_sostav_kod integer);
       public          postgres    false            t           0    0 d   PROCEDURE sostav_update(IN p_ingredient_kod integer, IN p_dish_kod integer, IN p_sostav_kod integer)    ACL     �   GRANT ALL ON PROCEDURE public.sostav_update(IN p_ingredient_kod integer, IN p_dish_kod integer, IN p_sostav_kod integer) TO res_chef;
          public          postgres    false    291                       1255    24861    status_delete(integer) 	   PROCEDURE     T  CREATE PROCEDURE public.status_delete(IN p_status_kod integer)
    LANGUAGE plpgsql
    AS $$
	declare meeting_count int := count(*) from orders where status_kod = p_status_kod;
	begin
		if (meeting_count > 0) then
			raise notice 'such status is used';
		else
		delete from status
		where
			status_kod = p_status_kod;
		end if;
	end;
$$;
 >   DROP PROCEDURE public.status_delete(IN p_status_kod integer);
       public          postgres    false            u           0    0 0   PROCEDURE status_delete(IN p_status_kod integer)    ACL     T   GRANT ALL ON PROCEDURE public.status_delete(IN p_status_kod integer) TO res_waiter;
          public          postgres    false    280            !           1255    24859     status_insert(character varying) 	   PROCEDURE     f  CREATE PROCEDURE public.status_insert(IN p_status_value character varying)
    LANGUAGE plpgsql
    AS $$
	declare meeting_count int := count(*) from status where status_value = p_status_value;
	begin
		if (meeting_count > 0) then
			raise notice 'such dish is used'; 
		else
		insert into status(status_value)
		values (p_status_value);
		end if;
	end;
$$;
 J   DROP PROCEDURE public.status_insert(IN p_status_value character varying);
       public          postgres    false            v           0    0 <   PROCEDURE status_insert(IN p_status_value character varying)    ACL     `   GRANT ALL ON PROCEDURE public.status_insert(IN p_status_value character varying) TO res_waiter;
          public          postgres    false    289                       1255    24860 )   status_update(character varying, integer) 	   PROCEDURE     �   CREATE PROCEDURE public.status_update(IN p_status_value character varying, IN p_status_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin
		update status set
		status_value = p_status_value
		where
			status_kod = p_status_kod;
	end;
$$;
 c   DROP PROCEDURE public.status_update(IN p_status_value character varying, IN p_status_kod integer);
       public          postgres    false            w           0    0 U   PROCEDURE status_update(IN p_status_value character varying, IN p_status_kod integer)    ACL     y   GRANT ALL ON PROCEDURE public.status_update(IN p_status_value character varying, IN p_status_kod integer) TO res_waiter;
          public          postgres    false    281                       1255    25019    structure_create() 	   PROCEDURE     C&  CREATE PROCEDURE public.structure_create()
    LANGUAGE plpgsql
    AS $$
    
    begin
create table if not exists Employee 
(
	Employee_kod Serial not null constraint PK_Employee primary key,
	Employee_surname Varchar(50) not null,
	Employee_name Varchar(50) not null,
	Employee_patronymic Varchar(50) null,
	Employee_login Varchar(50) not null,
	Employee_password Varchar(50) not null
);

create table if not exists Registered_Visitors
(
	RV_surname Varchar(50) not null,
	RV_name Varchar(50) not null,
	RV_patronymic Varchar(50) null,
	RV_login Varchar(50) not null,
	RV_password Varchar(50) not null,
	RV_pasportS Varchar(5) not null,
	RV_pasportN Varchar(6) not null,
	RV_card Varchar(19) not null,
	RV_kod varchar(5) not null constraint PK_Registered_Visitors primary key
);
create table if not exists Visitors
(
	V_surname Varchar(50) not null,
	V_name Varchar(50) not null,
	V_patronymic Varchar(50) null,
	V_kod varchar(5) not null constraint PK_Visitors primary key
);
create table if not exists Providers
(
	Provider_city Varchar(50) not null,
	Provider_street Varchar(50) not null,
	Provider_house Int not null,
	Provider_flatNumber Int not null,
	Provider_name Varchar(50) not null,
	Provider_okpo Varchar(10) not null,
	Provider_kod Serial not null constraint PK_Providers primary key
);
create table if not exists Smeta
(
	Smeta_date Date not null,
	Smeta_number Varchar(13),
	Smeta_kod Serial not null constraint PK_Smeta primary key
);
create table if not exists Dishes
(
	Dish_name Varchar(50) not null,
	Dish_cost Int not null,
	Dish_weight Decimal(6,2) not null,
	Dish_picture Varchar(1) not null,
	Dish_kod Serial not null constraint PK_Dishes primary key
);
create table if not exists Status
(
	Status_value Varchar(50) not null,
	Status_kod Serial not null constraint PK_Status primary key
);
create table if not exists Zones
(
	Zona_name Varchar(100) not null,
	Zona_kod Serial not null constraint PK_Zones primary key
);
create table if not exists Ingredientes
(
	Ingredient_name Varchar(50) not null,
	Ingredient_kod Serial not null constraint PK_Ingredientes primary key
);
create table if not exists Wood_tables
(
	Table_placesCount Int not null,
	Wood_table_name Varchar(4) not null,
	Table_kod Serial not null constraint PK_Wood_Tables primary key,
    Zona_kod Int not null references Zones(Zona_kod)
);
create table if not exists Orders
(
	Order_name Varchar(16) not null,
	Order_dishCount Int not null,
	Order_dishTime Time not null,
	Order_date Date not null,
	Order_openTime Time not null,
	Order_kod Serial not null constraint PK_Orders primary key,
	Table_kod Int not null references Wood_tables (Table_kod),
	Employee_kod Int not null references Employee (Employee_kod),
	Status_kod Int not null references Status (Status_kod),
	dish_kod Int not null references dishes(dish_kod)
);
create table if not exists Checkues
(
	Checkue_number Varchar(13) not null,
	Checkue_date Date not null,
	Checkue_time Time not null,
	Checkue_sumFinal Int not null,
	Checkue_sumGotten Int not null,
	Checkue_changeSum Int not null,
	Checkue_PayType Varchar(50) not null,
	Checkue_finalCost Int not null,
	Checkue_kod Serial not null constraint PK_Checkues primary key,
	Order_kod Int not null references Orders(Order_kod)

);
create table if not exists IndividualOrders
(
	IndividualOrder_kod Serial not null constraint PK_IndividualOrders primary key,
	Order_kod Int not null references Orders(Order_kod),
	V_kod varchar(5) not null,
	person_cost Int not null
);
create table if not exists Shipments
(
Shipment_kod Serial not null constraint PK_Shipments primary key,
Smeta_kod Int not null references Smeta (Smeta_kod),
Provider_kod Int not null references Providers(Provider_kod)
);
create table if not exists PurchaseIngredient
(
Purchase_kod Serial not null constraint PK_PurchaseIngredient primary key,
Ingredient_weight Int not null,
Shipment_kod Int not null references Shipments (Shipment_kod),
Ingredient_kod Int not null references Ingredientes(Ingredient_kod)
);

create table if not exists Sostav
(
Sostav_kod Serial not null constraint PK_Sostav primary key,
Ingredient_kod Int not null references Ingredientes(Ingredient_kod),
Dish_kod Int not null references Dishes(Dish_kod)
);
create index if not exists index_kod_sostav on Sostav(Sostav_kod);
create index if not exists index_kod_Shipments on Shipments(Shipment_kod);
create index if not exists index_kod_PurchaseIngredient on PurchaseIngredient (Purchase_kod);
create index if not exists index_kod_IndividualOrders on IndividualOrders(IndividualOrder_kod);
create index if not exists index_kod_ingredient on ingredientes(ingredient_kod);
create index if not exists index_name_ingredient on ingredientes(ingredient_name);
create index if not exists index_kod_zones on zones(zona_kod);
create index if not exists index_name_zones on zones(zona_kod);
create index if not exists index_kod_status on status(status_kod);
create index if not exists index_name_dish on dishes(dish_name);
create index if not exists index_kod_dish on dishes(dish_kod);
create index if not exists index_name_table on wood_tables(wood_table_name);
create index if not exists index_kod_table on wood_tables (table_kod);
create index if not exists index_number_smeta on smeta (smeta_number);
create index if not exists index_kod_smeta on smeta (smeta_kod);
create index if not exists index_location_provider on providers (provider_city, provider_street, provider_house, provider_flatnumber);
create index if not exists index_name_provider on providers (provider_name);
create index if not exists index_okpo_provider on providers (provider_okpo);
create index if not exists index_kod_provider on providers (provider_kod);
create index if not exists index_number_checkue on checkues (checkue_number);
create index if not exists index_date_time_checkue on checkues (checkue_date, checkue_time);
create index if not exists index_kod_checkue on checkues (checkue_kod);
create index if not exists index_name_order on orders (order_name);
create index if not exists index_date_time_order on orders (order_dishtime, order_date, order_opentime);
create index if not exists index_kod_order on orders (order_kod);
create index if not exists index_fio_visitor on visitors(v_surname, v_name, v_patronymic);
create index if not exists index_kod_visitor on visitors(v_kod);
create index if not exists index_fio_rv on registered_visitors (rv_name, rv_surname, rv_patronymic);
create index if not exists index_login_password_rv on registered_visitors (rv_login, rv_password);
create index if not exists index_pasportSN_rv on registered_visitors (rv_pasportS, rv_pasportN);
create index if not exists index_card_rv on registered_visitors (rv_card);
create index if not exists index_kod_rv on registered_visitors (rv_kod);
create index if not exists index_fio_employee on employee (employee_name, employee_surname, employee_patronymic);
create index if not exists index_login_password_employee on employee (employee_password, employee_login, employee_patronymic);
create index if not exists index_value_status on status(status_value);

grant select on zones to res_waiter;
grant select on dishes to res_waiter;
grant select on sostav to res_waiter;
grant select, update on Employee to res_waiter;
grant select, insert, update, delete on orders to res_waiter;
grant usage, select on sequence orders_order_kod_seq to res_waiter;
grant select, insert, update, delete on IndividualOrders to res_waiter;
grant usage, select on sequence individualorders_individualorder_kod_seq to res_waiter;
grant select, insert, update, delete on Checkues to res_waiter;
grant usage, select on sequence checkues_checkue_kod_seq to res_waiter;
grant insert, update on visitors to res_waiter;
grant insert, update on Registered_visitors to res_waiter;




grant select on orders to res_guest;
grant select on IndividualOrders to res_guest;
grant select on Checkues to res_guest;
grant select on dishes to res_guest;
grant select, update on Registered_visitors to res_guest;

grant select on orders to res_dguest;
grant select on IndividualOrders to res_dguest;
grant select on Checkues to res_dguest;
grant select on dishes to res_dguest;
grant select, update on visitors to res_dguest;

grant select on orders to res_chef;
grant select on checkues to res_chef;
grant select, update on visitors to res_dguest;
grant select, insert, update, delete on PurchaseIngredient to res_chef;
grant usage, select on sequence purchaseingredient_purchase_kod_seq to res_chef;
grant select, insert, update, delete on Shipments to res_chef;
grant usage, select on sequence shipments_shipment_kod_seq to res_chef;
grant select, insert, update, delete on sostav to res_chef;
grant usage, select on sequence sostav_sostav_kod_seq to res_chef;
grant select, insert, update, delete on Ingredientes to res_chef;
grant usage, select on sequence ingredientes_ingredient_kod_seq to res_chef;
grant select, insert, update, delete on Providers to res_chef;
grant usage, select on sequence providers_provider_kod_seq to res_chef;
grant select, insert, update, delete on Smeta to res_chef;
grant usage, select on sequence smeta_smeta_kod_seq to res_chef;
grant select, insert, update, delete on Dishes to res_chef;
grant usage, select on sequence dishes_dish_kod_seq to res_chef;


grant select on IndividualOrders to res_administrator;
grant select on PurchaseIngredient to res_administrator;
grant select on Shipments to res_administrator;
grant select on orders to res_administrator;
grant select, insert, update, delete on Registered_visitors to res_administrator;
grant select, insert, update, delete on visitors to res_administrator;
grant select, insert, update, delete on Employee to res_administrator;
grant usage, select on sequence employee_employee_kod_seq to res_administrator;

	end;

$$;
 *   DROP PROCEDURE public.structure_create();
       public          postgres    false            ,           1255    25021    structure_re_create() 	   PROCEDURE     L,  CREATE PROCEDURE public.structure_re_create()
    LANGUAGE plpgsql
    AS $$
    begin
revoke execute on procedure status_Insert from res_waiter;
revoke execute on procedure status_Update from res_waiter;
revoke execute on procedure status_Delete from res_waiter;
revoke execute on procedure visifromrs_Insert from res_waiter;
revoke execute on procedure registered_visifromrs_Insert from res_waiter;
revoke execute on procedure registered_visifromrs_Update from res_waiter;
revoke execute on procedure orders_Insert from res_waiter;
revoke execute on procedure orders_Update from res_waiter;
revoke execute on procedure orders_Delete from res_waiter;
revoke execute on procedure individualorders_Insert from res_waiter;
revoke execute on procedure individualorders_Update from res_waiter;
revoke execute on procedure individualorders_Delete from res_waiter;
revoke execute on procedure Checkues_Delete from res_waiter;
revoke execute on procedure Employee_Update from res_waiter;

revoke execute on procedure  registered_visifromrs_Update from res_guest;

revoke execute on procedure  visifromrs_Update from res_guest;

revoke execute on procedure shipments_Insert from res_chef;
revoke execute on procedure shipments_Update from res_chef;
revoke execute on procedure shipments_Delete from res_chef;
revoke execute on procedure smeta_Insert from res_chef;
revoke execute on procedure smeta_Update from res_chef;
revoke execute on procedure smeta_Delete from res_chef;
revoke execute on procedure sostav_Insert from res_chef;
revoke execute on procedure sostav_Update from res_chef;
revoke execute on procedure sostav_Delete from res_chef;
revoke execute on procedure providers_Insert from res_chef;
revoke execute on procedure providers_Update from res_chef;
revoke execute on procedure providers_Delete from res_chef;
revoke execute on procedure purchaseingredient_Insert from res_chef;
revoke execute on procedure purchaseingredient_Update from res_chef;
revoke execute on procedure purchaseingredient_Delete from res_chef;
revoke execute on procedure registered_visifromrs_Insert from res_chef;
revoke execute on procedure ingredientes_Insert from res_chef;
revoke execute on procedure ingredientes_Update from res_chef;
revoke execute on procedure ingredientes_Delete from res_chef;
revoke execute on procedure Employee_Insert from res_chef;
revoke execute on procedure Employee_Update from res_chef;
revoke execute on procedure Dishes_Insert from res_chef;
revoke execute on procedure Dishes_Update from res_chef;
revoke execute on procedure Dishes_Delete from res_chef;

revoke execute on procedure visifromrs_Insert from res_administrafromr;
revoke execute on procedure visifromrs_Update from res_administrafromr;
revoke execute on procedure visifromrs_Delete from res_administrafromr;
revoke execute on procedure wood_tables_Insert from res_administrafromr;
revoke execute on procedure wood_tables_Update from res_administrafromr; 
revoke execute on procedure wood_tables_Delete from res_administrafromr;
revoke execute on procedure zones_Insert from res_administrafromr;
revoke execute on procedure zones_Update from res_administrafromr;
revoke execute on procedure zones_Delete from res_administrafromr;
revoke execute on procedure smeta_Insert from res_administrafromr;
revoke execute on procedure smeta_Update from res_administrafromr;
revoke execute on procedure smeta_Delete from res_administrafromr;
revoke execute on procedure registered_visifromrs_Insert from res_administrafromr;
revoke execute on procedure registered_visifromrs_Update from res_administrafromr;
revoke execute on procedure registered_visifromrs_Delete from res_administrafromr;
revoke execute on procedure providers_Insert from res_administrafromr;
revoke execute on procedure providers_Update from res_administrafromr;
revoke execute on procedure providers_Delete from res_administrafromr;
revoke execute on procedure purchaseingredient_Insert from res_administrafromr;
revoke execute on procedure Employee_Insert from res_administrafromr;
revoke execute on procedure Employee_Update from res_administrafromr;
revoke execute on procedure Employee_Delete from res_administrafromr;


drop procedure employee_delete;
drop procedure checkues_delete;
drop procedure dishes_insert;
drop procedure dishes_update;
drop procedure dishes_delete;
drop procedure providers_delete;
drop procedure purchaseingredient_update;
drop procedure purchaseingredient_delete;
drop procedure shipments_insert;
drop procedure ingredientes_insert;
drop procedure status_insert;
drop procedure status_update;
drop procedure status_delete;
drop procedure wood_tables_insert;
drop procedure wood_tables_update;
drop procedure wood_tables_delete;
drop procedure zones_insert;
drop procedure zones_update;
drop procedure zones_delete;
drop procedure shipments_update;
drop procedure shipments_delete;
drop procedure sostav_insert;
drop procedure sostav_update;
drop procedure sostav_delete;
drop procedure checkue_insert;
drop procedure checkues_update;
drop procedure individualorders_insert;
drop procedure orders_insert;
drop procedure orders_delete;
drop procedure registered_visifromrs_insert;
drop procedure ingredientes_update;
drop procedure ingredientes_delete;
drop procedure purchaseingredient_insert;
drop procedure employee_insert;
drop procedure employee_update;
drop procedure individualorders_update;
drop procedure individualorders_delete;
drop procedure orders_update;
drop procedure providers_insert;
drop procedure providers_update;
drop procedure registered_visifromrs_update;
drop procedure registered_visifromrs_delete;
drop procedure smeta_insert;
drop procedure smeta_update;
drop procedure smeta_delete;
drop procedure visifromrs_insert;
drop procedure visifromrs_update;
drop procedure visifromrs_delete;

revoke usage, select on sequence orders_order_kod_seq from  res_waiter;
revoke usage, select on sequence individualorders_individualorder_kod_seq from  res_waiter;
revoke usage, select on sequence checkues_checkue_kod_seq from  res_waiter;
revoke usage, select on sequence dishes_dish_kod_seq from   res_chef;
revoke usage, select on sequence purchaseingredient_purchase_kod_seq from   res_chef;
revoke usage, select on sequence shipments_shipment_kod_seq from    res_chef;
revoke usage, select on sequence employee_employee_kod_seq from res_administrafromr;
revoke usage, select on sequence sostav_sostav_kod_seq from res_chef;
revoke usage, select on sequence ingredientes_ingredient_kod_seq from   res_chef;
revoke usage, select on sequence providers_provider_kod_seq from    res_chef;
revoke usage, select on sequence smeta_smeta_kod_seq from   res_chef;
revoke usage, select on sequence dishes_dish_kod_seq from   res_chef;
revoke usage, select on sequence providers_provider_kod_seq from    res_administrafromr;
revoke usage, select on sequence zones_zona_kod_seq from    res_administrafromr;
revoke usage, select on sequence smeta_smeta_kod_seq from   res_administrafromr;
revoke select on zones from res_waiter;
revoke select on dishes from    res_waiter;
revoke select on sostav from    res_waiter;
revoke select, update on Employee from  res_waiter;
revoke select, insert, update, delete on orders from    res_waiter;
revoke select, insert, update, delete on IndividualOrders from  res_waiter;
revoke select, insert, update, delete on Checkues from  res_waiter;
revoke insert, update on visifromrs from  res_waiter;
revoke insert, update on Registered_visifromrs from   res_waiter;
revoke select on orders from    res_guest;
revoke select on IndividualOrders from  res_guest;
revoke select on Checkues from  res_guest;
revoke select on dishes from    res_guest;
revoke select, update on Registered_visifromrs from   res_guest;
revoke select on orders from    res_dguest;
revoke select on IndividualOrders from  res_dguest;
revoke select on Checkues from  res_dguest;
revoke select on dishes from    res_dguest;
revoke select, update on visifromrs from  res_dguest;
revoke select on orders from    res_chef;
revoke select on checkues from  res_chef;
revoke select, update on visifromrs from  res_dguest;
revoke select, insert, update, delete on PurchaseIngredient from    res_chef;
revoke select, insert, update, delete on Shipments from res_chef;
revoke select, insert, update, delete on sostav from    res_chef;
revoke select, insert, update, delete on Ingredientes from  res_chef;
revoke select, insert, update, delete on Providers from res_chef;
revoke select, insert, update, delete on Smeta from res_chef;
revoke select, insert, update, delete on Dishes from    res_chef;
revoke select on IndividualOrders from  res_administrafromr;
revoke select on PurchaseIngredient from    res_administrafromr;
revoke select on Shipments from res_administrafromr;
revoke select on orders from    res_administrafromr;
revoke select, insert, update, delete on Registered_visifromrs from   res_administrafromr;
revoke select, insert, update, delete on visifromrs from  res_administrafromr;
revoke select, insert, update, delete on Employee from  res_administrafromr;
revoke select, insert, update, delete on Providers from res_administrafromr;
revoke select, insert, update, delete on Smeta from res_administrafromr;
revoke select, insert, update, delete on zones from res_administrafromr;


drop index if  exists index_kod_sostav;
drop index if  exists index_kod_Shipments;
drop index if  exists index_kod_PurchaseIngredient;
drop index if  exists index_kod_IndividualOrders;
drop index if  exists index_kod_ingredient;
drop index if  exists index_name_ingredient;
drop index if  exists index_kod_zones;
drop index if  exists index_name_zones;
drop index if  exists index_kod_status;
drop index if  exists index_name_dish;
drop index if  exists index_kod_dish;
drop index if  exists index_name_table;
drop index if  exists index_kod_table;
drop index if  exists index_number_smeta;
drop index if  exists index_kod_smeta;
drop index if  exists index_location_provider;
drop index if  exists index_name_provider;
drop index if  exists index_okpo_provider;
drop index if  exists index_kod_provider;
drop index if  exists index_number_checkue;
drop index if  exists index_date_time_checkue;
drop index if  exists index_kod_checkue;
drop index if  exists index_name_order;
drop index if  exists index_date_time_order;
drop index if  exists index_kod_order;
drop index if  exists index_fio_visifromr;
drop index if  exists index_kod_visifromr;
drop index if  exists index_fio_rv;
drop index if  exists index_login_password_rv;
drop index if  exists index_pasportSN_rv;
drop index if  exists index_card_rv;
drop index if  exists index_kod_rv;
drop index if  exists index_fio_employee;
drop index if  exists index_login_password_employee;
drop index if  exists index_value_status;

drop table if  exists IndividualOrders;
drop table if  exists Checkues;
drop table if  exists Orders;
drop table if exists PurchaseIngredient;
drop table if exists Sostav;
drop table if  exists Employee;
drop table if  exists Wood_tables;
drop table if  exists Registered_Visifromrs;
drop table if  exists Visifromrs;
drop table if  exists Shipments;
drop table if  exists Providers;
drop table if  exists Smeta;
drop table if  exists Dishes;
drop table if  exists Status;
drop table if  exists Zones;
drop table if  exists Ingredientes;
call Structure_Create();
    end;
$$;
 -   DROP PROCEDURE public.structure_re_create();
       public          postgres    false            >           1255    26501 "   visitors_delete(character varying) 	   PROCEDURE     T  CREATE PROCEDURE public.visitors_delete(IN p_v_kod character varying)
    LANGUAGE plpgsql
    AS $$
	declare meeting_count int := count(*) from individualorders where v_kod = p_v_kod;
	begin
		if (meeting_count > 0) then
			raise notice 'such visitor is used';
		else
		delete from visitors
		where
			v_kod = p_v_kod;
		end if;
	end;
$$;
 E   DROP PROCEDURE public.visitors_delete(IN p_v_kod character varying);
       public          postgres    false            x           0    0 7   PROCEDURE visitors_delete(IN p_v_kod character varying)    ACL     b   GRANT ALL ON PROCEDURE public.visitors_delete(IN p_v_kod character varying) TO res_administrator;
          public          postgres    false    318            =           1255    26498 [   visitors_insert(character varying, character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.visitors_insert(IN p_v_surname character varying, IN p_v_name character varying, IN p_v_patronymic character varying, IN p_v_kod character varying)
    LANGUAGE plpgsql
    AS $$
	declare meeting_count int := count(*) from visitors where v_kod = p_v_kod;
	begin
		if (meeting_count > 0) then
			raise notice 'such visitor is made';
		else 
		insert into visitors(v_surname, v_name, v_patronymic, v_kod)
		values (p_v_surname, p_v_name, p_v_patronymic, p_v_kod);
		end if;
	end;
$$;
 �   DROP PROCEDURE public.visitors_insert(IN p_v_surname character varying, IN p_v_name character varying, IN p_v_patronymic character varying, IN p_v_kod character varying);
       public          postgres    false            y           0    0 �   PROCEDURE visitors_insert(IN p_v_surname character varying, IN p_v_name character varying, IN p_v_patronymic character varying, IN p_v_kod character varying)    ACL     �  GRANT ALL ON PROCEDURE public.visitors_insert(IN p_v_surname character varying, IN p_v_name character varying, IN p_v_patronymic character varying, IN p_v_kod character varying) TO res_waiter;
GRANT ALL ON PROCEDURE public.visitors_insert(IN p_v_surname character varying, IN p_v_name character varying, IN p_v_patronymic character varying, IN p_v_kod character varying) TO res_administrator;
          public          postgres    false    317            ;           1255    26499 [   visitors_update(character varying, character varying, character varying, character varying) 	   PROCEDURE     ^  CREATE PROCEDURE public.visitors_update(IN p_v_surname character varying, IN p_v_name character varying, IN p_v_patronymic character varying, IN p_v_kod character varying)
    LANGUAGE plpgsql
    AS $$
	begin
		update visitors set
		v_surname = p_v_surname,
		v_name = p_v_name,
		v_patronymic = p_v_patronymic
		where
			v_kod = p_v_kod;
	end;
$$;
 �   DROP PROCEDURE public.visitors_update(IN p_v_surname character varying, IN p_v_name character varying, IN p_v_patronymic character varying, IN p_v_kod character varying);
       public          postgres    false            z           0    0 �   PROCEDURE visitors_update(IN p_v_surname character varying, IN p_v_name character varying, IN p_v_patronymic character varying, IN p_v_kod character varying)    ACL     �  GRANT ALL ON PROCEDURE public.visitors_update(IN p_v_surname character varying, IN p_v_name character varying, IN p_v_patronymic character varying, IN p_v_kod character varying) TO res_guest;
GRANT ALL ON PROCEDURE public.visitors_update(IN p_v_surname character varying, IN p_v_name character varying, IN p_v_patronymic character varying, IN p_v_kod character varying) TO res_administrator;
          public          postgres    false    315                       1255    24867    wood_tables_delete(integer) 	   PROCEDURE     X  CREATE PROCEDURE public.wood_tables_delete(IN p_table_kod integer)
    LANGUAGE plpgsql
    AS $$
	declare meeting_count int := count(*) from orders where table_kod = p_table_kod;
	begin
		if (meeting_count > 0) then
			raise notice 'such table is used';
		else
		delete from wood_tables
		where
			table_kod = p_table_kod;
		end if;
	end;
$$;
 B   DROP PROCEDURE public.wood_tables_delete(IN p_table_kod integer);
       public          postgres    false            {           0    0 4   PROCEDURE wood_tables_delete(IN p_table_kod integer)    ACL     _   GRANT ALL ON PROCEDURE public.wood_tables_delete(IN p_table_kod integer) TO res_administrator;
          public          postgres    false    282                       1255    24865 7   wood_tables_insert(integer, character varying, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.wood_tables_insert(IN p_table_placescount integer, IN p_wood_table_name character varying, IN p_zona_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin 
		insert into wood_tables(table_placescount, wood_table_name, zona_kod)
		values (p_table_placescount, p_wood_table_name, p_zona_kod);
		exception when others then
			raise notice 'Такой стол уже существует в таблице';
	end;
$$;
 �   DROP PROCEDURE public.wood_tables_insert(IN p_table_placescount integer, IN p_wood_table_name character varying, IN p_zona_kod integer);
       public          postgres    false            |           0    0 {   PROCEDURE wood_tables_insert(IN p_table_placescount integer, IN p_wood_table_name character varying, IN p_zona_kod integer)    ACL     �   GRANT ALL ON PROCEDURE public.wood_tables_insert(IN p_table_placescount integer, IN p_wood_table_name character varying, IN p_zona_kod integer) TO res_administrator;
          public          postgres    false    287                       1255    24866 @   wood_tables_update(integer, character varying, integer, integer) 	   PROCEDURE     y  CREATE PROCEDURE public.wood_tables_update(IN p_table_placescount integer, IN p_wood_table_name character varying, IN p_zona_kod integer, IN p_table_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin
		update wood_tables set
		table_placescount = p_table_placescount,
		wood_table_name = p_wood_table_name,
		zona_kod = p_zona_kod
		where
			table_kod = p_table_kod;
	end;
$$;
 �   DROP PROCEDURE public.wood_tables_update(IN p_table_placescount integer, IN p_wood_table_name character varying, IN p_zona_kod integer, IN p_table_kod integer);
       public          postgres    false            }           0    0 �   PROCEDURE wood_tables_update(IN p_table_placescount integer, IN p_wood_table_name character varying, IN p_zona_kod integer, IN p_table_kod integer)    ACL     �   GRANT ALL ON PROCEDURE public.wood_tables_update(IN p_table_placescount integer, IN p_wood_table_name character varying, IN p_zona_kod integer, IN p_table_kod integer) TO res_administrator;
          public          postgres    false    284                       1255    24870    zones_delete(integer) 	   PROCEDURE     M  CREATE PROCEDURE public.zones_delete(IN p_zona_kod integer)
    LANGUAGE plpgsql
    AS $$
	declare meeting_count int := count(*) from wood_tables where p_zona_kod = p_zona_kod;
	begin
		if (meeting_count > 0) then
			raise notice 'such zone is used';
		else
		delete from zones
		where
			zona_kod = p_zona_kod;
		end if;
	end;
$$;
 ;   DROP PROCEDURE public.zones_delete(IN p_zona_kod integer);
       public          postgres    false            ~           0    0 -   PROCEDURE zones_delete(IN p_zona_kod integer)    ACL     X   GRANT ALL ON PROCEDURE public.zones_delete(IN p_zona_kod integer) TO res_administrator;
          public          postgres    false    286                       1255    24868    zones_insert(character varying) 	   PROCEDURE     T  CREATE PROCEDURE public.zones_insert(IN p_zona_name character varying)
    LANGUAGE plpgsql
    AS $$
	declare meeting_count int := count(*) from zones where zona_name = p_zona_name;
	begin
		if (meeting_count > 0) then
			raise notice 'such zone is made';
		else 
		insert into zones(zona_name)
		values (p_zona_name);
		end if;
	end;
$$;
 F   DROP PROCEDURE public.zones_insert(IN p_zona_name character varying);
       public          postgres    false                       0    0 8   PROCEDURE zones_insert(IN p_zona_name character varying)    ACL     c   GRANT ALL ON PROCEDURE public.zones_insert(IN p_zona_name character varying) TO res_administrator;
          public          postgres    false    283                       1255    24869 (   zones_update(character varying, integer) 	   PROCEDURE     �   CREATE PROCEDURE public.zones_update(IN p_zona_name character varying, IN p_zona_kod integer)
    LANGUAGE plpgsql
    AS $$
	begin
		update zones set
		zona_name = p_zona_name
		where
			zona_kod = p_zona_kod;
	end;
$$;
 ]   DROP PROCEDURE public.zones_update(IN p_zona_name character varying, IN p_zona_kod integer);
       public          postgres    false            �           0    0 O   PROCEDURE zones_update(IN p_zona_name character varying, IN p_zona_kod integer)    ACL     z   GRANT ALL ON PROCEDURE public.zones_update(IN p_zona_name character varying, IN p_zona_kod integer) TO res_administrator;
          public          postgres    false    285            �            1259    26663    booking    TABLE     �  CREATE TABLE public.booking (
    booking_kod integer NOT NULL,
    book_number character varying(16) NOT NULL,
    book_making_date date NOT NULL,
    book_making_time time without time zone NOT NULL,
    book_plan_date date NOT NULL,
    book_plan_time time without time zone NOT NULL,
    book_guests_count integer NOT NULL,
    wood_table_kod integer NOT NULL,
    v_kod character varying(5) NOT NULL,
    CONSTRAINT ch_value_booking_number CHECK (((book_number)::text ~ similar_to_escape('%БР/[0-9]{2}/[0-9]{10}%'::text))),
    CONSTRAINT ch_value_guests_count CHECK ((book_guests_count >= 1)),
    CONSTRAINT ch_value_time_date CHECK (((book_making_date < book_plan_date) OR (book_making_time < book_plan_time)))
);
    DROP TABLE public.booking;
       public         heap    postgres    false            �           0    0    TABLE booking    ACL     h   GRANT SELECT ON TABLE public.booking TO res_waiter;
GRANT SELECT ON TABLE public.booking TO res_dguest;
          public          postgres    false    247            �            1259    26662    booking_booking_kod_seq    SEQUENCE     �   CREATE SEQUENCE public.booking_booking_kod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.booking_booking_kod_seq;
       public          postgres    false    247            �           0    0    booking_booking_kod_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.booking_booking_kod_seq OWNED BY public.booking.booking_kod;
          public          postgres    false    246            �            1259    26311    dishes    TABLE     b  CREATE TABLE public.dishes (
    dish_name character varying(50) NOT NULL,
    dish_cost integer NOT NULL,
    dish_weight numeric(6,2) NOT NULL,
    dish_kod integer NOT NULL,
    dish_picture character varying(50),
    CONSTRAINT ch_value_dish_cost CHECK ((dish_cost >= 0)),
    CONSTRAINT ch_value_dish_weight CHECK ((dish_weight >= (0)::numeric))
);
    DROP TABLE public.dishes;
       public         heap    postgres    false            �           0    0    TABLE dishes    ACL     �   GRANT SELECT ON TABLE public.dishes TO res_waiter;
GRANT SELECT ON TABLE public.dishes TO res_guest;
GRANT SELECT ON TABLE public.dishes TO res_dguest;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dishes TO res_chef;
          public          postgres    false    225            �            1259    26734    planning_dishes    TABLE     �   CREATE TABLE public.planning_dishes (
    planning_dishes_kod integer NOT NULL,
    planning_dishes_time time without time zone NOT NULL,
    dish_kod integer NOT NULL,
    dishes_count integer NOT NULL,
    book_number character varying(50) NOT NULL
);
 #   DROP TABLE public.planning_dishes;
       public         heap    postgres    false            �           0    0    TABLE planning_dishes    ACL     x   GRANT SELECT ON TABLE public.planning_dishes TO res_waiter;
GRANT SELECT ON TABLE public.planning_dishes TO res_dguest;
          public          postgres    false    251            �            1259    26286    registered_visitors    TABLE     �  CREATE TABLE public.registered_visitors (
    rv_surname character varying(50) NOT NULL,
    rv_name character varying(50) NOT NULL,
    rv_patronymic character varying(50) DEFAULT '-'::character varying,
    rv_login character varying(50) NOT NULL,
    rv_password character varying(50) NOT NULL,
    rv_pasports character varying(5) NOT NULL,
    rv_pasportn character varying(6) NOT NULL,
    rv_card character varying(19) NOT NULL,
    rv_kod character varying(5) NOT NULL,
    CONSTRAINT ch_lengrh_rv_login CHECK ((length((rv_login)::text) >= 8)),
    CONSTRAINT ch_lengrh_rv_password CHECK ((length((rv_password)::text) >= 8)),
    CONSTRAINT ch_value_rv_card CHECK (((rv_card)::text ~ similar_to_escape('%[0-9]{4}[0-9]{4}[0-9]{4}%'::text))),
    CONSTRAINT ch_value_rv_login CHECK (((rv_login)::text ~ similar_to_escape('%[A-Za-z]+[!@#$%^&*()_]*[A-Za-z]+%'::text))),
    CONSTRAINT ch_value_rv_pasportn CHECK (((rv_pasportn)::text ~ similar_to_escape('%[0-9]{6}%'::text))),
    CONSTRAINT ch_value_rv_pasports CHECK (((rv_pasports)::text ~ similar_to_escape('%[0-9]{2}[0-9]{2}%'::text))),
    CONSTRAINT ch_value_rv_password CHECK (((rv_password)::text ~ similar_to_escape('%[A-Za-z]+[!@#$%^&*()_]+[A-Za-z]+%'::text)))
);
 '   DROP TABLE public.registered_visitors;
       public         heap    postgres    false            �           0    0    TABLE registered_visitors    ACL     0  GRANT SELECT,INSERT,UPDATE ON TABLE public.registered_visitors TO res_waiter;
GRANT SELECT,UPDATE ON TABLE public.registered_visitors TO res_guest;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.registered_visitors TO res_administrator;
GRANT SELECT ON TABLE public.registered_visitors TO res_dguest;
          public          postgres    false    218            �            1259    26339    wood_tables    TABLE     �  CREATE TABLE public.wood_tables (
    table_placescount integer NOT NULL,
    wood_table_name character varying(4) NOT NULL,
    table_kod integer NOT NULL,
    zona_kod integer NOT NULL,
    CONSTRAINT ch_value_table_placescount CHECK ((table_placescount >= 0)),
    CONSTRAINT ch_value_wood_table_name CHECK (((wood_table_name)::text ~ similar_to_escape('%[А-Яа-ё]{1,2}[0-9]{1,2}%'::text)))
);
    DROP TABLE public.wood_tables;
       public         heap    postgres    false            �           0    0    TABLE wood_tables    ACL     p   GRANT SELECT ON TABLE public.wood_tables TO res_waiter;
GRANT SELECT ON TABLE public.wood_tables TO res_dguest;
          public          postgres    false    233                        1259    51452    booking_list    VIEW     f  CREATE VIEW public.booking_list AS
 SELECT DISTINCT concat(booking.book_number, ' клиент: ', registered_visitors.rv_surname, ' ', registered_visitors.rv_name, ' ', registered_visitors.rv_patronymic) AS "Бронь и клиент",
    concat('Дата и вермя создания: ', booking.book_making_date, ' ', booking.book_making_time, ', Планируемая дата посещения: ', booking.book_plan_date, ', Планируемое время посещения: ', booking.book_plan_time) AS "Данные о времени",
    concat('Номер стола: ', wood_tables.wood_table_name, ', Количество гостей: ', booking.book_guests_count) AS "Место бронирования",
        CASE
            WHEN (string_agg((planning_dishes.planning_dishes_kod)::text, ','::text) IS NULL) THEN 'Нет блюд в предворительном заказе'::text
            ELSE string_agg(concat('"', dishes.dish_name, '"', ' X', planning_dishes.dishes_count, ' - ', planning_dishes.planning_dishes_time), ', '::text)
        END AS "Заказы к прибытию гостей"
   FROM ((((public.booking
     JOIN public.registered_visitors ON (((registered_visitors.rv_kod)::text = (booking.v_kod)::text)))
     JOIN public.wood_tables ON ((wood_tables.table_kod = booking.wood_table_kod)))
     LEFT JOIN public.planning_dishes ON (((planning_dishes.book_number)::text = (booking.book_number)::text)))
     LEFT JOIN public.dishes ON ((dishes.dish_kod = planning_dishes.dish_kod)))
  GROUP BY (concat(booking.book_number, ' клиент: ', registered_visitors.rv_surname, ' ', registered_visitors.rv_name, ' ', registered_visitors.rv_patronymic)), (concat('Дата и вермя создания: ', booking.book_making_date, ' ', booking.book_making_time, ', Планируемая дата посещения: ', booking.book_plan_date, ', Планируемое время посещения: ', booking.book_plan_time)), (concat('Номер стола: ', wood_tables.wood_table_name, ', Количество гостей: ', booking.book_guests_count)), planning_dishes.dishes_count;
    DROP VIEW public.booking_list;
       public          postgres    false    218    218    218    218    251    251    251    251    251    247    247    247    247    225    225    233    233    247    247    247    247            �           0    0    TABLE booking_list    ACL     w   GRANT SELECT ON TABLE public.booking_list TO res_administrator;
GRANT SELECT ON TABLE public.booking_list TO res_chef;
          public          postgres    false    256            �            1259    26378    checkues    TABLE     E  CREATE TABLE public.checkues (
    checkue_number character varying(13) NOT NULL,
    checkue_date date NOT NULL,
    checkue_time time without time zone NOT NULL,
    checkue_sumfinal integer NOT NULL,
    checkue_sumgotten integer NOT NULL,
    checkue_changesum integer NOT NULL,
    checkue_paytype character varying(50) NOT NULL,
    checkue_finalcost integer NOT NULL,
    checkue_kod integer NOT NULL,
    order_kod integer NOT NULL,
    order_name character varying(16),
    CONSTRAINT ch_value_checkue_changesum CHECK ((checkue_changesum >= 0)),
    CONSTRAINT ch_value_checkue_finalcost CHECK ((checkue_finalcost >= 0)),
    CONSTRAINT ch_value_checkue_number CHECK (((checkue_number)::text ~ similar_to_escape('%КЧ-[0-9]{7}/[0-9]{2}%'::text))),
    CONSTRAINT ch_value_checkue_paytype CHECK (((checkue_paytype)::text = ANY ((ARRAY['Наличный'::character varying, 'Безналичный'::character varying])::text[]))),
    CONSTRAINT ch_value_checkue_sumfinal CHECK ((checkue_sumfinal >= 0)),
    CONSTRAINT ch_value_checkue_sumgotten CHECK ((checkue_sumgotten >= 0))
);
    DROP TABLE public.checkues;
       public         heap    postgres    false            �           0    0    TABLE checkues    ACL     �   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.checkues TO res_waiter;
GRANT SELECT ON TABLE public.checkues TO res_guest;
GRANT SELECT ON TABLE public.checkues TO res_dguest;
GRANT SELECT ON TABLE public.checkues TO res_chef;
          public          postgres    false    237            �            1259    26377    checkues_checkue_kod_seq    SEQUENCE     �   CREATE SEQUENCE public.checkues_checkue_kod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.checkues_checkue_kod_seq;
       public          postgres    false    237            �           0    0    checkues_checkue_kod_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.checkues_checkue_kod_seq OWNED BY public.checkues.checkue_kod;
          public          postgres    false    236            �           0    0 !   SEQUENCE checkues_checkue_kod_seq    ACL     N   GRANT SELECT,USAGE ON SEQUENCE public.checkues_checkue_kod_seq TO res_waiter;
          public          postgres    false    236            �            1259    26310    dishes_dish_kod_seq    SEQUENCE     �   CREATE SEQUENCE public.dishes_dish_kod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.dishes_dish_kod_seq;
       public          postgres    false    225            �           0    0    dishes_dish_kod_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.dishes_dish_kod_seq OWNED BY public.dishes.dish_kod;
          public          postgres    false    224            �           0    0    SEQUENCE dishes_dish_kod_seq    ACL     G   GRANT SELECT,USAGE ON SEQUENCE public.dishes_dish_kod_seq TO res_chef;
          public          postgres    false    224            �            1259    26332    ingredientes    TABLE     ~   CREATE TABLE public.ingredientes (
    ingredient_name character varying(50) NOT NULL,
    ingredient_kod integer NOT NULL
);
     DROP TABLE public.ingredientes;
       public         heap    postgres    false            �           0    0    TABLE ingredientes    ACL     �   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ingredientes TO res_chef;
GRANT SELECT ON TABLE public.ingredientes TO res_dguest;
          public          postgres    false    231            �            1259    26351    orders    TABLE     �  CREATE TABLE public.orders (
    order_name character varying(16) NOT NULL,
    order_dishcount integer NOT NULL,
    order_dishtime time without time zone NOT NULL,
    order_date date NOT NULL,
    order_opentime time without time zone NOT NULL,
    order_kod integer NOT NULL,
    table_kod integer NOT NULL,
    employee_kod integer NOT NULL,
    status_kod integer NOT NULL,
    dish_kod integer NOT NULL,
    CONSTRAINT ch_time_order_dishtime CHECK ((order_dishtime >= order_opentime)),
    CONSTRAINT ch_value_order_dishcount CHECK ((order_dishcount >= 0)),
    CONSTRAINT ch_value_order_name CHECK (((order_name)::text ~ similar_to_escape('%ЗКЗ-[0-9]{9}-[0-9]{2}%'::text)))
);
    DROP TABLE public.orders;
       public         heap    postgres    false            �           0    0    TABLE orders    ACL       GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.orders TO res_waiter;
GRANT SELECT ON TABLE public.orders TO res_guest;
GRANT SELECT ON TABLE public.orders TO res_dguest;
GRANT SELECT ON TABLE public.orders TO res_chef;
GRANT SELECT ON TABLE public.orders TO res_administrator;
          public          postgres    false    235            �            1259    26436    sostav    TABLE     �   CREATE TABLE public.sostav (
    sostav_kod integer NOT NULL,
    ingredient_kod integer NOT NULL,
    dish_kod integer NOT NULL
);
    DROP TABLE public.sostav;
       public         heap    postgres    false            �           0    0    TABLE sostav    ACL     �   GRANT SELECT ON TABLE public.sostav TO res_waiter;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sostav TO res_chef;
GRANT SELECT ON TABLE public.sostav TO res_dguest;
          public          postgres    false    245            �            1259    43255    dishes_list    VIEW       CREATE VIEW public.dishes_list AS
 SELECT ((((((dishes.dish_name)::text || ','::text) || dishes.dish_cost) || ' гр., цена: '::text) || dishes.dish_weight) || ' р.'::text) AS "Блюдо",
    concat('Состав: ', string_agg(DISTINCT (ingredientes.ingredient_name)::text, ', '::text)) AS "Состав",
    count(DISTINCT orders.order_dishcount) AS "Количество заказов"
   FROM (((public.dishes
     JOIN public.sostav ON ((sostav.dish_kod = dishes.dish_kod)))
     JOIN public.ingredientes ON ((ingredientes.ingredient_kod = sostav.ingredient_kod)))
     JOIN public.orders ON ((orders.dish_kod = dishes.dish_kod)))
  GROUP BY ((((((dishes.dish_name)::text || ','::text) || dishes.dish_cost) || ' гр., цена: '::text) || dishes.dish_weight) || ' р.'::text);
    DROP VIEW public.dishes_list;
       public          postgres    false    225    245    245    235    235    231    231    225    225    225            �           0    0    TABLE dishes_list    ACL     8   GRANT SELECT ON TABLE public.dishes_list TO res_waiter;
          public          postgres    false    254            �            1259    26280    employee    TABLE     -  CREATE TABLE public.employee (
    employee_kod integer NOT NULL,
    employee_surname character varying(50) NOT NULL,
    employee_name character varying(50) NOT NULL,
    employee_patronymic character varying(50) DEFAULT '-'::character varying,
    employee_login character varying(50) NOT NULL,
    employee_password character varying(50) NOT NULL,
    CONSTRAINT ch_length_employee_login CHECK ((length((employee_login)::text) > 8)),
    CONSTRAINT ch_length_employee_password CHECK ((length((employee_password)::text) >= 8)),
    CONSTRAINT ch_value_employee_login CHECK (((employee_login)::text ~ similar_to_escape('%[A-Za-z]+[!@#$%^&*()_]+[A-Za-z]+%'::text))),
    CONSTRAINT ch_value_employee_password CHECK (((employee_password)::text ~ similar_to_escape('%[A-Za-z]+[!@#$%^&*()_]+[A-Za-z]+%'::text)))
);
    DROP TABLE public.employee;
       public         heap    postgres    false            �           0    0    TABLE employee    ACL     �   GRANT SELECT,UPDATE ON TABLE public.employee TO res_waiter;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.employee TO res_administrator;
          public          postgres    false    217            �            1259    26279    employee_employee_kod_seq    SEQUENCE     �   CREATE SEQUENCE public.employee_employee_kod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.employee_employee_kod_seq;
       public          postgres    false    217            �           0    0    employee_employee_kod_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.employee_employee_kod_seq OWNED BY public.employee.employee_kod;
          public          postgres    false    216            �           0    0 "   SEQUENCE employee_employee_kod_seq    ACL     V   GRANT SELECT,USAGE ON SEQUENCE public.employee_employee_kod_seq TO res_administrator;
          public          postgres    false    216            �            1259    26390    individualorders    TABLE     �   CREATE TABLE public.individualorders (
    individualorder_kod integer NOT NULL,
    order_kod integer NOT NULL,
    v_kod character varying(5) NOT NULL,
    person_cost integer NOT NULL,
    CONSTRAINT ch_value_person_cost CHECK ((person_cost >= 0))
);
 $   DROP TABLE public.individualorders;
       public         heap    postgres    false            �           0    0    TABLE individualorders    ACL       GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.individualorders TO res_waiter;
GRANT SELECT ON TABLE public.individualorders TO res_guest;
GRANT SELECT ON TABLE public.individualorders TO res_dguest;
GRANT SELECT ON TABLE public.individualorders TO res_administrator;
          public          postgres    false    239            �            1259    26389 (   individualorders_individualorder_kod_seq    SEQUENCE     �   CREATE SEQUENCE public.individualorders_individualorder_kod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE public.individualorders_individualorder_kod_seq;
       public          postgres    false    239            �           0    0 (   individualorders_individualorder_kod_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE public.individualorders_individualorder_kod_seq OWNED BY public.individualorders.individualorder_kod;
          public          postgres    false    238            �           0    0 1   SEQUENCE individualorders_individualorder_kod_seq    ACL     ^   GRANT SELECT,USAGE ON SEQUENCE public.individualorders_individualorder_kod_seq TO res_waiter;
          public          postgres    false    238            �            1259    26331    ingredientes_ingredient_kod_seq    SEQUENCE     �   CREATE SEQUENCE public.ingredientes_ingredient_kod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.ingredientes_ingredient_kod_seq;
       public          postgres    false    231            �           0    0    ingredientes_ingredient_kod_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.ingredientes_ingredient_kod_seq OWNED BY public.ingredientes.ingredient_kod;
          public          postgres    false    230            �           0    0 (   SEQUENCE ingredientes_ingredient_kod_seq    ACL     S   GRANT SELECT,USAGE ON SEQUENCE public.ingredientes_ingredient_kod_seq TO res_chef;
          public          postgres    false    230                       1259    59703    orders_history    TABLE     �  CREATE TABLE public.orders_history (
    id_orders_history uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    order_name text NOT NULL,
    wood_table_name text NOT NULL,
    sostav text NOT NULL,
    orders_history_status text NOT NULL,
    timestamp_create timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT ch_history_status CHECK ((orders_history_status = ANY (ARRAY['Новая запись'::text, 'Изменение'::text, 'Удалённая'::text])))
);
 "   DROP TABLE public.orders_history;
       public         heap    postgres    false    2            �           0    0    TABLE orders_history    ACL     u   GRANT SELECT ON TABLE public.orders_history TO res_waiter;
GRANT SELECT ON TABLE public.orders_history TO res_guest;
          public          postgres    false    258                       1259    51457    orders_list    VIEW     �	  CREATE VIEW public.orders_list AS
 SELECT concat(orders.order_name, ' - ', registered_visitors.rv_surname, ' ', registered_visitors.rv_name, ' ', registered_visitors.rv_patronymic) AS "Заказ клиентов",
    concat(employee.employee_surname, ' ', employee.employee_name, ' ', employee.employee_patronymic) AS "Официант",
    concat(orders.order_date, orders.order_opentime) AS "Дата и время",
    string_agg(DISTINCT (dishes.dish_name)::text, ' - '::text) AS "Перечень в заказе",
    concat('стол: ', wood_tables.wood_table_name, ' Общая стоимость: ', checkues.checkue_finalcost) AS "Место и итог",
        CASE
            WHEN (checkues.checkue_number IS NULL) THEN 'открыто'::text
            ELSE concat('Чек: ', checkues.checkue_number, ', Дата и время: ', checkues.checkue_date, ' ', checkues.checkue_time, ', итоговая сумма: ', checkues.checkue_sumfinal, ', Вид расчета: ', checkues.checkue_paytype, ', Внесено: ', checkues.checkue_sumgotten, ', Сдача: ', checkues.checkue_changesum)
        END AS "Наличие чека"
   FROM ((((((public.orders
     LEFT JOIN public.individualorders ON ((orders.order_kod = individualorders.order_kod)))
     LEFT JOIN public.registered_visitors ON (((registered_visitors.rv_kod)::text = (individualorders.v_kod)::text)))
     JOIN public.employee ON ((employee.employee_kod = orders.employee_kod)))
     JOIN public.dishes ON ((dishes.dish_kod = orders.dish_kod)))
     JOIN public.wood_tables ON ((wood_tables.table_kod = orders.table_kod)))
     LEFT JOIN public.checkues ON (((checkues.order_name)::text = (orders.order_name)::text)))
  WHERE ((individualorders.v_kod)::text ~~ 'зп%'::text)
  GROUP BY (concat(orders.order_name, ' - ', registered_visitors.rv_surname, ' ', registered_visitors.rv_name, ' ', registered_visitors.rv_patronymic)), (concat(employee.employee_surname, ' ', employee.employee_name, ' ', employee.employee_patronymic)), (concat('стол: ', wood_tables.wood_table_name, ' Общая стоимость: ', checkues.checkue_finalcost)), (concat('Чек: ', checkues.checkue_number, ', Дата и время: ', checkues.checkue_date, ' ', checkues.checkue_time, ', итоговая сумма: ', checkues.checkue_sumfinal, ', Вид расчета: ', checkues.checkue_paytype, ', Внесено: ', checkues.checkue_sumgotten, ', Сдача: ', checkues.checkue_changesum)), checkues.checkue_number, orders.order_date, orders.order_opentime;
    DROP VIEW public.orders_list;
       public          postgres    false    237    237    233    237    239    239    237    235    235    235    235    233    225    225    218    218    218    218    217    217    217    217    235    237    237    237    237    237    235    235            �           0    0    TABLE orders_list    ACL     n   GRANT SELECT ON TABLE public.orders_list TO res_chef;
GRANT SELECT ON TABLE public.orders_list TO res_waiter;
          public          postgres    false    257            �            1259    26350    orders_order_kod_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_order_kod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.orders_order_kod_seq;
       public          postgres    false    235            �           0    0    orders_order_kod_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.orders_order_kod_seq OWNED BY public.orders.order_kod;
          public          postgres    false    234            �           0    0    SEQUENCE orders_order_kod_seq    ACL     J   GRANT SELECT,USAGE ON SEQUENCE public.orders_order_kod_seq TO res_waiter;
          public          postgres    false    234            �            1259    43250    persons_list    VIEW     *  CREATE VIEW public.persons_list AS
 SELECT
        CASE
            WHEN (employee.employee_kod IS NULL) THEN 'Посетители'::text
            WHEN (registered_visitors.rv_kod IS NULL) THEN 'Сотрудники'::text
            ELSE NULL::text
        END AS "Роль",
        CASE
            WHEN (employee.employee_kod IS NULL) THEN concat(registered_visitors.rv_surname, ' ', registered_visitors.rv_name, ' ', registered_visitors.rv_patronymic)
            WHEN (registered_visitors.rv_kod IS NULL) THEN concat(employee.employee_surname, ' ', employee.employee_name, ' ', employee.employee_patronymic)
            ELSE NULL::text
        END AS "ФИО",
        CASE
            WHEN (employee.employee_kod IS NULL) THEN registered_visitors.rv_login
            WHEN (registered_visitors.rv_kod IS NULL) THEN employee.employee_login
            ELSE NULL::character varying
        END AS "Логин",
        CASE
            WHEN (employee.employee_kod IS NULL) THEN registered_visitors.rv_password
            WHEN (registered_visitors.rv_kod IS NULL) THEN employee.employee_password
            ELSE NULL::character varying
        END AS "Пароль"
   FROM (public.registered_visitors
     FULL JOIN public.employee ON (((employee.employee_login)::text = (registered_visitors.rv_kod)::text)));
    DROP VIEW public.persons_list;
       public          postgres    false    217    218    218    218    218    218    218    217    217    217    217    217            �           0    0    TABLE persons_list    ACL     y   GRANT SELECT ON TABLE public.persons_list TO res_administrator;
GRANT SELECT ON TABLE public.persons_list TO res_waiter;
          public          postgres    false    253            �            1259    26733 '   planning_dishes_planning_dishes_kod_seq    SEQUENCE     �   CREATE SEQUENCE public.planning_dishes_planning_dishes_kod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 >   DROP SEQUENCE public.planning_dishes_planning_dishes_kod_seq;
       public          postgres    false    251            �           0    0 '   planning_dishes_planning_dishes_kod_seq    SEQUENCE OWNED BY     s   ALTER SEQUENCE public.planning_dishes_planning_dishes_kod_seq OWNED BY public.planning_dishes.planning_dishes_kod;
          public          postgres    false    250            �            1259    26692    planning_orders    TABLE     �   CREATE TABLE public.planning_orders (
    planning_order_kod integer NOT NULL,
    order_kod integer NOT NULL,
    book_kod integer NOT NULL
);
 #   DROP TABLE public.planning_orders;
       public         heap    postgres    false            �            1259    26691 &   planning_orders_planning_order_kod_seq    SEQUENCE     �   CREATE SEQUENCE public.planning_orders_planning_order_kod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.planning_orders_planning_order_kod_seq;
       public          postgres    false    249            �           0    0 &   planning_orders_planning_order_kod_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE public.planning_orders_planning_order_kod_seq OWNED BY public.planning_orders.planning_order_kod;
          public          postgres    false    248            �            1259    26297 	   providers    TABLE     f  CREATE TABLE public.providers (
    provider_city character varying(50) NOT NULL,
    provider_street character varying(50) NOT NULL,
    provider_house integer NOT NULL,
    provider_flatnumber integer NOT NULL,
    provider_name character varying(50) NOT NULL,
    provider_okpo character varying(10) NOT NULL,
    provider_kod integer NOT NULL,
    CONSTRAINT ch_value_provider_flatnumber CHECK ((provider_flatnumber >= 0)),
    CONSTRAINT ch_value_provider_house CHECK ((provider_house >= 0)),
    CONSTRAINT ch_value_provider_okpo CHECK (((provider_okpo)::text ~ similar_to_escape('%[0-9]{8,10}%'::text)))
);
    DROP TABLE public.providers;
       public         heap    postgres    false            �           0    0    TABLE providers    ACL     I   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.providers TO res_chef;
          public          postgres    false    221            �            1259    26419    purchaseingredient    TABLE     
  CREATE TABLE public.purchaseingredient (
    purchase_kod integer NOT NULL,
    ingredient_weight integer NOT NULL,
    shipment_kod integer NOT NULL,
    ingredient_kod integer NOT NULL,
    CONSTRAINT ch_value_ingredient_weight CHECK ((ingredient_weight >= 0))
);
 &   DROP TABLE public.purchaseingredient;
       public         heap    postgres    false            �           0    0    TABLE purchaseingredient    ACL     �   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.purchaseingredient TO res_chef;
GRANT SELECT ON TABLE public.purchaseingredient TO res_administrator;
          public          postgres    false    243            �            1259    26402 	   shipments    TABLE     �   CREATE TABLE public.shipments (
    shipment_kod integer NOT NULL,
    smeta_kod integer NOT NULL,
    provider_kod integer NOT NULL
);
    DROP TABLE public.shipments;
       public         heap    postgres    false            �           0    0    TABLE shipments    ACL     �   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.shipments TO res_chef;
GRANT SELECT ON TABLE public.shipments TO res_administrator;
          public          postgres    false    241            �            1259    26304    smeta    TABLE     �   CREATE TABLE public.smeta (
    smeta_date date NOT NULL,
    smeta_number character varying(13),
    smeta_kod integer NOT NULL,
    CONSTRAINT ch_value_smeta_number CHECK (((smeta_number)::text ~ similar_to_escape('%СП-[0-9]{7}-[0-9]{2}%'::text)))
);
    DROP TABLE public.smeta;
       public         heap    postgres    false            �           0    0    TABLE smeta    ACL     E   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.smeta TO res_chef;
          public          postgres    false    223            �            1259    43265    postavki_list    VIEW     �  CREATE VIEW public.postavki_list AS
 SELECT DISTINCT smeta.smeta_number AS "Смета",
    concat('Дата поставки: ', smeta.smeta_date) AS "Дата",
    concat(providers.provider_name, ', ОКПО: ', providers.provider_okpo) AS "Поставщик",
    concat('Ингредиенты: ', string_agg(concat(ingredientes.ingredient_name, ' ', purchaseingredient.ingredient_weight, ' кг'), ','::text)) AS "Состав"
   FROM ((((public.smeta
     JOIN public.shipments ON ((shipments.smeta_kod = smeta.smeta_kod)))
     JOIN public.providers ON ((providers.provider_kod = shipments.provider_kod)))
     JOIN public.purchaseingredient ON ((purchaseingredient.shipment_kod = shipments.shipment_kod)))
     JOIN public.ingredientes ON ((ingredientes.ingredient_kod = purchaseingredient.ingredient_kod)))
  GROUP BY smeta.smeta_number, (concat('Дата поставки: ', smeta.smeta_date)), (concat(providers.provider_name, ', ОКПО: ', providers.provider_okpo));
     DROP VIEW public.postavki_list;
       public          postgres    false    241    221    221    221    231    231    223    241    241    243    243    243    223    223            �           0    0    TABLE postavki_list    ACL     y   GRANT SELECT ON TABLE public.postavki_list TO res_administrator;
GRANT SELECT ON TABLE public.postavki_list TO res_chef;
          public          postgres    false    255            �            1259    26296    providers_provider_kod_seq    SEQUENCE     �   CREATE SEQUENCE public.providers_provider_kod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.providers_provider_kod_seq;
       public          postgres    false    221            �           0    0    providers_provider_kod_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.providers_provider_kod_seq OWNED BY public.providers.provider_kod;
          public          postgres    false    220            �           0    0 #   SEQUENCE providers_provider_kod_seq    ACL     N   GRANT SELECT,USAGE ON SEQUENCE public.providers_provider_kod_seq TO res_chef;
          public          postgres    false    220            �            1259    26418 #   purchaseingredient_purchase_kod_seq    SEQUENCE     �   CREATE SEQUENCE public.purchaseingredient_purchase_kod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.purchaseingredient_purchase_kod_seq;
       public          postgres    false    243            �           0    0 #   purchaseingredient_purchase_kod_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.purchaseingredient_purchase_kod_seq OWNED BY public.purchaseingredient.purchase_kod;
          public          postgres    false    242            �           0    0 ,   SEQUENCE purchaseingredient_purchase_kod_seq    ACL     W   GRANT SELECT,USAGE ON SEQUENCE public.purchaseingredient_purchase_kod_seq TO res_chef;
          public          postgres    false    242            �            1259    26401    shipments_shipment_kod_seq    SEQUENCE     �   CREATE SEQUENCE public.shipments_shipment_kod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.shipments_shipment_kod_seq;
       public          postgres    false    241            �           0    0    shipments_shipment_kod_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.shipments_shipment_kod_seq OWNED BY public.shipments.shipment_kod;
          public          postgres    false    240            �           0    0 #   SEQUENCE shipments_shipment_kod_seq    ACL     N   GRANT SELECT,USAGE ON SEQUENCE public.shipments_shipment_kod_seq TO res_chef;
          public          postgres    false    240            �            1259    26303    smeta_smeta_kod_seq    SEQUENCE     �   CREATE SEQUENCE public.smeta_smeta_kod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.smeta_smeta_kod_seq;
       public          postgres    false    223            �           0    0    smeta_smeta_kod_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.smeta_smeta_kod_seq OWNED BY public.smeta.smeta_kod;
          public          postgres    false    222            �           0    0    SEQUENCE smeta_smeta_kod_seq    ACL     G   GRANT SELECT,USAGE ON SEQUENCE public.smeta_smeta_kod_seq TO res_chef;
          public          postgres    false    222            �            1259    26435    sostav_sostav_kod_seq    SEQUENCE     �   CREATE SEQUENCE public.sostav_sostav_kod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.sostav_sostav_kod_seq;
       public          postgres    false    245            �           0    0    sostav_sostav_kod_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.sostav_sostav_kod_seq OWNED BY public.sostav.sostav_kod;
          public          postgres    false    244            �           0    0    SEQUENCE sostav_sostav_kod_seq    ACL     I   GRANT SELECT,USAGE ON SEQUENCE public.sostav_sostav_kod_seq TO res_chef;
          public          postgres    false    244            �            1259    26318    status    TABLE     @  CREATE TABLE public.status (
    status_value character varying(50) NOT NULL,
    status_kod integer NOT NULL,
    CONSTRAINT ch_value_status_value CHECK (((status_value)::text = ANY ((ARRAY['Выдан'::character varying, 'Ожидается'::character varying, 'В готовке'::character varying])::text[])))
);
    DROP TABLE public.status;
       public         heap    postgres    false            �            1259    26317    status_status_kod_seq    SEQUENCE     �   CREATE SEQUENCE public.status_status_kod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.status_status_kod_seq;
       public          postgres    false    227            �           0    0    status_status_kod_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.status_status_kod_seq OWNED BY public.status.status_kod;
          public          postgres    false    226            �            1259    26291    visitors    TABLE     �   CREATE TABLE public.visitors (
    v_surname character varying(50) NOT NULL,
    v_name character varying(50) NOT NULL,
    v_patronymic character varying(50) DEFAULT '-'::character varying,
    v_kod character varying(5) NOT NULL
);
    DROP TABLE public.visitors;
       public         heap    postgres    false            �           0    0    TABLE visitors    ACL     �   GRANT INSERT,UPDATE ON TABLE public.visitors TO res_waiter;
GRANT SELECT,UPDATE ON TABLE public.visitors TO res_dguest;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.visitors TO res_administrator;
          public          postgres    false    219            �            1259    26338    wood_tables_table_kod_seq    SEQUENCE     �   CREATE SEQUENCE public.wood_tables_table_kod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.wood_tables_table_kod_seq;
       public          postgres    false    233            �           0    0    wood_tables_table_kod_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.wood_tables_table_kod_seq OWNED BY public.wood_tables.table_kod;
          public          postgres    false    232            �            1259    26325    zones    TABLE     l   CREATE TABLE public.zones (
    zona_name character varying(100) NOT NULL,
    zona_kod integer NOT NULL
);
    DROP TABLE public.zones;
       public         heap    postgres    false            �           0    0    TABLE zones    ACL     2   GRANT SELECT ON TABLE public.zones TO res_waiter;
          public          postgres    false    229            �            1259    43245 
   zones_list    VIEW     �  CREATE VIEW public.zones_list AS
 SELECT zones.zona_name AS "Зона",
    string_agg(concat(wood_tables.wood_table_name, ' (', wood_tables.table_placescount, ' места)'), ', '::text) AS "Столы",
    count(wood_tables.table_kod) AS "Кол-во столов",
    sum(wood_tables.table_placescount) AS "Кол-во мест"
   FROM (public.zones
     JOIN public.wood_tables ON ((wood_tables.zona_kod = zones.zona_kod)))
  GROUP BY zones.zona_name;
    DROP VIEW public.zones_list;
       public          postgres    false    233    233    233    229    229    233            �           0    0    TABLE zones_list    ACL     �   GRANT SELECT ON TABLE public.zones_list TO res_administrator;
GRANT SELECT ON TABLE public.zones_list TO res_dguest;
GRANT SELECT ON TABLE public.zones_list TO res_guest;
GRANT SELECT ON TABLE public.zones_list TO res_waiter;
          public          postgres    false    252            �            1259    26324    zones_zona_kod_seq    SEQUENCE     �   CREATE SEQUENCE public.zones_zona_kod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.zones_zona_kod_seq;
       public          postgres    false    229            �           0    0    zones_zona_kod_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.zones_zona_kod_seq OWNED BY public.zones.zona_kod;
          public          postgres    false    228            �           2604    26666    booking booking_kod    DEFAULT     z   ALTER TABLE ONLY public.booking ALTER COLUMN booking_kod SET DEFAULT nextval('public.booking_booking_kod_seq'::regclass);
 B   ALTER TABLE public.booking ALTER COLUMN booking_kod DROP DEFAULT;
       public          postgres    false    247    246    247            �           2604    26381    checkues checkue_kod    DEFAULT     |   ALTER TABLE ONLY public.checkues ALTER COLUMN checkue_kod SET DEFAULT nextval('public.checkues_checkue_kod_seq'::regclass);
 C   ALTER TABLE public.checkues ALTER COLUMN checkue_kod DROP DEFAULT;
       public          postgres    false    237    236    237            �           2604    26314    dishes dish_kod    DEFAULT     r   ALTER TABLE ONLY public.dishes ALTER COLUMN dish_kod SET DEFAULT nextval('public.dishes_dish_kod_seq'::regclass);
 >   ALTER TABLE public.dishes ALTER COLUMN dish_kod DROP DEFAULT;
       public          postgres    false    224    225    225            �           2604    26283    employee employee_kod    DEFAULT     ~   ALTER TABLE ONLY public.employee ALTER COLUMN employee_kod SET DEFAULT nextval('public.employee_employee_kod_seq'::regclass);
 D   ALTER TABLE public.employee ALTER COLUMN employee_kod DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    26393 $   individualorders individualorder_kod    DEFAULT     �   ALTER TABLE ONLY public.individualorders ALTER COLUMN individualorder_kod SET DEFAULT nextval('public.individualorders_individualorder_kod_seq'::regclass);
 S   ALTER TABLE public.individualorders ALTER COLUMN individualorder_kod DROP DEFAULT;
       public          postgres    false    239    238    239            �           2604    26335    ingredientes ingredient_kod    DEFAULT     �   ALTER TABLE ONLY public.ingredientes ALTER COLUMN ingredient_kod SET DEFAULT nextval('public.ingredientes_ingredient_kod_seq'::regclass);
 J   ALTER TABLE public.ingredientes ALTER COLUMN ingredient_kod DROP DEFAULT;
       public          postgres    false    230    231    231            �           2604    26354    orders order_kod    DEFAULT     t   ALTER TABLE ONLY public.orders ALTER COLUMN order_kod SET DEFAULT nextval('public.orders_order_kod_seq'::regclass);
 ?   ALTER TABLE public.orders ALTER COLUMN order_kod DROP DEFAULT;
       public          postgres    false    235    234    235            �           2604    26737 #   planning_dishes planning_dishes_kod    DEFAULT     �   ALTER TABLE ONLY public.planning_dishes ALTER COLUMN planning_dishes_kod SET DEFAULT nextval('public.planning_dishes_planning_dishes_kod_seq'::regclass);
 R   ALTER TABLE public.planning_dishes ALTER COLUMN planning_dishes_kod DROP DEFAULT;
       public          postgres    false    250    251    251            �           2604    26695 "   planning_orders planning_order_kod    DEFAULT     �   ALTER TABLE ONLY public.planning_orders ALTER COLUMN planning_order_kod SET DEFAULT nextval('public.planning_orders_planning_order_kod_seq'::regclass);
 Q   ALTER TABLE public.planning_orders ALTER COLUMN planning_order_kod DROP DEFAULT;
       public          postgres    false    248    249    249            �           2604    26300    providers provider_kod    DEFAULT     �   ALTER TABLE ONLY public.providers ALTER COLUMN provider_kod SET DEFAULT nextval('public.providers_provider_kod_seq'::regclass);
 E   ALTER TABLE public.providers ALTER COLUMN provider_kod DROP DEFAULT;
       public          postgres    false    220    221    221            �           2604    26422    purchaseingredient purchase_kod    DEFAULT     �   ALTER TABLE ONLY public.purchaseingredient ALTER COLUMN purchase_kod SET DEFAULT nextval('public.purchaseingredient_purchase_kod_seq'::regclass);
 N   ALTER TABLE public.purchaseingredient ALTER COLUMN purchase_kod DROP DEFAULT;
       public          postgres    false    242    243    243            �           2604    26405    shipments shipment_kod    DEFAULT     �   ALTER TABLE ONLY public.shipments ALTER COLUMN shipment_kod SET DEFAULT nextval('public.shipments_shipment_kod_seq'::regclass);
 E   ALTER TABLE public.shipments ALTER COLUMN shipment_kod DROP DEFAULT;
       public          postgres    false    241    240    241            �           2604    26307    smeta smeta_kod    DEFAULT     r   ALTER TABLE ONLY public.smeta ALTER COLUMN smeta_kod SET DEFAULT nextval('public.smeta_smeta_kod_seq'::regclass);
 >   ALTER TABLE public.smeta ALTER COLUMN smeta_kod DROP DEFAULT;
       public          postgres    false    222    223    223            �           2604    26439    sostav sostav_kod    DEFAULT     v   ALTER TABLE ONLY public.sostav ALTER COLUMN sostav_kod SET DEFAULT nextval('public.sostav_sostav_kod_seq'::regclass);
 @   ALTER TABLE public.sostav ALTER COLUMN sostav_kod DROP DEFAULT;
       public          postgres    false    245    244    245            �           2604    26321    status status_kod    DEFAULT     v   ALTER TABLE ONLY public.status ALTER COLUMN status_kod SET DEFAULT nextval('public.status_status_kod_seq'::regclass);
 @   ALTER TABLE public.status ALTER COLUMN status_kod DROP DEFAULT;
       public          postgres    false    227    226    227            �           2604    26342    wood_tables table_kod    DEFAULT     ~   ALTER TABLE ONLY public.wood_tables ALTER COLUMN table_kod SET DEFAULT nextval('public.wood_tables_table_kod_seq'::regclass);
 D   ALTER TABLE public.wood_tables ALTER COLUMN table_kod DROP DEFAULT;
       public          postgres    false    233    232    233            �           2604    26328    zones zona_kod    DEFAULT     p   ALTER TABLE ONLY public.zones ALTER COLUMN zona_kod SET DEFAULT nextval('public.zones_zona_kod_seq'::regclass);
 =   ALTER TABLE public.zones ALTER COLUMN zona_kod DROP DEFAULT;
       public          postgres    false    229    228    229            >          0    26663    booking 
   TABLE DATA           �   COPY public.booking (booking_kod, book_number, book_making_date, book_making_time, book_plan_date, book_plan_time, book_guests_count, wood_table_kod, v_kod) FROM stdin;
    public          postgres    false    247   ��      4          0    26378    checkues 
   TABLE DATA           �   COPY public.checkues (checkue_number, checkue_date, checkue_time, checkue_sumfinal, checkue_sumgotten, checkue_changesum, checkue_paytype, checkue_finalcost, checkue_kod, order_kod, order_name) FROM stdin;
    public          postgres    false    237   ��      (          0    26311    dishes 
   TABLE DATA           [   COPY public.dishes (dish_name, dish_cost, dish_weight, dish_kod, dish_picture) FROM stdin;
    public          postgres    false    225   N�                 0    26280    employee 
   TABLE DATA           �   COPY public.employee (employee_kod, employee_surname, employee_name, employee_patronymic, employee_login, employee_password) FROM stdin;
    public          postgres    false    217   �      6          0    26390    individualorders 
   TABLE DATA           ^   COPY public.individualorders (individualorder_kod, order_kod, v_kod, person_cost) FROM stdin;
    public          postgres    false    239   ��      .          0    26332    ingredientes 
   TABLE DATA           G   COPY public.ingredientes (ingredient_name, ingredient_kod) FROM stdin;
    public          postgres    false    231   *�      2          0    26351    orders 
   TABLE DATA           �   COPY public.orders (order_name, order_dishcount, order_dishtime, order_date, order_opentime, order_kod, table_kod, employee_kod, status_kod, dish_kod) FROM stdin;
    public          postgres    false    235   ��      C          0    59703    orders_history 
   TABLE DATA           �   COPY public.orders_history (id_orders_history, order_name, wood_table_name, sostav, orders_history_status, timestamp_create) FROM stdin;
    public          postgres    false    258   y�      B          0    26734    planning_dishes 
   TABLE DATA           y   COPY public.planning_dishes (planning_dishes_kod, planning_dishes_time, dish_kod, dishes_count, book_number) FROM stdin;
    public          postgres    false    251   ��      @          0    26692    planning_orders 
   TABLE DATA           R   COPY public.planning_orders (planning_order_kod, order_kod, book_kod) FROM stdin;
    public          postgres    false    249   ^�      $          0    26297 	   providers 
   TABLE DATA           �   COPY public.providers (provider_city, provider_street, provider_house, provider_flatnumber, provider_name, provider_okpo, provider_kod) FROM stdin;
    public          postgres    false    221   {�      :          0    26419    purchaseingredient 
   TABLE DATA           k   COPY public.purchaseingredient (purchase_kod, ingredient_weight, shipment_kod, ingredient_kod) FROM stdin;
    public          postgres    false    243   #       !          0    26286    registered_visitors 
   TABLE DATA           �   COPY public.registered_visitors (rv_surname, rv_name, rv_patronymic, rv_login, rv_password, rv_pasports, rv_pasportn, rv_card, rv_kod) FROM stdin;
    public          postgres    false    218   a       8          0    26402 	   shipments 
   TABLE DATA           J   COPY public.shipments (shipment_kod, smeta_kod, provider_kod) FROM stdin;
    public          postgres    false    241   @      &          0    26304    smeta 
   TABLE DATA           D   COPY public.smeta (smeta_date, smeta_number, smeta_kod) FROM stdin;
    public          postgres    false    223   g      <          0    26436    sostav 
   TABLE DATA           F   COPY public.sostav (sostav_kod, ingredient_kod, dish_kod) FROM stdin;
    public          postgres    false    245   �      *          0    26318    status 
   TABLE DATA           :   COPY public.status (status_value, status_kod) FROM stdin;
    public          postgres    false    227         "          0    26291    visitors 
   TABLE DATA           J   COPY public.visitors (v_surname, v_name, v_patronymic, v_kod) FROM stdin;
    public          postgres    false    219   K      0          0    26339    wood_tables 
   TABLE DATA           ^   COPY public.wood_tables (table_placescount, wood_table_name, table_kod, zona_kod) FROM stdin;
    public          postgres    false    233   �      ,          0    26325    zones 
   TABLE DATA           4   COPY public.zones (zona_name, zona_kod) FROM stdin;
    public          postgres    false    229   9      �           0    0    booking_booking_kod_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.booking_booking_kod_seq', 17, true);
          public          postgres    false    246            �           0    0    checkues_checkue_kod_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.checkues_checkue_kod_seq', 4, true);
          public          postgres    false    236            �           0    0    dishes_dish_kod_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.dishes_dish_kod_seq', 11, true);
          public          postgres    false    224            �           0    0    employee_employee_kod_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.employee_employee_kod_seq', 7, true);
          public          postgres    false    216            �           0    0 (   individualorders_individualorder_kod_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.individualorders_individualorder_kod_seq', 15, true);
          public          postgres    false    238            �           0    0    ingredientes_ingredient_kod_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.ingredientes_ingredient_kod_seq', 44, true);
          public          postgres    false    230            �           0    0    orders_order_kod_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.orders_order_kod_seq', 20, true);
          public          postgres    false    234            �           0    0 '   planning_dishes_planning_dishes_kod_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('public.planning_dishes_planning_dishes_kod_seq', 5, true);
          public          postgres    false    250            �           0    0 &   planning_orders_planning_order_kod_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('public.planning_orders_planning_order_kod_seq', 1, false);
          public          postgres    false    248            �           0    0    providers_provider_kod_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.providers_provider_kod_seq', 5, true);
          public          postgres    false    220            �           0    0 #   purchaseingredient_purchase_kod_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.purchaseingredient_purchase_kod_seq', 11, true);
          public          postgres    false    242            �           0    0    shipments_shipment_kod_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.shipments_shipment_kod_seq', 5, true);
          public          postgres    false    240            �           0    0    smeta_smeta_kod_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.smeta_smeta_kod_seq', 5, true);
          public          postgres    false    222            �           0    0    sostav_sostav_kod_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.sostav_sostav_kod_seq', 41, true);
          public          postgres    false    244            �           0    0    status_status_kod_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.status_status_kod_seq', 5, true);
          public          postgres    false    226            �           0    0    wood_tables_table_kod_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.wood_tables_table_kod_seq', 11, true);
          public          postgres    false    232            �           0    0    zones_zona_kod_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.zones_zona_kod_seq', 7, true);
          public          postgres    false    228            k           2606    26672    booking pk_booking_kod 
   CONSTRAINT     ]   ALTER TABLE ONLY public.booking
    ADD CONSTRAINT pk_booking_kod PRIMARY KEY (booking_kod);
 @   ALTER TABLE ONLY public.booking DROP CONSTRAINT pk_booking_kod;
       public            postgres    false    247            X           2606    26383    checkues pk_checkues 
   CONSTRAINT     [   ALTER TABLE ONLY public.checkues
    ADD CONSTRAINT pk_checkues PRIMARY KEY (checkue_kod);
 >   ALTER TABLE ONLY public.checkues DROP CONSTRAINT pk_checkues;
       public            postgres    false    237            6           2606    26316    dishes pk_dishes 
   CONSTRAINT     T   ALTER TABLE ONLY public.dishes
    ADD CONSTRAINT pk_dishes PRIMARY KEY (dish_kod);
 :   ALTER TABLE ONLY public.dishes DROP CONSTRAINT pk_dishes;
       public            postgres    false    225                       2606    26285    employee pk_employee 
   CONSTRAINT     \   ALTER TABLE ONLY public.employee
    ADD CONSTRAINT pk_employee PRIMARY KEY (employee_kod);
 >   ALTER TABLE ONLY public.employee DROP CONSTRAINT pk_employee;
       public            postgres    false    217            ]           2606    26395 $   individualorders pk_individualorders 
   CONSTRAINT     s   ALTER TABLE ONLY public.individualorders
    ADD CONSTRAINT pk_individualorders PRIMARY KEY (individualorder_kod);
 N   ALTER TABLE ONLY public.individualorders DROP CONSTRAINT pk_individualorders;
       public            postgres    false    239            F           2606    26337    ingredientes pk_ingredientes 
   CONSTRAINT     f   ALTER TABLE ONLY public.ingredientes
    ADD CONSTRAINT pk_ingredientes PRIMARY KEY (ingredient_kod);
 F   ALTER TABLE ONLY public.ingredientes DROP CONSTRAINT pk_ingredientes;
       public            postgres    false    231            S           2606    26356    orders pk_orders 
   CONSTRAINT     U   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT pk_orders PRIMARY KEY (order_kod);
 :   ALTER TABLE ONLY public.orders DROP CONSTRAINT pk_orders;
       public            postgres    false    235            u           2606    59712     orders_history pk_orders_history 
   CONSTRAINT     m   ALTER TABLE ONLY public.orders_history
    ADD CONSTRAINT pk_orders_history PRIMARY KEY (id_orders_history);
 J   ALTER TABLE ONLY public.orders_history DROP CONSTRAINT pk_orders_history;
       public            postgres    false    258            s           2606    26739     planning_dishes pk_plan_dish_kod 
   CONSTRAINT     o   ALTER TABLE ONLY public.planning_dishes
    ADD CONSTRAINT pk_plan_dish_kod PRIMARY KEY (planning_dishes_kod);
 J   ALTER TABLE ONLY public.planning_dishes DROP CONSTRAINT pk_plan_dish_kod;
       public            postgres    false    251            p           2606    26697 %   planning_orders pk_planning_order_kod 
   CONSTRAINT     s   ALTER TABLE ONLY public.planning_orders
    ADD CONSTRAINT pk_planning_order_kod PRIMARY KEY (planning_order_kod);
 O   ALTER TABLE ONLY public.planning_orders DROP CONSTRAINT pk_planning_order_kod;
       public            postgres    false    249            *           2606    26302    providers pk_providers 
   CONSTRAINT     ^   ALTER TABLE ONLY public.providers
    ADD CONSTRAINT pk_providers PRIMARY KEY (provider_kod);
 @   ALTER TABLE ONLY public.providers DROP CONSTRAINT pk_providers;
       public            postgres    false    221            c           2606    26424 (   purchaseingredient pk_purchaseingredient 
   CONSTRAINT     p   ALTER TABLE ONLY public.purchaseingredient
    ADD CONSTRAINT pk_purchaseingredient PRIMARY KEY (purchase_kod);
 R   ALTER TABLE ONLY public.purchaseingredient DROP CONSTRAINT pk_purchaseingredient;
       public            postgres    false    243                        2606    26290 *   registered_visitors pk_registered_visitors 
   CONSTRAINT     l   ALTER TABLE ONLY public.registered_visitors
    ADD CONSTRAINT pk_registered_visitors PRIMARY KEY (rv_kod);
 T   ALTER TABLE ONLY public.registered_visitors DROP CONSTRAINT pk_registered_visitors;
       public            postgres    false    218            `           2606    26407    shipments pk_shipments 
   CONSTRAINT     ^   ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT pk_shipments PRIMARY KEY (shipment_kod);
 @   ALTER TABLE ONLY public.shipments DROP CONSTRAINT pk_shipments;
       public            postgres    false    241            0           2606    26309    smeta pk_smeta 
   CONSTRAINT     S   ALTER TABLE ONLY public.smeta
    ADD CONSTRAINT pk_smeta PRIMARY KEY (smeta_kod);
 8   ALTER TABLE ONLY public.smeta DROP CONSTRAINT pk_smeta;
       public            postgres    false    223            f           2606    26441    sostav pk_sostav 
   CONSTRAINT     V   ALTER TABLE ONLY public.sostav
    ADD CONSTRAINT pk_sostav PRIMARY KEY (sostav_kod);
 :   ALTER TABLE ONLY public.sostav DROP CONSTRAINT pk_sostav;
       public            postgres    false    245            <           2606    26323    status pk_status 
   CONSTRAINT     V   ALTER TABLE ONLY public.status
    ADD CONSTRAINT pk_status PRIMARY KEY (status_kod);
 :   ALTER TABLE ONLY public.status DROP CONSTRAINT pk_status;
       public            postgres    false    227            $           2606    26295    visitors pk_visitors 
   CONSTRAINT     U   ALTER TABLE ONLY public.visitors
    ADD CONSTRAINT pk_visitors PRIMARY KEY (v_kod);
 >   ALTER TABLE ONLY public.visitors DROP CONSTRAINT pk_visitors;
       public            postgres    false    219            L           2606    26344    wood_tables pk_wood_tables 
   CONSTRAINT     _   ALTER TABLE ONLY public.wood_tables
    ADD CONSTRAINT pk_wood_tables PRIMARY KEY (table_kod);
 D   ALTER TABLE ONLY public.wood_tables DROP CONSTRAINT pk_wood_tables;
       public            postgres    false    233            @           2606    26330    zones pk_zones 
   CONSTRAINT     R   ALTER TABLE ONLY public.zones
    ADD CONSTRAINT pk_zones PRIMARY KEY (zona_kod);
 8   ALTER TABLE ONLY public.zones DROP CONSTRAINT pk_zones;
       public            postgres    false    229            m           2606    35049    booking uq_value_book_number 
   CONSTRAINT     ^   ALTER TABLE ONLY public.booking
    ADD CONSTRAINT uq_value_book_number UNIQUE (book_number);
 F   ALTER TABLE ONLY public.booking DROP CONSTRAINT uq_value_book_number;
       public            postgres    false    247            Z           2606    26570     checkues uq_value_checkue_number 
   CONSTRAINT     e   ALTER TABLE ONLY public.checkues
    ADD CONSTRAINT uq_value_checkue_number UNIQUE (checkue_number);
 J   ALTER TABLE ONLY public.checkues DROP CONSTRAINT uq_value_checkue_number;
       public            postgres    false    237            8           2606    26609    dishes uq_value_dish_name 
   CONSTRAINT     Y   ALTER TABLE ONLY public.dishes
    ADD CONSTRAINT uq_value_dish_name UNIQUE (dish_name);
 C   ALTER TABLE ONLY public.dishes DROP CONSTRAINT uq_value_dish_name;
       public            postgres    false    225            H           2606    26622 %   ingredientes uq_value_ingredient_name 
   CONSTRAINT     k   ALTER TABLE ONLY public.ingredientes
    ADD CONSTRAINT uq_value_ingredient_name UNIQUE (ingredient_name);
 O   ALTER TABLE ONLY public.ingredientes DROP CONSTRAINT uq_value_ingredient_name;
       public            postgres    false    231            ,           2606    26585     providers uq_value_provider_okpo 
   CONSTRAINT     d   ALTER TABLE ONLY public.providers
    ADD CONSTRAINT uq_value_provider_okpo UNIQUE (provider_okpo);
 J   ALTER TABLE ONLY public.providers DROP CONSTRAINT uq_value_provider_okpo;
       public            postgres    false    221            2           2606    26590    smeta uq_value_smeta_number 
   CONSTRAINT     ^   ALTER TABLE ONLY public.smeta
    ADD CONSTRAINT uq_value_smeta_number UNIQUE (smeta_number);
 E   ALTER TABLE ONLY public.smeta DROP CONSTRAINT uq_value_smeta_number;
       public            postgres    false    223            N           2606    26601 $   wood_tables uq_value_wood_table_name 
   CONSTRAINT     j   ALTER TABLE ONLY public.wood_tables
    ADD CONSTRAINT uq_value_wood_table_name UNIQUE (wood_table_name);
 N   ALTER TABLE ONLY public.wood_tables DROP CONSTRAINT uq_value_wood_table_name;
       public            postgres    false    233            B           2606    26620    zones uq_value_zona_name 
   CONSTRAINT     X   ALTER TABLE ONLY public.zones
    ADD CONSTRAINT uq_value_zona_name UNIQUE (zona_name);
 B   ALTER TABLE ONLY public.zones DROP CONSTRAINT uq_value_zona_name;
       public            postgres    false    229            g           1259    26688    index_booking_kod    INDEX     L   CREATE INDEX index_booking_kod ON public.booking USING btree (booking_kod);
 %   DROP INDEX public.index_booking_kod;
       public            postgres    false    247                       1259    26482    index_card_rv    INDEX     P   CREATE INDEX index_card_rv ON public.registered_visitors USING btree (rv_card);
 !   DROP INDEX public.index_card_rv;
       public            postgres    false    218            T           1259    26472    index_date_time_checkue    INDEX     b   CREATE INDEX index_date_time_checkue ON public.checkues USING btree (checkue_date, checkue_time);
 +   DROP INDEX public.index_date_time_checkue;
       public            postgres    false    237    237            O           1259    26475    index_date_time_order    INDEX     n   CREATE INDEX index_date_time_order ON public.orders USING btree (order_dishtime, order_date, order_opentime);
 )   DROP INDEX public.index_date_time_order;
       public            postgres    false    235    235    235                       1259    26484    index_fio_employee    INDEX     w   CREATE INDEX index_fio_employee ON public.employee USING btree (employee_name, employee_surname, employee_patronymic);
 &   DROP INDEX public.index_fio_employee;
       public            postgres    false    217    217    217                       1259    26479    index_fio_rv    INDEX     j   CREATE INDEX index_fio_rv ON public.registered_visitors USING btree (rv_name, rv_surname, rv_patronymic);
     DROP INDEX public.index_fio_rv;
       public            postgres    false    218    218    218            !           1259    26477    index_fio_visitor    INDEX     a   CREATE INDEX index_fio_visitor ON public.visitors USING btree (v_surname, v_name, v_patronymic);
 %   DROP INDEX public.index_fio_visitor;
       public            postgres    false    219    219    219            U           1259    26473    index_kod_checkue    INDEX     M   CREATE INDEX index_kod_checkue ON public.checkues USING btree (checkue_kod);
 %   DROP INDEX public.index_kod_checkue;
       public            postgres    false    237            3           1259    26462    index_kod_dish    INDEX     E   CREATE INDEX index_kod_dish ON public.dishes USING btree (dish_kod);
 "   DROP INDEX public.index_kod_dish;
       public            postgres    false    225            [           1259    26455    index_kod_individualorders    INDEX     f   CREATE INDEX index_kod_individualorders ON public.individualorders USING btree (individualorder_kod);
 .   DROP INDEX public.index_kod_individualorders;
       public            postgres    false    239            C           1259    26456    index_kod_ingredient    INDEX     W   CREATE INDEX index_kod_ingredient ON public.ingredientes USING btree (ingredient_kod);
 (   DROP INDEX public.index_kod_ingredient;
       public            postgres    false    231            P           1259    26476    index_kod_order    INDEX     G   CREATE INDEX index_kod_order ON public.orders USING btree (order_kod);
 #   DROP INDEX public.index_kod_order;
       public            postgres    false    235            %           1259    26470    index_kod_provider    INDEX     P   CREATE INDEX index_kod_provider ON public.providers USING btree (provider_kod);
 &   DROP INDEX public.index_kod_provider;
       public            postgres    false    221            a           1259    26454    index_kod_purchaseingredient    INDEX     c   CREATE INDEX index_kod_purchaseingredient ON public.purchaseingredient USING btree (purchase_kod);
 0   DROP INDEX public.index_kod_purchaseingredient;
       public            postgres    false    243                       1259    26483    index_kod_rv    INDEX     N   CREATE INDEX index_kod_rv ON public.registered_visitors USING btree (rv_kod);
     DROP INDEX public.index_kod_rv;
       public            postgres    false    218            ^           1259    26453    index_kod_shipments    INDEX     Q   CREATE INDEX index_kod_shipments ON public.shipments USING btree (shipment_kod);
 '   DROP INDEX public.index_kod_shipments;
       public            postgres    false    241            -           1259    26466    index_kod_smeta    INDEX     F   CREATE INDEX index_kod_smeta ON public.smeta USING btree (smeta_kod);
 #   DROP INDEX public.index_kod_smeta;
       public            postgres    false    223            d           1259    26452    index_kod_sostav    INDEX     I   CREATE INDEX index_kod_sostav ON public.sostav USING btree (sostav_kod);
 $   DROP INDEX public.index_kod_sostav;
       public            postgres    false    245            9           1259    26460    index_kod_status    INDEX     I   CREATE INDEX index_kod_status ON public.status USING btree (status_kod);
 $   DROP INDEX public.index_kod_status;
       public            postgres    false    227            I           1259    26464    index_kod_table    INDEX     L   CREATE INDEX index_kod_table ON public.wood_tables USING btree (table_kod);
 #   DROP INDEX public.index_kod_table;
       public            postgres    false    233            "           1259    26478    index_kod_visitor    INDEX     G   CREATE INDEX index_kod_visitor ON public.visitors USING btree (v_kod);
 %   DROP INDEX public.index_kod_visitor;
       public            postgres    false    219            =           1259    26458    index_kod_zones    INDEX     E   CREATE INDEX index_kod_zones ON public.zones USING btree (zona_kod);
 #   DROP INDEX public.index_kod_zones;
       public            postgres    false    229            &           1259    26467    index_location_provider    INDEX     �   CREATE INDEX index_location_provider ON public.providers USING btree (provider_city, provider_street, provider_house, provider_flatnumber);
 +   DROP INDEX public.index_location_provider;
       public            postgres    false    221    221    221    221                       1259    26485    index_login_password_employee    INDEX     �   CREATE INDEX index_login_password_employee ON public.employee USING btree (employee_password, employee_login, employee_patronymic);
 1   DROP INDEX public.index_login_password_employee;
       public            postgres    false    217    217    217                       1259    26480    index_login_password_rv    INDEX     h   CREATE INDEX index_login_password_rv ON public.registered_visitors USING btree (rv_login, rv_password);
 +   DROP INDEX public.index_login_password_rv;
       public            postgres    false    218    218            h           1259    26690    index_making_timedate    INDEX     g   CREATE INDEX index_making_timedate ON public.booking USING btree (book_making_date, book_making_time);
 )   DROP INDEX public.index_making_timedate;
       public            postgres    false    247    247            4           1259    26461    index_name_dish    INDEX     G   CREATE INDEX index_name_dish ON public.dishes USING btree (dish_name);
 #   DROP INDEX public.index_name_dish;
       public            postgres    false    225            D           1259    26457    index_name_ingredient    INDEX     Y   CREATE INDEX index_name_ingredient ON public.ingredientes USING btree (ingredient_name);
 )   DROP INDEX public.index_name_ingredient;
       public            postgres    false    231            Q           1259    26474    index_name_order    INDEX     I   CREATE INDEX index_name_order ON public.orders USING btree (order_name);
 $   DROP INDEX public.index_name_order;
       public            postgres    false    235            '           1259    26468    index_name_provider    INDEX     R   CREATE INDEX index_name_provider ON public.providers USING btree (provider_name);
 '   DROP INDEX public.index_name_provider;
       public            postgres    false    221            J           1259    26463    index_name_table    INDEX     S   CREATE INDEX index_name_table ON public.wood_tables USING btree (wood_table_name);
 $   DROP INDEX public.index_name_table;
       public            postgres    false    233            >           1259    26459    index_name_zones    INDEX     F   CREATE INDEX index_name_zones ON public.zones USING btree (zona_kod);
 $   DROP INDEX public.index_name_zones;
       public            postgres    false    229            V           1259    26471    index_number_checkue    INDEX     S   CREATE INDEX index_number_checkue ON public.checkues USING btree (checkue_number);
 (   DROP INDEX public.index_number_checkue;
       public            postgres    false    237            .           1259    26465    index_number_smeta    INDEX     L   CREATE INDEX index_number_smeta ON public.smeta USING btree (smeta_number);
 &   DROP INDEX public.index_number_smeta;
       public            postgres    false    223            (           1259    26469    index_okpo_provider    INDEX     R   CREATE INDEX index_okpo_provider ON public.providers USING btree (provider_okpo);
 '   DROP INDEX public.index_okpo_provider;
       public            postgres    false    221                       1259    26481    index_pasportsn_rv    INDEX     f   CREATE INDEX index_pasportsn_rv ON public.registered_visitors USING btree (rv_pasports, rv_pasportn);
 &   DROP INDEX public.index_pasportsn_rv;
       public            postgres    false    218    218            i           1259    26689    index_plan_timedate    INDEX     a   CREATE INDEX index_plan_timedate ON public.booking USING btree (book_plan_date, book_plan_date);
 '   DROP INDEX public.index_plan_timedate;
       public            postgres    false    247            q           1259    26750    index_planing_dishes_kod    INDEX     c   CREATE INDEX index_planing_dishes_kod ON public.planning_dishes USING btree (planning_dishes_kod);
 ,   DROP INDEX public.index_planing_dishes_kod;
       public            postgres    false    251            n           1259    26708    index_planning_order_kod    INDEX     b   CREATE INDEX index_planning_order_kod ON public.planning_orders USING btree (planning_order_kod);
 ,   DROP INDEX public.index_planning_order_kod;
       public            postgres    false    249            :           1259    26486    index_value_status    INDEX     M   CREATE INDEX index_value_status ON public.status USING btree (status_value);
 &   DROP INDEX public.index_value_status;
       public            postgres    false    227            �           2620    59723    orders tg_orders_history_delete    TRIGGER     �   CREATE TRIGGER tg_orders_history_delete BEFORE DELETE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.fc_orders_history_delete();
 8   DROP TRIGGER tg_orders_history_delete ON public.orders;
       public          postgres    false    345    235            �           2620    59717    orders tg_orders_history_insert    TRIGGER     �   CREATE TRIGGER tg_orders_history_insert AFTER INSERT ON public.orders FOR EACH ROW EXECUTE FUNCTION public.fc_orders_history_insert();
 8   DROP TRIGGER tg_orders_history_insert ON public.orders;
       public          postgres    false    342    235            �           2620    59719    orders tg_orders_history_update    TRIGGER     �   CREATE TRIGGER tg_orders_history_update AFTER UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.fc_orders_history_update();
 8   DROP TRIGGER tg_orders_history_update ON public.orders;
       public          postgres    false    343    235            �           2606    26683 #   booking booking_wood_table_kod_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_wood_table_kod_fkey FOREIGN KEY (wood_table_kod) REFERENCES public.wood_tables(table_kod);
 M   ALTER TABLE ONLY public.booking DROP CONSTRAINT booking_wood_table_kod_fkey;
       public          postgres    false    247    233    4940            {           2606    26384     checkues checkues_order_kod_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.checkues
    ADD CONSTRAINT checkues_order_kod_fkey FOREIGN KEY (order_kod) REFERENCES public.orders(order_kod);
 J   ALTER TABLE ONLY public.checkues DROP CONSTRAINT checkues_order_kod_fkey;
       public          postgres    false    237    4947    235            |           2606    26396 0   individualorders individualorders_order_kod_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.individualorders
    ADD CONSTRAINT individualorders_order_kod_fkey FOREIGN KEY (order_kod) REFERENCES public.orders(order_kod);
 Z   ALTER TABLE ONLY public.individualorders DROP CONSTRAINT individualorders_order_kod_fkey;
       public          postgres    false    239    4947    235            w           2606    26372    orders orders_dish_kod_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_dish_kod_fkey FOREIGN KEY (dish_kod) REFERENCES public.dishes(dish_kod);
 E   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_dish_kod_fkey;
       public          postgres    false    235    225    4918            x           2606    26362    orders orders_employee_kod_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_employee_kod_fkey FOREIGN KEY (employee_kod) REFERENCES public.employee(employee_kod);
 I   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_employee_kod_fkey;
       public          postgres    false    235    217    4889            y           2606    26367    orders orders_status_kod_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_status_kod_fkey FOREIGN KEY (status_kod) REFERENCES public.status(status_kod);
 G   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_status_kod_fkey;
       public          postgres    false    4924    235    227            z           2606    26357    orders orders_table_kod_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_table_kod_fkey FOREIGN KEY (table_kod) REFERENCES public.wood_tables(table_kod);
 F   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_table_kod_fkey;
       public          postgres    false    233    4940    235            �           2606    26740 -   planning_dishes planning_dishes_dish_kod_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.planning_dishes
    ADD CONSTRAINT planning_dishes_dish_kod_fkey FOREIGN KEY (dish_kod) REFERENCES public.dishes(dish_kod);
 W   ALTER TABLE ONLY public.planning_dishes DROP CONSTRAINT planning_dishes_dish_kod_fkey;
       public          postgres    false    4918    225    251            �           2606    26703 -   planning_orders planning_orders_book_kod_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.planning_orders
    ADD CONSTRAINT planning_orders_book_kod_fkey FOREIGN KEY (book_kod) REFERENCES public.booking(booking_kod);
 W   ALTER TABLE ONLY public.planning_orders DROP CONSTRAINT planning_orders_book_kod_fkey;
       public          postgres    false    247    249    4971            �           2606    26698 .   planning_orders planning_orders_order_kod_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.planning_orders
    ADD CONSTRAINT planning_orders_order_kod_fkey FOREIGN KEY (order_kod) REFERENCES public.orders(order_kod);
 X   ALTER TABLE ONLY public.planning_orders DROP CONSTRAINT planning_orders_order_kod_fkey;
       public          postgres    false    4947    249    235                       2606    26430 9   purchaseingredient purchaseingredient_ingredient_kod_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.purchaseingredient
    ADD CONSTRAINT purchaseingredient_ingredient_kod_fkey FOREIGN KEY (ingredient_kod) REFERENCES public.ingredientes(ingredient_kod);
 c   ALTER TABLE ONLY public.purchaseingredient DROP CONSTRAINT purchaseingredient_ingredient_kod_fkey;
       public          postgres    false    4934    243    231            �           2606    26425 7   purchaseingredient purchaseingredient_shipment_kod_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.purchaseingredient
    ADD CONSTRAINT purchaseingredient_shipment_kod_fkey FOREIGN KEY (shipment_kod) REFERENCES public.shipments(shipment_kod);
 a   ALTER TABLE ONLY public.purchaseingredient DROP CONSTRAINT purchaseingredient_shipment_kod_fkey;
       public          postgres    false    4960    241    243            }           2606    26413 %   shipments shipments_provider_kod_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_provider_kod_fkey FOREIGN KEY (provider_kod) REFERENCES public.providers(provider_kod);
 O   ALTER TABLE ONLY public.shipments DROP CONSTRAINT shipments_provider_kod_fkey;
       public          postgres    false    4906    221    241            ~           2606    26408 "   shipments shipments_smeta_kod_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_smeta_kod_fkey FOREIGN KEY (smeta_kod) REFERENCES public.smeta(smeta_kod);
 L   ALTER TABLE ONLY public.shipments DROP CONSTRAINT shipments_smeta_kod_fkey;
       public          postgres    false    223    4912    241            �           2606    26447    sostav sostav_dish_kod_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sostav
    ADD CONSTRAINT sostav_dish_kod_fkey FOREIGN KEY (dish_kod) REFERENCES public.dishes(dish_kod);
 E   ALTER TABLE ONLY public.sostav DROP CONSTRAINT sostav_dish_kod_fkey;
       public          postgres    false    4918    245    225            �           2606    26442 !   sostav sostav_ingredient_kod_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sostav
    ADD CONSTRAINT sostav_ingredient_kod_fkey FOREIGN KEY (ingredient_kod) REFERENCES public.ingredientes(ingredient_kod);
 K   ALTER TABLE ONLY public.sostav DROP CONSTRAINT sostav_ingredient_kod_fkey;
       public          postgres    false    245    231    4934            v           2606    26345 %   wood_tables wood_tables_zona_kod_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.wood_tables
    ADD CONSTRAINT wood_tables_zona_kod_fkey FOREIGN KEY (zona_kod) REFERENCES public.zones(zona_kod);
 O   ALTER TABLE ONLY public.wood_tables DROP CONSTRAINT wood_tables_zona_kod_fkey;
       public          postgres    false    4928    233    229            >   �   x��н� �Z�X'	l4K���"eV`��c��»J�'t*���&�$,vc��3�ͤ� �\CB�ʻ|4@GGvG�8{d�r�uu�� �FG�p�;qt��`�JI<nwYlH�]it⥋�u��Yj�l�h��<:�;���|�j���l������VfO      4   �   x�m�M
�@�u�.����v��}\�rU(�v�FT�wx���V�Vx�t�D�J�j����l$�Ur��S��`�	7�����pē�WLZ-:���Q-��;Ryf��e�b&�9畯���ʷ�/_H�������1�_7L�{���~Bx�`�      (   �   x�M�=
�@���S�	��&�x{;��DR؉����&�\�͍�l�W��}o/t��jL�K
�i���$Ɛ%��;�'W�4�|�/�ș9rtG�9�RsD����Ws�7�l��:3g�RJ���0�ص]Jf_4dW��G!�ln��q���g>��{��&J��m]          �   x�3�0���[.6\�
����;��.��Ι�R��Z������RnP��e�ya!P� �{aȘY@�v\�}a7煹@�.����
N�M��/��Cd�ya
И����.�Է��f�3�Z7@,�ᒛYR��Z��0#F��� 3w�      6   c   x�UN��0|��A.q�.�ɓ2NB���.�ha*(��b�L�p��9ݸ�6HmL�'[�O�-I��x�|Er+��2��C���+�ADH�7�      .   P  x�UQ�N�@<���=�Ÿ�ŏ1`R�&x#��u�֔�������Mwv�̼)6ء�Q���p@�(�a�[��3g�q�:!�H��g'
�;!��sX锴���+����?vZ�����$T"���N�s+��@K�&�,d��N��N;������w$'�p�H:&��?��c�m|��*O�6�U���@��{��;��Z��PC����gN-��F!t�U��j	�`M�D�����ۄ�JX�)�!��%��Uׄ9Y呚1�X�'O5ӧb����~F+ah�{��3�c�X��m����%�c��o4��s���Y�Hg�ﻧ;��oY�      2   �   x�����0E��.T~%�ҽ*u*Fj�Q���,��l���=f�g�D	E!+`" �a�۫�@I&nO��-��a�&�)�we�!��&W.J�l�(V��8��n_�b	���Wfvۤ�(��}*�JZ���=��9�W����l���f�ׇ`�����J-4�4��W����W��=6��qՇ��cǅ��luv�x��|/|��x���I��w���4M/N���      C   q  x���Q�1���S�j�$��jβ/�N�9fWa�a�������*7�f��e1PI��O��X*`(�|G@a�I�S�c���Fo/�v�:������zl�˶�������v�/�����o:�� �N�έ}\'��ϓ��$>a��K���%D�x�p���}{��~�}�nW��>�cZed��KA<&rS	R!� �8����������,��V/l{ԯO�K#�ea�g^h��BF� 1��y4�De^x���ky۶�҆�&��G����:�3��d�StƠ|�$Q)����

,^F{
��:C]�0V����A?[���o�1b\�� ���X�}�{��      B   T   x�m���0��=mWH���؀�:R[�A#?�89��B;ە\)�gtX<B𕈹�2Ũ�'�j#X`{���WB<6��_'�      @      x������ � �      $   �   x�U�1�@E��Sp���]<-��Hak�!N��F�-�����A�I��".�D'�x����*�'����4rP�H�Q�-ۜ�YNl�'<+|���+pO0KW��ՐY�}����K���p[�R�"ߺ����VƘ7�m�      :   .   x�3�445�4�4�2������LCӐ�2�2�4�,�b���� �E�      !   �   x�U�=
�@F��sXK�w��B$]`�N�����X"�y���^a�F���6�7�|�ю*7wS�S	��+Utq3?��kE%�nY<*l�Y�hL�Q���L��F�&��@'zpF;����m��x��/�:ě�8��ב�Aa۝���(Q�R!*�bpF[��{Np|��nj�aa���1��(9b�d�&c�	i��      8      x�3�4�4�2�B�=... 
      &   /   x�3202�5��54㼰��|]00�52�4�2�*i�4�����  �      <   W   x���Q��N1��;�l�uL�2X�.6��	7����e_-�jL��t���X�&�I���~�)(�MF�������7      *   .   x��0�b��-6\��i�uaޅmv��[/6]l���i����� �Y�      "   �   x�]��1c_1H@;� !XȖ��1-�uĚ'"�խv����K� .�Dߑ}�Ȗu�"�Q�@V�k����O$���g�n%�Ň�V�o5;X|/pi����3p�}~�fle���} <>x}      0   M   x�-�;�0 ����?�K�d.��(��Q-+��-g�w<��b� ҍ�)+��s��ٕ�gv�JE�J�lX��D���      ,   A   x��0��֋M/캰�b���]�{a�ׅ�@�ƋM .��1ׅy6^�D5����� �/h     