<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script language="javascript">
function cancle(projectId) {
	window.location.href='${ctx}/satisfaction/list?id='+projectId;
}
</script>
</head>
<body>
	<h4>我对${satisfaction.beEvaluatedName}的评价</h4>
	<form class="form-horizontal" action="${ctx}/satisfaction/edit" method="post" id ="queryForm">
		<input name="id" type="hidden" value="${satisfaction.id }" /> <input
			name="projectId" type="hidden" value="${satisfaction.projectId }" /> <input
			name="projectName" type="hidden" value="${satisfaction.projectName }" /> <input
			name="evaluatedId" type="hidden" value="${satisfaction.evaluatedId }" /> <input
			name="evaluatedName" type="hidden" value="${satisfaction.evaluatedName }" />
		<input name="evaluatedDepartmentId" type="hidden"
			value="${satisfaction.evaluatedDepartmentId}" />
			<input name="evaluatedDepartmentName" type="hidden"
			value="${satisfaction.evaluatedDepartmentName}" />
			<input name="beEvaluatedDepartmentId" type="hidden"
			value="${satisfaction.beEvaluatedDepartmentId}" />
			 <input name="beEvaluatedId"
			type="hidden" value="${satisfaction.beEvaluatedId }" /> <input
			name="evaluatedDepartmentId" type="hidden"
			value="${satisfaction.evaluatedDepartmentId }" /> <input
			name="evaluatedTime" type="hidden" value="${satisfaction.evaluatedTime }" />
		<input name="createTime" type="hidden" value="${satisfaction.createTime}" />
		<div class="control-group">
			<label class="control-label">姓名</label>
			<div class="controls">
				<input type="text" id="beEvaluatedName" name="beEvaluatedName"
					class="input-large " value="${satisfaction.beEvaluatedName}" readonly />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">部门</label>
			<div class="controls">
				<input type="text" id="beEvaluatedDepartmentName"
					name="beEvaluatedDepartmentName" class="input-large "
					value="${satisfaction.beEvaluatedDepartmentName}" readonly />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">评分</label>
			<div class="controls">
				<input type="text" id="score" name="score" class="input-large "
					value="<fmt:formatNumber value="${satisfaction.score}" type="number" maxFractionDigits="0"/>"  />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">评语</label>
			<div class="controls">
				<textarea  id="comment" name="comment" >${satisfaction.comment}</textarea>
			</div>
		</div>
		<div class="control-group">
			<div class="controls">
				<button type="submit" class="btn">保存</button>
				<button class="btn" 
					onclick="cancle(${satisfaction.projectId})">取消</button>
			</div>
		</div>
	</form>
<script type="text/javascript">
$(function() {
	 validate();
})
</script>
<script type="text/javascript">
		function validate() {
			$("#queryForm").validate({
				rules : {
					score : {
						digits : true,
						required : true,
						range : [0,${satisfaction.scoreLimit}]
					},
					comment : {
						required : true,
						maxlength:50
					},
				//createTime:{date:true}
				},
				messages : {
					leaderAssessmentScore : {
						number : "必须是数字"
					},
					efficiencyScore : {
						number : "必须是数字"
					},
					specialtyScore : {
						number : "必须是数字"
					},
					satisfactionScore : {
						number : "必须是数字"
					},
					totalScore : {
						number : "必须是数字"
					}
				},
				submitHandler : function(form) {
					//alert("submitHandler:function");
					getData(1);
				}
			});
		}
	</script>
</body>

</html>