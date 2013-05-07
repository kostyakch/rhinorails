module Admin::PagesHelper
	def page_items(parent = nil)
		if parent.blank?
			Page.paginate(page: params[:page]).where('parent_id IS NULL')	
		else
			Page.paginate(page: params[:page]).where("parent_id = #{parent.id}")	
		end
		
	end

	def field_javascript
		<<-CODE
		$(function(){
			// Удаление параметра
			$('.del_field').click(function() {
				var row = $(this).parent().parent().parent();
				row.remove();
				return false;
			});	

			// Добавление параметра
			var paramsCount = $('#param-fields-list .controls').length;
			$('.add_field').click(function(){
				var parName = prompt ("Введите наименование параметра","");
				if(parName == null || parName == '' || parName.length < 2) {
					alert('Наименование не заполнето или содержит мешьше 2-х символов');
					return false;
				}
				var html_position = '<input id="page_page_field_attributes___name___position" name="page[page_field_attributes][__name__][position]" type="hidden" value="'+paramsCount+'">';
				var html_ftype = '<input id="page_page_field_attributes___name___ftype" name="page[page_field_attributes][__name__][ftype]" type="hidden" value="meta">';
				var html_name = '<input id="page_page_field_attributes___name___name" name="page[page_field_attributes][__name__][name]" type="hidden" value="'+parName+'">';

				var html_value = '<input class="span11" id="page_page_field_attributes___name___value" name="page[page_field_attributes][__name__][value]" size="30" type="text" value=""> <a href="#" class="del_field"><span class="icon-remove-sign"></span></a>';
				var html_label = '<label class="control-label" for="page_page_fields___name_">'+parName+'</label>';

				var newTypeWidget = html_ftype.replace(/__name__/g, paramsCount);
				var newPositionWidget = html_position.replace(/__name__/g, paramsCount);
				var newNameWidget = html_name.replace(/__name__/g, paramsCount);

				var newValieWidget = html_value.replace(/__name__/g, paramsCount);
				var newLabelWidget = html_label.replace(/__name__/g, paramsCount);
				paramsCount++;

				var newFildData = $('<div id="field_"></div>').append(newTypeWidget);
				newFildData.append(newPositionWidget);
				newFildData.append(newNameWidget);

				var newPlaceVal = $('<div class="controls"></div>').html(newValieWidget);

				var newPlaceName = $('<div class="control-group"></div>');				
				$(newPlaceName).append(newLabelWidget);
				$(newPlaceName).append(newPlaceVal);
				
				newFildData.append(newPlaceName);
				$('#param-fields-list').append(newFildData);

				return false;
			});
		})
		CODE
	end

	def tab_javascript
		<<-CODE
		$(function(){
			// добавление таба дополнительного контента
			var tabCount = $('#tabs li').length -1;
			$('#add_content').click(function() {
				var addContentName = prompt ("Введите наименование параметра","");
				if(addContentName == null || addContentName == '' || addContentName.length < 3) {
					alert('Наименование не заполнето или содержит мешьше 3-х символов');
					return false;
				}

				var html_tab  = '<li><input id="page_page_content_attributes___name___name" name="page[page_content_attributes][__name__][name]" type="hidden" value="'+addContentName+'">'+
								'<a href="#form_contents_add___name___name_tab" data-toggle="tab" rel="form_contents_add___name___name_tab">'+addContentName+' <i class="icon-remove-sign del_tab"></i></a>'+
								'</li>';
				var html_content = '<div class="tab-pane" id="form_contents_add___name___name_tab">'+
								'<textarea cols="40" id="page_page_content_attributes___name___content" name="page[page_content_attributes][__name__][content]" rows="20"></textarea></div>';

				html_tab     = html_tab.replace(/__name__/g, tabCount);
				html_content = html_content.replace(/__name__/g, tabCount);
				tabCount++;

				$('#tabs').append(html_tab);
				$('.tab-content').append(html_content);
				return false;
			});	

			// Удаление таба дополнительного контента
			$('.del_tab').click(function() {
				var delrow = $(this).parent().parent();
				var parentId = $(this).parent().attr('rel');

				if(confirm('Вы уверены что хотите удалить вкладку дополнительного контента?')) {
					$('.tab-content #'+parentId).remove();
					delrow.remove();
					return false;
				}

				return false;
			});	
		})	
		CODE
	end
end
