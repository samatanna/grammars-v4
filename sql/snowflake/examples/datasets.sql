CREATE DATASET IF NOT EXISTS ds1;
CREATE DATASET IF NOT EXISTS sch.ds1;
CREATE DATASET IF NOT EXISTS db.sch.ds1;

ALTER DATASET ds1
ADD VERSION 'v3' FROM (
    with t as (SELECT 'c' as c) select * from t
)
PARTITION BY c
COMMENT = 'Initial version'
METADATA = '{"source":"test","created_by":"somebody"}';

ALTER DATASET IF EXISTS ds1 DROP VERSION 'v1';
ALTER DATASET IF EXISTS sch.ds1 DROP VERSION 'v1';
ALTER DATASET IF EXISTS db.sch.ds1 DROP VERSION 'v1';

SHOW DATASETS;
SHOW DATASETS LIMIT 1 FROM '';

SHOW VERSIONS LIKE 'v%' IN DATASET ds1 LIMIT 1;
SHOW VERSIONS IN DATASET ds1;
SHOW VERSIONS IN DATASET sch.ds1;
SHOW VERSIONS IN DATASET db.sch.ds1;
