window.fbAsyncInit = function() {
    FB.init({
      appId      : '686308438238380', // Set YOUR APP ID
      channelUrl : '', // Channel File
      status     : true, // check login status
      cookie     : true, // enable cookies to allow the server to access the session
      xfbml      : true  // parse XFBML
    });
    FB.Event.subscribe('auth.authResponseChange', function(response) 
                       {
      if (response.status === 'connected') 
      {
        // document.getElementById("message").innerHTML +=  "<br>Connected to Facebook";
        console.log("Connected to Facebook");
        getUserInfo();

        //SUCCESS
      }    
      else if (response.status === 'not_authorized') 
      {
        document.getElementById("message").innerHTML +=  "<br>Failed to Connect";
        //FAILED
      } else 
      {
        document.getElementById("message").innerHTML +=  "<br>Logged Out";
        //UNKNOWN ERROR
      }
    }); 
  };
  function FBLogin()
  {
    FB.login(function(response) {
      if (response.authResponse) 
      {
        FB.api('/me?fields=first_name,last_name,email,id', function(response) {
          console.log(response.first_name);
          console.log(response.last_name);
          console.log(response.email);
          console.log(response.id);
          var first = response.first_name;
          var last = response.last_name;
          var email = response.email;
//          document.getElementById('first_name').value = first_name;
//          document.getElementById('last_name').value = last_name;
//          document.getElementById('email').value = email;
//          document.getElementById('fb_id').value = fb_id;
          window.location = "/p_info?email=" + email + "&first=" + first + "&last=" + last

        });
        

      } else
      {
        console.log('User cancelled login or did not fully authorize.');
      }
    },{scope: 'public_profile, email'});
  }
  (function(d){
    var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement('script'); js.id = id; js.async = true;
    js.src = "https://connect.facebook.net/en_US/all.js";
    ref.parentNode.insertBefore(js, ref);
  }(document));