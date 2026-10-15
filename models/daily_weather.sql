WITH daily_weather as (

    select 
    date(time) as daily_weather,
    weather,
    temp,
    pressure,
    humidity,
    clouds 
    from {{ source('demo', 'weather') }}

    limit 10
),

daily_weather_agg as (
    select 
    daily_weather,
    weather,
    round(avg(temp), 2) as avg_temp,
    avg(pressure) as avg_pressure,
    avg(humidity) as avg_humidity,
    avg(clouds) as avg_clounds,
    count(weather)
    from daily_weather

    group by daily_weather, weather

    qualify ROW_NUMBER() OVER (PARTITION BY daily_weather ORDER BY count(weather) desc) = 1
)

select 
*
from daily_weather_agg