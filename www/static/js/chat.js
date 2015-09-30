			$( document ).ready(function() {
				$('#signup').hide();
				$("#center").hide();
				$("#center").fadeIn("slow");
								
			});
			
			$(function() {
			    $('#signup').click(function() {
			        var user = $('#txtUsername').val();
			        var pass = $('#txtPassword').val();
			        $.ajax({
			            url: '/signUpUser',
			            data: $('form').serialize(),
			            type: 'POST',
			            success: function(response) {
			                console.log(response);
			            },
			            error: function(error) {
			                console.log(error);
			            }
			        });
			    });
			})		
					
		function loadchats_chat(rjson){
			
			var list=rjson.MSG;
			existing_html_update = '<div style="float:right;padding:10px;height:90%;width:30%;">';
			var left_right = "-20px";
			$.each(list, function( index, value ) {
				var name = value[1];
				var message = value[2];
				var timestamp = value[3];
				var id = value[0];
				if (left_right == '-20px'){
					existing_html_update =  existing_html_update +
					"<div style='background-size: 100% 100%;background:url("+ '"/static/img/chatbg.jpg"' + ");margin-top:10px;margin-right:10px;width:90%;border-radius:10px;background-color:#2c3e50;padding:10px;left:"+left_right+";' id='" + id + "'>" + 
					name + " <br> " +
					"<p style='text-align: right;'>" + message + "</p>" +
					timestamp + 
					"</div>";
					left_right='20px';
				}else{
					existing_html_update =  existing_html_update +
					"<div style='background-size: 100% 100%;background:url("+ '"/static/img/chatbg.jpg"' + ");margin-top:10px;margin-right:10px;width:90%;border-radius:10px;background-color:#2c3e50;padding:10px;left:"+left_right+";' id='" + id + "'>" + 
					name + " <br> " +
					"<p style='text-align: right;'>" + message + "</p>" +
					timestamp + 
					"</div>";
					left_right='-20px';				
				}
			});	
			existing_html_update = existing_html_update + "</div>"
			$("#center").html(existing_html_update);
			setTimeout(update_ui, 2000);
		}
		
		
		function update_ui(){
			        $.ajax({
			            url: '/update',
			            data: "Empty",
			            type: 'POST',
			            success: function(response) {
			            	try {
			                	var rjson = JSON.parse(response);
			                	loadchats_chat(rjson);
			                } catch(err){
			                console.log(err);
			                }
			            },
			            error: function(error) {
			                console.log(error);
			            }
			        });	
		}
			
		$(function() {
			    $('#chatBUTTON').click(function() {
					console.log('test');
			        $.ajax({
			            url: '/chat',
			            data: $('#sendCHAT').serialize(),
			            type: 'POST',
			            success: function(response) {
			                console.log(response);
			            },
			            error: function(error) {
			                console.log(error);
			            }
			        });
			    });
		})
		
		update_ui();			