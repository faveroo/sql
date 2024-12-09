SELECT d.name, ROUND(SUM((a.hours * 150) * (1 + bonus/100)), 1) as salary
FROM doctors d
INNER JOIN attendances a
ON d.id=a.id_doctor
INNER JOIN work_shifts w
ON a.id_work_shift=w.id
GROUP BY d.name
ORDER BY salary DESC
