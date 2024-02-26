use IncrementalDB

create table File_Source
(
    FieldID int,
    FileName varchar(40),
    LastModifytime datetime
);

INSERT INTO File_Source
    (FieldID, FileName, LastModifytime)
VALUES
    (1, 'aaaa','05/06/2017 12:56:00 AM'),
    (2, 'bbbb','05/07/2019 05:23:00 PM'),
    (3, 'cccc','05/08/2021 08:35:00 AM'),
    (4, 'dddd','05/09/2022 03:20:00 PM'),
    (5, 'eeee','05/10/2022 12:35:00 AM');


create table watermarktable
(
	TableName varchar(40),
	WatermarkValue datetime
);

INSERT INTO watermarktable
VALUES ('File_Source','2019-05-07 17:23:00.000')  
--***************************************************

Select * from File_Source
Select * from watermarktable
--***************************************************

CREATE PROCEDURE usp_Update_WatermarkTable @LastModifyTime datetime, @TableName varchar(40)
AS
BEGIN

	UPDATE watermarktable
	SET [WatermarkValue] = @LastModifyTime
	WHERE [TableName] = @TableName

END

--***************************************************
Select * from File_Source
Select * from watermarktable
--***************************************************


select max(LastModifytime) as LatestDate from File_Source

--CopyData Activity -- Source Querry
select * from File_Source
where LastModifytime > 	'@{activity('Lookup_WatermarkTable').output.firstRow.WatermarkValue}'
		and
	  LastModifytime <= '@{activity('Lookup_FileSource').output.firstRow.LatestDate}'

--***********************************************************************************************
--***********************************************************************************************

INSERT INTO File_Source
    (FieldID, FileName, LastModifytime)
VALUES
    (6, 'ffff','12/06/2022 11:56:05 AM'),
    (7, 'gggg','11/07/2022 10:20:00 PM'),
	(8, 'hhhh','10/08/2022 05:45:00 PM');
--***************************************************

Select * from File_Source
Select * from watermarktable
--***************************************************

alter table watermarktable add dateColName varchar(22)


--INSERT INTO watermarktable (TableName, WatermarkValue, dateColName)


UPDATE watermarktable
SET dateColName = 'LastModifytime'
where TableName = 'File_Source'
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


create table File_Source2
(
    FieldID int,
    FileName varchar(40),
    LastModifytime2 datetime
);

INSERT INTO File_Source2
    (FieldID, FileName, LastModifytime2)
VALUES
    (1, 'aaaa','05/06/2017 12:56:00 AM'),
    (2, 'bbbb','05/08/2019 05:23:00 PM'),
    (3, 'cccc','05/08/2021 08:35:00 AM'),
    (4, 'dddd','05/09/2022 03:20:00 PM'),
    (5, 'eeee','05/10/2023 12:35:00 AM');


INSERT INTO watermarktable
    (TableName, WatermarkValue, dateColName)
VALUES
('File_Source2','2015-12-22 18:56:05.000','LastModifytime2')


Select * from File_Source
Select * from File_Source2

Select * from watermarktable
