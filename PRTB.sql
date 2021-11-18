ALTER VIEW [dbo].[z_OC_PRDQ_PRTB] AS

/*
Author: DJ
Report: Payroll Data Quality
Purpose: Optimal view for data quality items in batch


*/

SELECT
	PRTB.Co
	,PRTB.Mth
	,PRPC.PREndDate
	,PRTB.PostDate	
	,PRTB.PRDept
	,PREH.PRGroup
	,PRTB.Type
	,PRTB.Job
	,PRTB.Phase
	,PRTB.Employee
	,PREH.[Employee Name]
	,PRTB.PaySeq
	,PRTB.EarnCode
	,EDL.Description AS [EarnCode Description]
	,CONCAT(PRTB.EarnCode, ' - ', EDL.Description) AS [EarnCode + Description]
	,PRTB.Hours
	,PRTB.Rate
	,PRTB.Amt
	,EDL.Factor
	,PRTB.Shift
	,PRTB.Craft
	,PRTB.Class
	,PREH.Craft AS [PREH Craft]
	,PREH.Class AS [PREH Class]
	,'Unposted' AS [PostStatus]
	,PRTB.BatchId
FROM PRTB 
LEFT JOIN z_OC_PRDQ_PREH PREH
	ON PRTB.Co = PREH.PRCo AND PRTB.Employee = PREH.Employee
LEFT JOIN z_OC_PRDQ_EDL EDL
	ON PRTB.Co = EDL.PRCo AND PRTB.EarnCode = EDL.EDLCode AND EDL.EDLType = 'E'
LEFT JOIN PRPC
	ON PRTB.Co = PRPC.PRCo AND PREH.PRGroup = PRPC.PRGroup AND PRTB.PostDate BETWEEN PRPC.BeginDate AND PRPC.PREndDate

Go