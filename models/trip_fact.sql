WITH TRIPS as (
    select 
    RIDE_ID,
    -- RIDEABLE_TYPE,
    DATE(TO_TIMESTAMP(STARTED_AT)) AS TRIP_DATE,
    START_STATION_ID,
    END_STATION_ID,
    MEMBER_CUSAL AS MEMBER_CASUAL,
    TIMESTAMPDIFF(SECOND, TO_TIMESTAMP(STARTED_AT), to_timestamp(ENDED_AT)) AS TRIP_DURATION_SECONDS

    from {{ ref('stg_bike') }}

    where RIDE_ID != 'bike_id' and RIDE_ID != '"bike_id"' -- avoid the first row
    limit 10
)

select 
* 
from TRIPS