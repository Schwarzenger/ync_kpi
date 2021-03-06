<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>效能-项目页面</title>
	<!-- 时间控件 css  -->
	<link rel="stylesheet" type="text/css" href="${ctx}/static/My97/skin/WdatePicker.css" />
	<!-- 时间控件js  -->
	<script type="text/javascript" src="${ctx}/static/My97/WdatePicker.js"></script>
	
	<!--  部门查询-->
	<script type="text/javascript" src="${ctx}/static/custom/depar.js"></script>
	
	<!-- 工时校验-->
	<script type="text/javascript" src="${ctx}/static/custom/validateT.js"></script>
	
	<script type="text/javascript">
		$(function () { 
			startPlugin.init("${ctx}");
			startPlugin.startInit();
			startPlugin.startInitParam({
				departmentId:"department_id"
			});
		});
	
		var i =0;
		function addValueFun(){  
			var h=$("td.project_table_no_cls").size()+1;
			i = i+1;
			/* h = $("#tags").find("tr").length+1; */
			var str = "<tr>"
							+"<td  class='project_table_no_cls'>"+h+"</td>"
							+"<td><select id='department_id_"+i+"' onchange='empFun(this.id)' name='efficiencyRecordBo["+i+"].departmentId' class='span2 required'><option>--请选择--</option></select></td>"
							+"<td><select id='employe_id_"+i+"' name='efficiencyRecordBo["+i+"].employeId' class='span2 required'><option>--请选择--</option></select></td>"
							+"<td>"
								+"周期："
						   	   	+"<input class='Wdate input-small required' readonly='readonly' onFocus=\"WdatePicker({lang:\'zh-cn\',dateFmt:\'yyyy-MM-dd\',minDate:\'%y-%M-%d\',maxDate:\'#F{$dp.$D(\\'efficiencyRecordBo["+i+"].planEndTime\\')}\'})\" "
								+"type='text' placeholder='—请选择—' id='efficiencyRecordBo["+i+"].planBeginTime' name='efficiencyRecordBo["+i+"].planBeginTime' />"
								+"-"
								+"<input class='Wdate input-small required' readonly='readonly' onFocus=\"WdatePicker({lang:\'zh-cn\',dateFmt:\'yyyy-MM-dd \',minDate:\'%y-%M-%d\',minDate:\'#F{$dp.$D(\\'efficiencyRecordBo["+i+"].planBeginTime\\')}\'})\""
								+"type='text' placeholder='—请选择—' id='efficiencyRecordBo["+i+"].planEndTime' name='efficiencyRecordBo["+i+"].planEndTime' />&nbsp;"
								+"工时：<input type='text' id='efficiencyRecordBo["+i+"].planHours' name='efficiencyRecordBo["+i+"].planHours' class='input-small digits workhours'  minlength='1'/>"
								
							+"</td>"
							+"<td><input type='button' value='清空' onclick='delValueFun(this)'/></td>"
						+"</tr>";
						startPlugin.startInitParam({
							departmentId:"department_id_"+i
						});
			$("#tags").append(str);
		   
		} 
		
		function delValueFun(obj){  
			$(obj).parent().parent().remove();
			genProjectTableNo();
		}
		
		function genProjectTableNo(){
			$("td.project_table_no_cls").each(function(index,element){
				$(element).html(index+1);
				
			});
			
		}
		function empFun(dep_id){
			var t = dep_id;
			var h = $("#"+t).find("option:selected").val();
		
			var first=$("#"+t );
			var second=first.parent().next().find('select')[0].id;
			
			if("" != t  ){
				$.ajax({ 
			        type: "GET", 
			       	url: "${ctx}/admin/employe/listAjax?departmentId="+h, 
			        dataType:"json", 
			        success: function(data){ 
			        		$("#"+second).html("");
			        	 	var tml = "<option  value = ''>--请选择--</option>"
				             $.each(data, function(){
				                tml += "<option value= "+this.id+">"+this.name+"</option>" ;
				             });
			        	 	$("#"+second).html(tml);
			        } ,
				});
			}
		}
		function bodyOnload() {
			/* location.reload(true); */
	
			 window.parent.location.reload();
			
		}
		
	</script>
</head>

<body >
	<form id="formId" action="${ctx}/efficiency/add" method="post"  >
		<div class="control-group">
			<label for="" class="control-label">项目名称:</label>
			<div class="controls">
				<input type="text" id="projectNameBo" name="projectNameBo" class="input-large" />
			</div>
		</div>	
		
		<br/><input type='button' value='添加相关人员' onclick='addValueFun()' class="btn"/>
		<table class="table table-striped table-bordered table-condensed">
			<thead>
			   <tr>
			   		<td>序号</td>
			   		<td>部门</td>
			   		<td>姓名</td>
			   		<td>计划时间</td>
			   		
			   		<td>操作</td>
			   </tr>
		   	</thead>
		   	<tbody id="tags"> 
			   	 <tr>
			   	   	<td class="project_table_no_cls">1</td>
			   	   	<td>
			   	   		<select id="department_id"  onchange="empFun(this.id)" name="efficiencyRecordBo[0].departmentId" class="span2 required">
							<option value=''>--请选择--</option>
						</select>
					</td>
			   	   	<td>
						<select id="employe_id" name="efficiencyRecordBo[0].employeId" class="span2 required">
							<option value = "">--请选择--</option>
						</select>
					</td>
			   	   	<td>
			   	   		周期：<input class="Wdate input-small required" readonly="readonly" onFocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd ',minDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\'efficiencyRecordBo[0].planEndTime\')}'})"
						type="text" placeholder="—请选择—" id="efficiencyRecordBo[0].planBeginTime" name="efficiencyRecordBo[0].planBeginTime" />-
						<input class="Wdate input-small required" readonly="readonly" onFocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd ',minDate:'%y-%M-%d',minDate:'#F{$dp.$D(\'efficiencyRecordBo[0].planBeginTime\')}'})" 
						type="text" placeholder="—请选择—" id="efficiencyRecordBo[0].planEndTime" name="efficiencyRecordBo[0].planEndTime"  />
						工时：<input type="text" id="efficiencyRecordBo[0].planHours" name="efficiencyRecordBo[0].planHours" class="input-small required digits workhours"  minlength="1"/>
						
					</td>
			   	   	<td><input type="button" value="清空" onclick="delValueFun(this)"/></td>
			   	  </tr> 	
		   	</tbody>
			
		</table>
		<div class="form-actions">
			<input id="submit_btn" class="btn btn-primary" type="submit" value="提交"/>&nbsp;	
			<!-- <input id="cancel_btn" class="btn" type="button" value="返回" onclick="history.back()"/> -->
		</div>
	</form>
	
	
	<script type="text/javascript">
	$(function() {
		 validate();
	})
	</script>
		<script type="text/javascript">
	function validate() {
		$("#formId").validate({
			rules : {
				projectNameBo:{
					required:true,
					minlength: 2,
					maxlength:20,
				},
			},
			messages : {
				projectNameBo:{
				    required: "必填字段",
				    minlength: jQuery.format("请输入一个长度不能小于{0}"),
				    maxlength: jQuery.format("请输入一个 长度不能超过 {0}"),
				   },
				
			},
			submitHandler:function(form){
				 form.submit();
		    }  
		});
	}
	</script>
	

</body>
</html>
