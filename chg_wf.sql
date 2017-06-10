SELECT
	dbo.wf.object_id,
	CHGTable.chg_ref_num AS TicketNumber,
	CHGTable.active_flag AS Active,
	CHGTable.actual_cost AS ActualCost,
	EndUserLoc.country AS EndUserCountry,
	EndUserOrg.org_name AS EndUserFunctionOrg,
	EndUser.last_name + ', ' + EndUser.first_name AS EndUserName,
	Assignees.last_name + ', ' + Assignees.first_name AS Assignee,
	AssigneesAdminOrg.org_name AS AssigneesAdminOrg,
	Assignees.department AS AssigneesDept,
	AssigneesOrg.org_name AS AssigneesFunctionOrg,
	AssigneesLoc.location_name AS AssigneesLocation,
	CABTable.last_name AS CAB,
	CHGTable.cab_approval AS CABApproval,
	CHGTable.call_back_date,
	CHGTable.category,
	CHGTable.close_date,
	dbo.usp_closure_code.sym AS ClosureCode,
	Creator.last_name + ', ' + Creator.first_name AS Createdby,
	CHGTable.description,	
	EndUserLoc.location_name AS EndUserLocation,	
	CHGTable.external_system_ticket,
	Groups.last_name AS GroupName,
	GroupsMgr.last_name + ', ' + GroupsMgr.first_name AS Groupmgr,		
	dbo.impact.sym AS Impact,
	CHGTable.last_mod_dt,
	CHGTable.need_by,
	CHGTable.open_date,
	Organization.org_name AS Organization,
	dbo.pri.sym AS Priority,
	dbo.ca_owned_resource.resource_name AS Project,
	CHGTable.parent AS Parent,
	GrpUSP.zReportingDivision,	
	Requestor.last_name + ', ' + Requestor.first_name AS Requestor,
	CHGTable.resolve_date,
	dbo.usp_risk_level.sym AS Risk,
	dbo.rootcause.sym AS Rootcause,
	CHGTable.sched_duration,
	CHGTAble.sched_end_date,
	CHGTable.sched_start_date,
	CHGTable.est_total_time,
	CHGTable.actual_total_time,
	dbo.chgstat.sym AS "Status",
	CHGTable.summary,		
	dbo.usp_change_type.sym AS ChgType,
	dbo.tskty.description AS TaskDescription,
	dbo.wf.sequence AS WorkflowSequenceNumber,
	dbo.tskstat.sym AS TaskStatus, 
	dbo.wf.completion_date AS TaskCompletionDate,
	TaskGrp.last_name AS TaskGroup,
	TaskAssignee.last_name + ', ' + TaskAssignee.first_name AS TaskAssignee,	
	DoneByTable.last_name + ', ' + DoneByTable.first_name AS DoneBy,
	dbo.tskty.sym AS TaskName
FROM
	dbo.ca_contact AS TaskAssignee
	RIGHT OUTER JOIN dbo.wf
	LEFT OUTER JOIN dbo.chg AS CHGTable ON dbo.wf.object_id = CHGTable.id
	LEFT OUTER JOIN dbo.ca_contact AS EndUser ON CHGTable.affected_contact = EndUser.contact_uuid
	LEFT OUTER JOIN dbo.ca_location AS EndUserLoc ON EndUser.location_uuid = EndUserLoc.location_uuid
	LEFT OUTER JOIN dbo.ca_organization AS EndUserOrg ON EndUser.organization_uuid = EndUserORG.organization_uuid
	LEFT OUTER JOIN dbo.ca_contact AS Assignees ON CHGTable.assignee = Assignees.contact_uuid
	LEFT OUTER JOIN dbo.ca_location AS AssigneesLoc ON Assignees.location_uuid = AssigneesLoc.location_uuid
	LEFT OUTER JOIN dbo.ca_organization AS AssigneesAdminOrg ON Assignees.admin_organization_uuid = AssigneesAdminORG.organization_uuid
	LEFT OUTER JOIN dbo.ca_organization AS AssigneesOrg ON Assignees.organization_uuid = AssigneesORG.organization_uuid
	LEFT OUTER JOIN dbo.ca_contact AS CABTable ON CHGTable.cab = CABTable.contact_uuid
	LEFT OUTER JOIN dbo.ca_contact AS Creator ON CHGTable.log_agent = Creator.contact_uuid
	LEFT OUTER JOIN dbo.ca_contact AS Groups ON CHGTable.group_id = Groups.contact_uuid
	LEFT OUTER JOIN dbo.ca_contact AS GroupsMgr ON Groups.supervisor_contact_uuid = GroupsMgr.contact_uuid
	LEFT OUTER JOIN dbo.ca_contact AS Requestor ON CHGTable.requestor = Requestor.contact_uuid
	LEFT OUTER JOIN dbo.usp_closure_code ON CHGTable.closure_code = dbo.usp_closure_code.id
	LEFT OUTER JOIN dbo.impact ON CHGTable.impact = dbo.impact.enum
	LEFT OUTER JOIN dbo.ca_organization AS Organization ON CHGTable.organization= Organization.organization_uuid
	LEFT OUTER JOIN dbo.pri ON CHGTable.priority = dbo.pri.enum
	LEFT OUTER JOIN dbo.ca_owned_resource ON CHGTable.project = dbo.ca_owned_resource.own_resource_uuid
	LEFT OUTER JOIN dbo.usp_contact AS GrpUSP ON CHGTable.group_id = GrpUSP.contact_uuid
	LEFT OUTER JOIN dbo.usp_risk_level ON CHGTable.risk = dbo.usp_risk_level.enum
	LEFT OUTER JOIN dbo.rootcause ON CHGTable.rootcause = dbo.rootcause.id
	LEFT OUTER JOIN dbo.chgstat ON CHGTable.status = dbo.chgstat.code
	LEFT OUTER JOIN dbo.usp_change_type ON CHGTable.chgtype = dbo.usp_change_type.id
	RIGHT OUTER JOIN dbo.ca_contact AS DoneByTable ON dbo.wf.done_by = DoneByTable.contact_uuid
	LEFT OUTER JOIN dbo.ca_contact AS TaskGrp ON dbo.wf.group_id = TaskGrp.contact_uuid ON TaskAssignee.contact_uuid = dbo.wf.assignee
	LEFT OUTER JOIN dbo.tskstat ON dbo.wf.status = dbo.tskstat.code
	LEFT OUTER JOIN dbo.tskty ON dbo.wf.task = dbo.tskty.code
WHERE
	(dbo.wf.object_type = 'chg')
