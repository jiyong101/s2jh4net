<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${r"${pageContext.request.contextPath}"}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<div class="row search-form-default">
		<div class="col-md-12">
			<form method="get" class="form-inline form-validation form-search form-search-init control-label-sm"
				data-grid-search="#grid-${full_entity_name_field}-index">
				<div class="form-group">
					<div class="controls controls-clearfix">
						<input type="text" name="search['CN_code_OR_name']" class="form-control input-large" placeholder="代码，名称...">
					</div>
				</div>
				<div class="form-group search-group-btn">
					<button class="btn green" type="submmit">
						<i class="m-icon-swapright m-icon-white"></i>&nbsp; 查&nbsp;询
					</button>
					<button class="btn default" type="reset">
						<i class="fa fa-undo"></i>&nbsp; 重&nbsp;置
					</button>
				</div>
			</form>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<table id="grid-${full_entity_name_field}-index"></table>
		</div>
	</div>
	
	<script type="text/javascript">
		$(function() {
		    $("#grid-${full_entity_name_field}-index").data("gridOptions", {
		        url : WEB_ROOT + '/admin${model_path}/${entity_name_field_line}/list',
		        colModel : [ {
		            label : '流水号',
		            name : 'id',
		            hidden : true                          
		        <#list entityFields as entityField> 
		        <#if entityField.list>    
		        <#if entityField.enumField>
		        }, {
		            label : '${entityField.title}',
		            name : '${entityField.fieldName}',
		            formatter : 'select',
		            searchoptions : {
		                value : Util.getCacheEnumsByType('${entityField.fieldType}')
		            },
		        <#elseif entityField.fieldType=='Entity'>
		        }, {
		            label : '${entityField.title}',
		            name : '${entityField.fieldName}.display',
		            index : '${entityField.fieldName}',
		            width : 200,
		        <#else>    
		        }, {
		            label : '${entityField.title}',
		            name : '${entityField.fieldName}',
		        </#if>              
		        <#if entityField.listWidth!=0>  
		            width : ${entityField.listWidth},
		        </#if>               
		        <#if entityField.listHidden>    
		            hidden : true,
		        </#if>  
		        <#if entityField.fieldType=='Boolean'>          
		            formatter : 'checkbox',
		        </#if>  
		        <#if entityField.fieldType=='Date'>          
		            formatter: 'date',
		        </#if>
		        <#if entityField.fieldType=='Timestamp'>          
		            formatter: 'timestamp',
		        </#if>		        
		        <#if entityField.fieldType=='BigDecimal'>          
		            formatter: 'number',
		        </#if> 
		        <#if entityField.edit>
		            editable: true,
		        </#if>                                                                    
		            align : '${entityField.listAlign}'
		        </#if>
		        </#list>
		        } ],
		        <#if fetchJoinFields?exists>
		        postData: {
		           <#list fetchJoinFields?keys as key> 
		           "search['FETCH_${key}']" : "${fetchJoinFields[key]}"<#if (key_has_next)>,</#if>
		           </#list>
		        },
		        </#if>  
		        editurl : WEB_ROOT + '/admin/${model_path}/${entity_name_field_line}/edit',
		        editrulesurl : WEB_ROOT + '/admin/util/validate?clazz=${r"${clazz}"}',
		        delurl : WEB_ROOT + '/admin${model_path}/${entity_name_field_line}/delete',
		        fullediturl : WEB_ROOT + '/admin${model_path}/${entity_name_field_line}/edit-tabs'
		    });
		});
    </script>
</body>
</html>
