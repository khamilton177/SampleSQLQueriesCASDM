SELECT     
dbo.call_req.ref_num AS TicketNumber,
dbo.attmnt.attmnt_name AS OriginalFileName,
dbo.attmnt.file_name AS AttachmentFileName,
dbo.attmnt.rel_file_path AS Folder

FROM        
dbo.attmnt INNER JOIN dbo.usp_lrel_attachments_requests ON dbo.attmnt.id = dbo.usp_lrel_attachments_requests.attmnt LEFT OUTER JOIN dbo.call_req ON dbo.usp_lrel_attachments_requests.cr = dbo.call_req.persid 

UNION 

SELECT     
dbo.chg.chg_ref_num AS TicketNumber,
dbo.attmnt.attmnt_name AS OriginalFileName,
dbo.attmnt.file_name AS AttachmentFileName,
dbo.attmnt.rel_file_path AS Folder

FROM
dbo.attmnt INNER JOIN dbo.usp_lrel_attachments_changes ON dbo.attmnt.id = dbo.usp_lrel_attachments_changes.attmnt LEFT OUTER JOIN dbo.chg ON dbo.usp_lrel_attachments_changes.chg = dbo.chg.id

