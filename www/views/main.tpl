	<html> 
		<head>
			<title>Classfied</title>
			<style>

			</style>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>	
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
		<link rel="stylesheet" href="/static/css/chat.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>	
		<link href='https://fonts.googleapis.com/css?family=Raleway:400,500' rel='stylesheet' type='text/css'>
		<link href='https://fonts.googleapis.com/css?family=Lobster' rel='stylesheet' type='text/css'>
		<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.15/angular.min.js"></script>
		<script>
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
		</script>
		</head>
	
		<body>
		<div id ="container">	
		<div id='center'>
		
		</div>	
		<div id="signup">	
	    <form class="form-signin" method="post" role="form">
             <h2 class="form-signin-heading">Please Sign Up </h2>
             <input type="email" name="username" class="form-control" placeholder="Email address" required autofocus>
             <input type="password" name="password" class="form-control" placeholder="Password" required>
 
             <button id='signup' class="btn btn-lg btn-primary btn-block" type="button">Register </button>
         </form>
		</div>
			<div id="bottom">
				<form  id="sendCHAT" class="form-signin" method="post" role="form">
				Username: <input id="chatUSR" name="chatUSER" type="text" value="Guest">
				<button type="button" id="chatBUTTON" style="float:right;margin-left:10px;" class="btn btn-success">Chat</button>
				<input id="chatTXT" name="chatMSG" type="text" placeholder="Chat">
				</form>
			
		</div>         
		</div>

		</body>
	</html>