create table PL_Stats(
						ADF_Name varchar(30),
						PL_Name varchar(30),
						PL_RunID varchar(30),
						WmT_StartTime datetime,
						FS_StartTime datetime,
						PL_EndTime datetime
)

select * from PL_Stats

create or alter procedure ADFPL_Executions(
											@ADF_Name varchar(30),
											@PL_Name varchar(30),
											@PL_RunID varchar(30),
											@WmT_StartTime datetime,
											@FS_StartTime datetime,
											@PL_EndTime datetime
)AS
Begin
		Insert into PL_Stats values (@ADF_Name, @PL_Name, @PL_RunID, @WmT_StartTime, @FS_StartTime, @PL_EndTime)
End


select * from File_Source
select * from watermarktable