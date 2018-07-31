<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Send an e-mail</title>
</head>
<body>
	<form action="EmailSendingServlet" method="post" enctype="multipart/form-data">
		<table border="0" width="650px" align="center">
			<caption><h2>IDIES Orders</h2></caption>
			<tr>
				<td width = "50%"><b>Name</b></td>
				<td><input required type="text" name="name" size="50"/></td>
			</tr>
			<tr>
				<td width="50%"><b>Priority</b> </td>
				<td> <select required name="priority">
				 		<option value="" disabled selected hidden>Please Choose...</option>
					    <option value="1">Priority 1 - RUSH</option>
					    <option value="2">Priority 2 - Priority (2-3 days)</option>
					    <option value="3">Priority 3 - Important (3-5 days)</option>
					    <option value="4">Priority 4 - No Rush (10-day turnaround)</option>
					 </select>
				</td>
			</tr>
			<tr>
				<td width="50%"><b>Type of Order</b> </td>
				<td> <select required name="type">
						<option value="" disabled selected hidden>Please Choose...</option>
					    <option value="CAPP Equipment">CAPP Equipment</option>
					    <option value="Component Equipment">Component Equipment</option>
					    <option value="Supplies">Supplies</option>
					    <option value="Replacement Parts">Replacement Parts</option>
					    <option value="Service Agreement">Service Agreement</option>
					 </select>
				</td>
			</tr>
			<tr>
				<td  width="50%"><b>Account to Charge </b></td>
				<td> <select required name="account">
						<option value="" disabled selected hidden>Please Choose...</option>
					    <option value="ACCT NUMBERS 1">ACCT NUMBERS 1</option>
					    <option value="ACCT NUMBERS 2">ACCT NUMBERS 2</option>
					    <option value="ACCT NUMBERS 3">ACCT NUMBERS 3</option>
					    <option value="ACCT NUMBERS 4">ACCT NUMBERS 4</option>
					    <option value="ACCT NUMBERS 5">ACCT NUMBERS 5</option>
					 </select>
				</td>
			</tr>
			<tr>
				<td width="50%"><b>Tag Number </b></td>
				<td> <select required name="tag">
						<option value="" disabled selected hidden>Please Choose...</option>
					    <option value="No Tag">No Tag (supplies or service agreement)</option>
					    <option value="New Tag">New Tag</option>
					 </select>
				</td>
			</tr>
			<tr>
				<td width ="50%" >
					<table><tr><td width="20%"><b>Vendor</b></td><td>(new vendors require 5 business days to be set up in SAP)</td></tr></table>
				</td>
				<td><input required type="text" name="vendor" size="50"/></td>
			</tr>
			
			<tr>
				<td width="50%"><b>Is a Quote required </b></td>
				<td> <select  required name="quoteReq" id="quoteReq">
						<option value="" disabled selected hidden>Please Choose...</option>
					    <option value="Yes">Yes</option>
					    <option value="No">No</option>
					 </select>
				</td>
			</tr>
			<tr id="quoteReqFileRow">
                <td width="50%"><b>Attach quote</b> </td>
                <td><input id = "quoteReqFile" type="file" name="quoteReqFile" size="50" /></td>
            </tr>
            <tr id="quoteTypeRow">
				<td width="50%"><b>Quote Type </b></td>
				<td> <select  name="quoteType" id="quoteType">
						<option value="" disabled selected hidden>Please Choose...</option>
					    <option value="Competing Quotes">Competing Quotes</option>
					    <option value="Sole Justification">Sole Justification</option>
					 </select>
				</td>
			</tr>
			<tr id="soleJustificationRow">
				<td width="50%"><b>Sole Justification </b></td>
				<td> <select  name="soleJustification" id="soleJustification">
						<option value="" disabled selected hidden>Please Choose...</option>
					    <option value="Custom Fabrication">Custom Fabrication</option>
					    <option value="Maintain Compatibility">Maintain Compatibility</option>
					    <option value="Maintain Integrity">Maintain Integrity</option>
					    <option value="Time Senstive ">Time Senstive </option>
					 </select>
				</td>
			</tr>
			
			<tr id="soleJustificationExplanationRow">
                <td width="50%"><b>Sole Justification Explanation</b></td>
                <td><textarea rows="10" cols="39" id="soleJustificationExplanation" name="soleJustificationExplanation"></textarea></td>
            </tr>

			
			<tr>
                <td width="50%"><b>Reason for Purchase</b></td>
                <td><textarea required rows="10" cols="39" name="reason"></textarea></td>
            </tr>
            <tr>
				<td width="50%"><b>Purchase Approved </b></td>
				<td> <select  required name="approval" id="approval">
						<option value="" disabled selected hidden>Please Choose...</option>
					    <option value="Yes">Yes</option>
					    <option value="No">No</option>
					 </select>
				</td>
			</tr>
                
            <tr id="approvalEmailFileRow">
                <td width="50%"><b>Attach email of approval</b> </td>
                <td><input id = "approvalEmailFile" type="file" name="approvalEmailFile" size="50" /></td>
            </tr>
            <tr id="approverEmailRow">
				<td width = "50%"><b>Approver Email</b></td>
				<td><input type="email" name="approverEmail" id="approverEmail" size="50"/></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="Send"/></td>
			</tr>
		</table>
		
	</form>
</body>

<script>
var approval = document.getElementById("approval");
var approvalEmailFileRow = document.getElementById("approvalEmailFileRow");
var approvalEmailFile = document.getElementById("approvalEmailFile");
var approvalEmail = document.getElementById("approverEmail");
var approverEmailRow = document.getElementById("approverEmailRow");

approvalEmailFileRow.style.display="none";
approverEmailRow.style.display="none";

approval.onchange =function() {
	if(approval.value=="Yes") {
		approvalEmailFileRow.style.display="table-row";
		approvalEmailFile.required=true;
		
		approverEmailRow.style.display="none";
		approvalEmail.required=false;
	} else {
		approvalEmailFileRow.style.display="none";
		approvalEmailFile.required=false;
		
		approverEmailRow.style.display="table-row";
		approvalEmail.required=true;	
	}
	
};


var quoteReq = document.getElementById("quoteReq");
var quoteReqFileRow = document.getElementById("quoteReqFileRow");
var quoteReqFile = document.getElementById("quoteReqFile");
var quoteTypeRow = document.getElementById("quoteTypeRow");
var quoteType = document.getElementById("quoteType");
var soleJustificationRow = document.getElementById("soleJustificationRow");
var soleJustification = document.getElementById("soleJustification");
var soleJustificationExplanationRow = document.getElementById("soleJustificationExplanationRow");
var soleJustificationExplanation = document.getElementById("soleJustificationExplanation");

quoteReqFileRow.style.display="none";
quoteTypeRow.style.display="none";
soleJustificationRow.style.display="none";
soleJustificationExplanationRow.style.display="none";

quoteReq.onchange =function() {
	if(quoteReq.value=="Yes") {
		quoteReqFileRow.style.display="table-row";
		quoteReqFile.required=true;
		
		quoteTypeRow.style.display="table-row";
		quoteType.required=true;
	} else {
		quoteReqFileRow.style.display="none";
		quoteReqFile.required=false;
		
		quoteTypeRow.style.display="none";
		quoteType.required=false;
		
		quoteType.value="";
		soleJustificationRow.style.display="none";
		soleJustification.required=false;
		
		soleJustificationExplanationRow.style.display="none";
		soleJustificationExplanation.required=false;	
	}
	
};

quoteType.onchange =function() {
	if(quoteType.value=="Sole Justification") {
		soleJustificationRow.style.display="table-row";
		soleJustification.required=true;
		
		soleJustificationExplanationRow.style.display="table-row";
		soleJustificationExplanation.required=true;
	} else {
		soleJustificationRow.style.display="none";
		soleJustification.required=false;
		
		soleJustificationExplanationRow.style.display="none";
		soleJustificationExplanation.required=false;	
	}
	
};


</script>
</html>