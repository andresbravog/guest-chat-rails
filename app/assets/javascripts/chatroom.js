window.client = new Faye.Client('/faye');

$(function()
{
	client.subscribe('/messages', function(payload) {
		if(payload.message) {
			var time = moment(payload.created_at).format('D/M/YYYY H:mm:ss')
			  , klass =  (payload.username == DialectChat.User.username) ? "me" : ""
				, list = $('.chat-list');
			list.find('ul').append(
				  "<li class='" + klass + "'>"
				+ "	<div class='name'>"
				+ "		<span class=''>"
				+       payload.username
				+ "		</span>"
				+ "	</div>"
				+ "	<div class='message'>"
				+ "		<p>"
			  +      payload.message
				+ "   </p>"
				+ "		<span class='msg-time'>"
				+       time
				+ "   </span>"
				+ "	</div>"
				+ "</li>"
			);
			// Animate messages list to the bottom
			list.animate({ scrollTop: list.prop('scrollHeight') }, 1000);
		}
	});

	client.subscribe('/users/' + DialectChat.User.username , function(payload) {});

	client.subscribe('/users' , function(payload) {
			var klass =  (payload.username === DialectChat.User.username) ? "me" : ""
				, list = $('.user-list')
				, action = payload.action;
			switch(action) {
	    case 'add':
			    if (klass === 'me') { break; }
					if ($('#user-' + payload.username).size() > 0) { break; }
					list.append(
							"<li id='user-" + payload.username + "'>"
						+ "<a href='#'>"
						+ "	<i class='fa fa-circle-o online'></i>"
						+ "	<span>"
						+     payload.username
						+ " </span>"
						+ "</a>"
						+ "</li>"
					);
	        break;
	    case 'remove':
					if (klass === 'me') { break; }
	        $('#user-' + payload.username).remove();
	        break;
			};
	});


	// Init some form vars
	var form = $("form.new-message-form");
	var input = $('.input-area .text-area.new-message');
	var button = $('.input-area .send-btn.new-message').find("input[type='submit']");

	// Handle message creation
	form.submit(function(){
		// disable send button
		button.val('Sending...').prop('disabled', true);
		// Publish message
		publisher = client.publish('/messages', {
		  message: input.val(),
		  created_at: new Date(),
			username: DialectChat.User.username,
			dialect: DialectChat.User.dialect,
		});
		// Handle callback
		publisher.callback(function() {
		  input.val('');
		  button.val('Submit').prop('disabled', false)
		});
		// Handle error
		publisher.errback(function() {
		  alert('There was an error while sending your message.');
			button.val('Submit').prop('disabled', false);
		});
		event.preventDefault();
		return false;
	});

});
