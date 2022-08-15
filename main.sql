-- 1. Пилоты, которые в качестве второго пилота в августе этого
-- года трижды летали в аэропорт Шереметьево.

SELECT pilot.* FROM pilot
JOIN flights ON flights.second_pilot_id = pilot.pilot_id
WHERE YEAR(flights.flight_dt) = 2022 AND MONTH(flights.flight_dt) = 8 
AND flights.destination LIKE 'Шереметьево'
GROUP BY pilot.pilot_id
HAVING COUNT(flights.flight_id) = 3;

-- 2. Пилоты старше 45 лет, совершавших полеты на самолетах с 
-- количеством пассажиров больше 30.

SELECT pilot.* FROM pilot
JOIN flights ON flights.first_pilot_id = pilot.pilot_id OR flights.second_pilot_id = pilot.pilot_id
JOIN planes ON planes.plane_id = flights.plande_id AND planes.cargo_flg = 0
WHERE pilot.age > 45 AND planes.capacity > 30
GROUP BY pilot.pilot_id;

-- 3. ТОП 10 пилотов-капитанов, совершивших наибольшее число
-- грузовых перелетов в этом году.

SELECT pilot.* FROM pilot
JOIN flights ON flights.first_pilot_id = pilot.pilot_id
JOIN planes ON planes.plane_id = flights.plande_id AND planes.cargo_flg = 1
WHERE YEAR(flights.flight_dt) = 2022
GROUP BY pilot.pilot_id
ORDER BY COUNT(flights.flight_id) DESC LIMIT 10;