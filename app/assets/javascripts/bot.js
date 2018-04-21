// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function() {
  function getGreetingMessage() {
    return $.ajax({
      type: "GET",
      url: '/greet',
      success: (response) => {
        $(".chat-msgs").append(`<p class='bot-msg'>${response.message}</p>`)
      }
    });
  }

  function sendUserMessage(data) {
    return $.ajax({
      type: "POST",
      url: '/message',
      data: data,
      success: (response) => {
        if (Array.isArray(response.message)) {
          response.message.forEach(function(story) {
            $(".chat-msgs").append(`<p class='bot-msg'><a target='_blank' href='${story._source.link}'><b>${story._source.title}:</b> ${story._source.description}</a></p>`);
          });
        } else {
          $(".chat-msgs").append(`<p class='bot-msg'>${response.message}</p>`);
        }
        $(".chat-msgs").scrollTop($(".chat-msgs").scrollTop() + 1000);
        $(".msg-input").prop('disabled', false).focus();
      }
    });
  }

  function handleUserMessage() {
    $(document).on("keypress", ".msg-input", function(event) {
      if (event.which === 13) {
        event.preventDefault();
        $(".msg-input").prop('disabled', true);
        var message = $(this).val().trim();
        $(".chat-msgs").append(`<p class='user-msg pull-right'>${message}</p>`);
        $(this).val('');
        sendUserMessage({ message: message });
      }
    });
  }

  getGreetingMessage();
  handleUserMessage();
})
