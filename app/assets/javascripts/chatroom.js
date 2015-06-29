window.client = new Faye.Client('/faye');

$(function()
{
	client.subscribe('/messages', function(payload) {
		if(payload.message) {
			time = moment(payload.created_at).format('D/M/YYYY H:mm:ss')
			$('.chat-area').find('.chat-list ul').append(
				  "<li class='me'>"
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
		}
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
		  created_at: new Date()
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
